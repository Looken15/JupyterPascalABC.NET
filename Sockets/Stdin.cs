using NetMQ;
using NetMQ.Sockets;
using System;
using System.Collections.Generic;
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
    public static class Stdin
    {
        public static RouterSocket stdinSocket;
        public static string stdinAddress;
        public static Thread stdinSocketLoop = null;
        public static event MessageHandler? StdinMessageReceived;

        public static void Init(connection currentConnection)
        {
            stdinSocket = new RouterSocket();
            stdinAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.stdin_port}";
            stdinSocket.Bind(stdinAddress);
            StdinMessageReceived += StdinMessageProcessing;
        }

        public static void StartLoop()
        {
            stdinSocketLoop = new Thread(StdinLoop);
            stdinSocketLoop.Start();
            Logger.Log("stdin socket started", Logger.stdinFilename);
        }

        private static void StdinLoop()
        {
            List<byte[]> identeties = new List<byte[]>();
            List<byte[]> messageBytes = new List<byte[]>();
            while (true)
            {
                var text = "";
                while (text != "<IDS|MSG>")
                {
                    var rec = stdinSocket.ReceiveFrameBytes();
                    text = Encoding.UTF8.GetString(rec);
                    if (text == "<IDS|MSG>")
                        break;
                    identeties.Add(rec);
                }

                //signature
                messageBytes.Add(stdinSocket.ReceiveFrameBytes());
                //header
                messageBytes.Add(stdinSocket.ReceiveFrameBytes());
                //parent header
                messageBytes.Add(stdinSocket.ReceiveFrameBytes());
                //metadata
                messageBytes.Add(stdinSocket.ReceiveFrameBytes());
                //content
                messageBytes.Add(stdinSocket.ReceiveFrameBytes());

                StdinMessageReceived?.Invoke(identeties, messageBytes);

                identeties.Clear();
                messageBytes.Clear();
            }
        }

        public static void SendInputRequest(Header parentHeader, List<byte[]> identeties)
        {
            var ourHeader = Dict("msg_id", Guid.NewGuid(),
                                         "session", global_session,
                                         "username", "username",
                                         "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                         "msg_type", "input_request",
                                         "version", "5.3");
            var metadata = Dict();
            var content = Dict("prompt", "",
                               "password", 0);

            foreach (var item in identeties)
            {
                stdinSocket.SendMoreFrame(item);
            }

            stdinSocket.SendMoreFrame("<IDS|MSG>");
            stdinSocket.SendMoreFrame(CreateSign(currentConnection.key,
                                                 new List<string>() {
                                                         JsonSerializer.Serialize(ourHeader),
                                                         JsonSerializer.Serialize(parentHeader.ToDict()),
                                                         JsonSerializer.Serialize(metadata),
                                                         JsonSerializer.Serialize(content)
                                                 }));
            stdinSocket.SendMoreFrame(JsonSerializer.Serialize(ourHeader));
            stdinSocket.SendMoreFrame(JsonSerializer.Serialize(parentHeader.ToDict()));
            stdinSocket.SendMoreFrame(JsonSerializer.Serialize(metadata));
            stdinSocket.SendFrame(JsonSerializer.Serialize(content));
        }

        private static void StdinMessageProcessing(List<byte[]> identeties, List<byte[]> messageBytes)
        {
            //inputStream = new StreamWriter(proc.StandardInput.BaseStream, Encoding.GetEncoding("cp866"));
            var message = Encode(messageBytes);
            var content = message[4];
            var dict = JsonSerializer.Deserialize<Dictionary<string, string>>(content);
            //inputStream.WriteLine(dict["value"]);
            Compiler.InputToCompiler(dict["value"]);
            //inputStream.Close();
        }

        private static void StdinMessageProcessing_old(List<byte[]> identeties, List<byte[]> messageBytes)
        {
            //inputStream = new StreamWriter(proc.StandardInput.BaseStream, Encoding.GetEncoding("cp866"));
            var message = Encode(messageBytes);
            var content = message[4];
            var dict = JsonSerializer.Deserialize<Dictionary<string, string>>(content);
            inputStream.WriteLine(dict["value"]);
            //inputStream.Close();
        }
    }
}
