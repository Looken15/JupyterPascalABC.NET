using NetMQ;
using NetMQ.Sockets;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using ZMQServer.Messages;
using static ZMQServer.Server;

namespace ZMQServer.Sockets
{
    public static class Shell
    {

        public static RouterSocket shellSocket;
        public static string shellAddress;
        public static Thread shellSocketLoop = null;
        public static event MessageHandler? ShellMessageReceived;

        public static void Init(connection currentConnection)
        {

            shellSocket = new RouterSocket();
            shellAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.shell_port}";
            shellSocket.Bind(shellAddress);
            ShellMessageReceived += ShellMessageProcessing;
        }

        public static void StartLoop()
        {
            shellSocketLoop = new Thread(ShellLoop);
            shellSocketLoop.Start();
            Logger.Log("shell socket started", Logger.shellFilename);
        }

        private static void ShellLoop()
        {
            List<byte[]> identeties = new List<byte[]>();
            List<byte[]> messageBytes = new List<byte[]>();
            while (true)
            {
                var text = "";
                while (text != "<IDS|MSG>")
                {
                    var rec = shellSocket.ReceiveFrameBytes();
                    text = Encoding.UTF8.GetString(rec);
                    if (text == "<IDS|MSG>")
                        break;
                    identeties.Add(rec);
                }

                //signature
                messageBytes.Add(shellSocket.ReceiveFrameBytes());
                //header
                messageBytes.Add(shellSocket.ReceiveFrameBytes());
                //parent header
                messageBytes.Add(shellSocket.ReceiveFrameBytes());
                //metadata
                messageBytes.Add(shellSocket.ReceiveFrameBytes());
                //content
                messageBytes.Add(shellSocket.ReceiveFrameBytes());

                ShellMessageReceived?.Invoke(identeties, messageBytes);

                identeties.Clear();
                messageBytes.Clear();
            }
        }

        private static void ShellMessageProcessing(List<byte[]> identeties, List<byte[]> messageBytes)
        {
            var message = Encode(messageBytes);
            var parentHeader = (Header)JsonSerializer.Deserialize(message[1], typeof(Header));

            shellIdenteties = identeties;
            shellParentHeader = parentHeader;

            Logger.Log(message, Logger.shellFilename);

            Iopub.SendStatus("busy", parentHeader, identeties);

            switch (parentHeader.msg_type)
            {
                case "kernel_info_request":
                    KernelInfoRequestReply(identeties, parentHeader);
                    break;

                case "execute_request":
                    var content = (ExecuteRequestContent)JsonSerializer.Deserialize(message[4], typeof(ExecuteRequestContent));
                    ExecuteRequestReply(content, identeties, parentHeader);
                    break;
                default:

                    break;
            }
            Iopub.SendStatus("idle", parentHeader, identeties);
        }

        private static void ExecuteRequestReply(ExecuteRequestContent requestContent, List<byte[]> identeties, Header parentHeader)
        {
            var metadata = Dict();
            var content = Dict("status", "ok",
                                "execution_count", ++executionCounter);
            var ourHeader = Dict("msg_id", Guid.NewGuid(),
                                 "session", global_session,
                                 "username", "username",
                                 "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                 "msg_type", "execute_reply",
                                 "version", "5.3");

            foreach (var item in identeties)
            {
                shellSocket.SendMoreFrame(item);
            }
            shellSocket.SendMoreFrame("<IDS|MSG>");
            shellSocket.SendMoreFrame(CreateSign(currentConnection.key,
                                                 new List<string>() {
                                                                 JsonSerializer.Serialize(ourHeader),
                                                                 JsonSerializer.Serialize(parentHeader.ToDict()),
                                                                 JsonSerializer.Serialize(metadata),
                                                                 JsonSerializer.Serialize(content)
                                                 }));
            shellSocket.SendMoreFrame(JsonSerializer.Serialize(ourHeader));
            shellSocket.SendMoreFrame(JsonSerializer.Serialize(parentHeader.ToDict()));
            shellSocket.SendMoreFrame(JsonSerializer.Serialize(metadata));
            shellSocket.SendFrame(JsonSerializer.Serialize(content));

            //создаём временный .pas файл

            File.WriteAllText(Environment.CurrentDirectory + $"\\PABCCompiler\\temp\\temp_{global_session}.pas", "uses RedirectIOMode1;\n");
            File.AppendAllText(Environment.CurrentDirectory + $"\\PABCCompiler\\temp\\temp_{global_session}.pas", requestContent.code);

            var pasPath = Environment.CurrentDirectory + $"\\PABCCompiler\\temp\\temp_{global_session}.pas";
            var exePath = Environment.CurrentDirectory + $"\\PABCCompiler\\temp\\temp_{global_session}.exe";

            var tempProc = new Process();
            tempProc.StartInfo.FileName = Environment.CurrentDirectory + $"\\PABCCompiler\\PABCCompiler.exe";
            tempProc.StartInfo.Arguments = pasPath;
            tempProc.StartInfo.UseShellExecute = false;
            tempProc.StartInfo.CreateNoWindow = true;
            tempProc.StartInfo.RedirectStandardOutput = true;
            tempProc.StartInfo.RedirectStandardError = true;
            tempProc.StartInfo.RedirectStandardInput = true;
            tempProc.StartInfo.StandardErrorEncoding = Encoding.Default;
            tempProc.StartInfo.StandardInputEncoding = Encoding.Default;
            tempProc.StartInfo.StandardOutputEncoding = Encoding.Default;
            var isUpdate = false;
            var id = new Random().Next(1000).ToString();                                //костыль
            tempProc.OutputDataReceived += new DataReceivedEventHandler((s, e) =>
            {
                if (e.Data != null)
                {
                    var dataBytes = Encoding.UTF8.GetBytes(e.Data);
                    var encodedBytes = Encoding.Convert(Encoding.UTF8, Encoding.Default, dataBytes);
                    var encodedData = Encoding.Default.GetString(encodedBytes);
                    File.Delete(pasPath);
                    Iopub.SendDisplayData(encodedData, parentHeader, identeties, false, id);
                    return;
                }
            });

            tempProc.ErrorDataReceived += new DataReceivedEventHandler((s, e) =>
            {
                if (e.Data != null)
                {
                    var dataBytes = Encoding.UTF8.GetBytes(e.Data);
                    var encodedBytes = Encoding.Convert(Encoding.UTF8, Encoding.Default, dataBytes);
                    var encodedData = Encoding.Default.GetString(encodedBytes);
                    File.Delete(pasPath);
                    Iopub.SendDisplayData(encodedData, parentHeader, identeties, false, id);
                    return;
                }
            });

            tempProc.Start();

            tempProc.WaitForExit();

            if (!File.Exists(exePath))
            {
                Iopub.SendDisplayData("Ошибка компиляции!", parentHeader, identeties, false, id);
                return;
            }

            proc = new Process();
            proc.StartInfo.FileName = exePath;
            proc.StartInfo.WorkingDirectory = Environment.CurrentDirectory + $"\\PABCCompiler\\temp\\";
            proc.StartInfo.UseShellExecute = false;
            proc.StartInfo.CreateNoWindow = true;
            proc.StartInfo.RedirectStandardOutput = true;
            proc.StartInfo.RedirectStandardError = true;
            proc.StartInfo.RedirectStandardInput = true;
            proc.StartInfo.StandardErrorEncoding = Encoding.Default;
            proc.StartInfo.StandardInputEncoding = Encoding.Default;
            proc.StartInfo.StandardOutputEncoding = Encoding.Default;
            
            proc.OutputDataReceived += new DataReceivedEventHandler((s, e) =>
            {
                if (e.Data != null)
                {
                    var dataBytes = Encoding.UTF8.GetBytes(e.Data);
                    var encodedBytes = Encoding.Convert(Encoding.UTF8, Encoding.Default, dataBytes);
                    var encodedData = Encoding.Default.GetString(encodedBytes);
                    //Iopub.SendExecutionData(encodedData, parentHeader, identeties);
                    
                    //Iopub.SendExecutionData(encodedData, parentHeader, identeties);

                    Iopub.SendDisplayData(encodedData, parentHeader, identeties, isUpdate, id);
                    isUpdate = true;
                   
                    //Thread.Sleep(5000);
                    //Iopub.SendDisplayData("<script>var cx = document.getElementById(\"plotterCanvas\").getContext(\"2d\");" +
                    //                            "cx.fillStyle = \"rgb(255,0,0)\"" +
                    //                            "cx.fillRect(0,0,400,400);</script>", parentHeader, identeties,true,id);
                    //Iopub.SendExecutionData("<script>alert('Hello, world')</script>", parentHeader, identeties);
                }
            });

            proc.ErrorDataReceived += new DataReceivedEventHandler((s, e) =>
            {
                if (e.Data == "[READLNSIGNAL]")
                {
                    Stdin.SendInputRequest(parentHeader, identeties);
                }
            });

            proc.Start();

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            inputStream = new StreamWriter(proc.StandardInput.BaseStream, Encoding.GetEncoding("cp866"));
            inputStream.AutoFlush = true;
            proc.BeginOutputReadLine();
            proc.BeginErrorReadLine();

            proc.WaitForExit();

            File.Delete(pasPath);
            File.Delete(exePath);
            //TODO: Прерывать выполнение программы
            //TODO: Сервер
        }

        private static void KernelInfoRequestReply(List<byte[]> identeties, Header parentHeader)
        {
            var metadata = Dict();
            var content = Dict("status", "ok",
                        "protocol_version", "5.3",
                        "implementation", "jupyterPascal",
                        "implementation_version", "0.0.1",
                        "language_info", Dict("name", "PascalABC.NET",
                                              "version", "1.0",
                                              "mimetype", "html\\text",
                                              "file_extension", ".pas"),
                        "banner", "Hello World!");
            var ourHeader = Dict("msg_id", Guid.NewGuid(),
                                 "session", global_session,
                                 "username", "username",
                                 "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                 "msg_type", "kernel_info_reply",
                                 "version", "5.3");

            foreach (var item in identeties)
            {
                shellSocket.SendMoreFrame(item);
            }
            shellSocket.SendMoreFrame("<IDS|MSG>");
            shellSocket.SendMoreFrame(CreateSign(currentConnection.key,
                                                 new List<string>() {
                                                                 JsonSerializer.Serialize(ourHeader),
                                                                 JsonSerializer.Serialize(parentHeader.ToDict()),
                                                                 JsonSerializer.Serialize(metadata),
                                                                 JsonSerializer.Serialize(content)
                                                 }));
            shellSocket.SendMoreFrame(JsonSerializer.Serialize(ourHeader));
            shellSocket.SendMoreFrame(JsonSerializer.Serialize(parentHeader.ToDict()));
            shellSocket.SendMoreFrame(JsonSerializer.Serialize(metadata));
            shellSocket.SendFrame(JsonSerializer.Serialize(content));
        }
    }
}
