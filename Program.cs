using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.Json;
using System.Security.Cryptography;
using ZMQServer.Messages;
using NetMQ;
using NetMQ.Sockets;

namespace ZMQServer
{
    class Program
    {
        public static string logPath = "C:\\Users\\Tema-\\Desktop\\JupyterPascalABC.NET\\log.txt";
        public static string appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
        public static string runtimePath = appDataPath + "\\jupyter\\runtime\\";
        static void Main(string[] args)
        {
            var connectionFilePath = Directory.GetFiles(runtimePath, "kernel*")
                                    .Select(x => new { path = x, creationTime = File.GetCreationTime(x) })
                                    .OrderByDescending(x => x.creationTime)
                                    .First()
                                    .path;

            var jsonConnectionFile = File.ReadAllText(connectionFilePath);

            var currentConnection = (connection)JsonSerializer.Deserialize(jsonConnectionFile, typeof(connection));

            //File.AppendAllText(logPath, currentConnection.hb_port.ToString());

            var shellSocket = new RouterSocket();
            var iopubSocket = new PublisherSocket();
            var hbSocket = new ResponseSocket();

            var shellAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.shell_port}";
            var iopubAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.iopub_port}";
            var hbAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.hb_port}";

            shellSocket.Bind(shellAddress);
            iopubSocket.Bind(iopubAddress);
            hbSocket.Bind(hbAddress);

            var msgCounter = 0;
            string HMACsignature = "";

            string headerString = "";
            string parentHeaderString = "";
            string metadataString = "";
            string contentString = "";

            List<byte[]> identeties = new List<byte[]>();

            while (true)
            {
                if (hbSocket.TryReceiveFrameBytes(out var hb))
                    File.AppendAllText(logPath, Encoding.UTF8.GetString(hb));

                var text = "";
                var rec = new byte[1000];

                while (text != "<IDS|MSG>")
                {
                    rec = shellSocket.ReceiveFrameBytes();
                    text = Encoding.UTF8.GetString(rec);
                    if (text == "<IDS|MSG>")
                    {
                        break;
                    }
                    identeties.Add(rec);
                }

                //signature
                rec = shellSocket.ReceiveFrameBytes();
                text = Encoding.UTF8.GetString(rec);
                HMACsignature = text;

                //header
                rec = shellSocket.ReceiveFrameBytes();
                headerString = Encoding.UTF8.GetString(rec);
                var serializedHeader = (Header)JsonSerializer.Deserialize(headerString, typeof(Header));

                //parent header
                rec = shellSocket.ReceiveFrameBytes();
                parentHeaderString = Encoding.UTF8.GetString(rec);

                //metadata
                rec = shellSocket.ReceiveFrameBytes();
                metadataString = Encoding.UTF8.GetString(rec);

                //content
                rec = shellSocket.ReceiveFrameBytes();
                contentString = Encoding.UTF8.GetString(rec);

                switch (serializedHeader.msg_type)
                {
                    case "kernel_info_request":
                        var metadata = dict();
                        var content = dict("status", "ok",
                                    "protocol_version", "5.3.0",
                                    "implementation", "jupyterPascal",
                                    "implementation_version", "0.0.1",
                                    "language_info", dict("name", "PascalABC.NET",
                                                          "version", "1.0",
                                                          "mimetype", "html\\text",
                                                          "file_extension", ".pas"),
                                    "banner", "Hello World!");
                        var ourHeader = dict("msg_id", Guid.NewGuid(),
                                             "session", serializedHeader.session,
                                             "username", "username",
                                             "date", DateTime.Now,
                                             "msg_type", "kernel_info_reply",
                                             "version", "5.3.0");
                        var parentHeader = serializedHeader;

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
                        break;
                    default:

                        break;
                }



                msgCounter++;
            }
        }

        public static Dictionary<string, object> dict(params object[] args)
        {
            var retval = new Dictionary<string, object>();
            for (int i = 0; i < args.Length; i += 2)
            {
                retval[args[i].ToString()] = args[i + 1];
            }
            return retval;
        }

        public static string encode(IDictionary<string, object> dict)
        {
            return JsonSerializer.Serialize(dict);
        }

        public static string CreateSign(string key, List<string> args)
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
    }
}
