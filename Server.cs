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
using System.Diagnostics;
using ZMQServer.Sockets;

namespace ZMQServer
{
    public class Server
    {
        public void StartLoops()
        {
            HB.StartLoop();
            Stdin.StartLoop();
            Control.StartLoop();
            Shell.StartLoop();
            Compiler.StartLoop();
        }

        public delegate void MessageHandler(List<byte[]> identeties, List<byte[]> messageBytes);

        public static Process proc;

        public static Dictionary<string, object> Dict(params object[] args)
        {
            var retval = new Dictionary<string, object>();
            for (int i = 0; i < args.Length; i += 2)
            {
                retval[args[i].ToString()] = args[i + 1];
            }
            return retval;
        }
        public static string Encode(IDictionary<string, object> dict)
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
        public static List<string> Encode(IEnumerable<byte[]> bytes) => bytes.Select(x => Encoding.UTF8.GetString(x)).ToList();

        public string runtimePath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\jupyter\\runtime\\";
        public string connectionFilePath;
        public string jsonConnectionFile;
        public static connection currentConnection;
        public static int executionCounter = 0;

        public static Guid global_session;

        public static StreamWriter inputStream = null;

        public static List<byte[]> shellIdenteties;
        public static Header shellParentHeader;


        public Server(string connectionFile = "")
        {
            global_session = Guid.NewGuid();

            if (connectionFile == "")
            {
                connectionFilePath = Directory.GetFiles(runtimePath, "kernel*")
                                    .Select(x => new { path = x, creationTime = File.GetCreationTime(x) })
                                    .OrderByDescending(x => x.creationTime)
                                    .First()
                                    .path;
            }
            else
            {
                connectionFilePath = connectionFile;
            }

            Logger.Log(connectionFilePath, "123.txt");

            jsonConnectionFile = File.ReadAllText(connectionFilePath);

            currentConnection = (connection)JsonSerializer.Deserialize(jsonConnectionFile, typeof(connection));

            Stdin.Init(currentConnection);
            Control.Init(currentConnection);
            HB.Init(currentConnection);
            Shell.Init(currentConnection);
            Iopub.Init(currentConnection);
            Compiler.Init();

            shellIdenteties = new List<byte[]>();
            shellParentHeader = new Header();
        }
    }
}
