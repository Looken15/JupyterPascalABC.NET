using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.Json;
using NetMQ;
using NetMQ.Sockets;

namespace ZMQServer
{
    class Program
    {
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

            File.AppendAllText("C:\\Users\\Tema-\\Desktop\\ZMQExample\\ZMQServer\\log.txt", currentConnection.hb_port.ToString());

            using (var socket = new ResponseSocket())
            {
                var address = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.hb_port}";
                socket.Connect(address);

                while (true)
                {
                    File.AppendAllText("C:\\Users\\Tema-\\Desktop\\ZMQExample\\ZMQServer\\log.txt", "receiving\n");
                    var data = socket.ReceiveFrameBytes();
                    File.AppendAllText("C:\\Users\\Tema-\\Desktop\\ZMQExample\\ZMQServer\\log.txt", Convert.ToBase64String(data) + "\n");
                    socket.SendFrame(data);
                }
            }
        }
    }
}
