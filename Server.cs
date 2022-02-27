using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.IO;
using System.Text.Json;
using System.Security.Cryptography;
using ZMQServer.Messages;
using NetMQ;
using NetMQ.Sockets;


namespace ZMQServer
{
    public class Server
    {
        public void StartLoops()
        {
            hbSocketLoop = new Thread(HBLoop);
            hbSocketLoop.Start();
            Logger.Log("hb socket started", Logger.hbFilename);

            shellSocketLoop = new Thread(ShellLoop);
            shellSocketLoop.Start();
            Logger.Log("shell socket started", Logger.shellFilename);
        }

        public delegate void MessageHandler(List<byte[]> identeties, List<byte[]> messageBytes);
        public event MessageHandler? ShellMessageReceived;

        private void ShellLoop()
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

        private void ShellMessageProcessing(List<byte[]> identeties, List<byte[]> messageBytes)
        {
            var message = Encode(messageBytes);
            var parentHeader = (Header)JsonSerializer.Deserialize(message[1], typeof(Header));

            Logger.Log(message, Logger.shellFilename);

            SendStatus("busy", parentHeader, identeties);

            switch (parentHeader.msg_type)
            {
                case "kernel_info_request":
                    KernelInfoRequestReply(identeties, parentHeader);
                    break;

                case "execute_request":
                    ExecuteRequestReply(identeties, parentHeader);
                    break;
                default:

                    break;
            }
            SendStatus("idle", parentHeader, identeties);
        }

        private void SendExecutionData(string data, Header parentHeader, List<byte[]> identeties)
        {
            var ourHeader = Dict("msg_id", Guid.NewGuid(),
                                         "session", global_session,
                                         "username", "username",
                                         "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                         "msg_type", "status",
                                         "version", "5.3");
            var metadata = Dict();
            var content = Dict("execution_count", executionCounter,
                                "data", Dict("text/html",data),
                                "metadata", Dict());

            foreach (var item in identeties)
            {
                iopubSocket.SendMoreFrame(item);
            }

            iopubSocket.SendMoreFrame("<IDS|MSG>");
            iopubSocket.SendMoreFrame(CreateSign(currentConnection.key,
                                                 new List<string>() {
                                                         JsonSerializer.Serialize(ourHeader),
                                                         JsonSerializer.Serialize(parentHeader.ToDict()),
                                                         JsonSerializer.Serialize(metadata),
                                                         JsonSerializer.Serialize(content)
                                                 }));
            iopubSocket.SendMoreFrame(JsonSerializer.Serialize(ourHeader));
            iopubSocket.SendMoreFrame(JsonSerializer.Serialize(parentHeader.ToDict()));
            iopubSocket.SendMoreFrame(JsonSerializer.Serialize(metadata));
            iopubSocket.SendFrame(JsonSerializer.Serialize(content));
        }

        private void ExecuteRequestReply(List<byte[]> identeties, Header parentHeader)
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

            SendExecutionData("ыыыыыыыы", parentHeader, identeties);
        }

        private void KernelInfoRequestReply(List<byte[]> identeties, Header parentHeader)
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

        private void SendStatus(string status, Header parentHeader, List<byte[]> identeties)
        {
            var ourHeader = Dict("msg_id", Guid.NewGuid(),
                                         "session", global_session,
                                         "username", "username",
                                         "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                         "msg_type", "status",
                                         "version", "5.3");
            var metadata = Dict();
            var content = Dict("execution_state", status);

            foreach (var item in identeties)
            {
                iopubSocket.SendMoreFrame(item);
            }

            iopubSocket.SendMoreFrame("<IDS|MSG>");
            iopubSocket.SendMoreFrame(CreateSign(currentConnection.key,
                                                 new List<string>() {
                                                         JsonSerializer.Serialize(ourHeader),
                                                         JsonSerializer.Serialize(parentHeader.ToDict()),
                                                         JsonSerializer.Serialize(metadata),
                                                         JsonSerializer.Serialize(content)
                                                 }));
            iopubSocket.SendMoreFrame(JsonSerializer.Serialize(ourHeader));
            iopubSocket.SendMoreFrame(JsonSerializer.Serialize(parentHeader.ToDict()));
            iopubSocket.SendMoreFrame(JsonSerializer.Serialize(metadata));
            iopubSocket.SendFrame(JsonSerializer.Serialize(content));

        }

        /// <summary>
        /// heart beat
        /// </summary>
        private void HBLoop()
        {
            while (true)
            {
                try
                {
                    var bytes = hbSocket.ReceiveFrameBytes();
                    Logger.Log("get message on hb socket", Logger.hbFilename);
                    hbSocket.SendFrame(bytes);
                }
                catch
                {
                    throw new Exception("Heartbeat");
                }
            }
        }

        private Dictionary<string, object> Dict(params object[] args)
        {
            var retval = new Dictionary<string, object>();
            for (int i = 0; i < args.Length; i += 2)
            {
                retval[args[i].ToString()] = args[i + 1];
            }
            return retval;
        }
        private string Encode(IDictionary<string, object> dict)
        {
            return JsonSerializer.Serialize(dict);
        }
        private string CreateSign(string key, List<string> args)
        {
            var sign = new HMACSHA256(Encoding.UTF8.GetBytes(key));
            sign.Initialize();
            foreach (var item in args)
            {
                var serialized = Encoding.UTF8.GetBytes(item);
                sign.TransformBlock(serialized, 0, serialized.Length, null, 0);
            }
            sign.TransformFinalBlock(new byte[0], 0, 0);
            var signature = BitConverter.ToString(sign.Hash);
            return BitConverter.ToString(sign.Hash).Replace("-", "").ToLower();
        }
        private List<string> Encode(IEnumerable<byte[]> bytes) => bytes.Select(x => Encoding.UTF8.GetString(x)).ToList();

        public string runtimePath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\jupyter\\runtime\\";
        public string connectionFilePath;
        public string jsonConnectionFile;
        public connection currentConnection;

        RouterSocket shellSocket;
        PublisherSocket iopubSocket;
        ResponseSocket hbSocket;

        string shellAddress;
        string iopubAddress;
        string hbAddress;

        Thread shellSocketLoop = null;
        Thread iopubSocketLoop = null;
        Thread hbSocketLoop = null;

        int executionCounter = 0;

        Guid global_session;


        public Server()
        {
            Init();
        }

        private void Init()
        {
            global_session = Guid.NewGuid();

            connectionFilePath = Directory.GetFiles(runtimePath, "kernel*")
                                .Select(x => new { path = x, creationTime = File.GetCreationTime(x) })
                                .OrderByDescending(x => x.creationTime)
                                .First()
                                .path;

            Logger.Log(connectionFilePath, "123.txt");

            jsonConnectionFile = File.ReadAllText(connectionFilePath);

            currentConnection = (connection)JsonSerializer.Deserialize(jsonConnectionFile, typeof(connection));

            shellSocket = new RouterSocket();
            iopubSocket = new PublisherSocket();
            hbSocket = new ResponseSocket();

            shellAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.shell_port}";
            iopubAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.iopub_port}";
            hbAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.hb_port}";

            shellSocket.Bind(shellAddress);
            iopubSocket.Bind(iopubAddress);
            hbSocket.Bind(hbAddress);

            ShellMessageReceived += ShellMessageProcessing;
        }
    }
}
