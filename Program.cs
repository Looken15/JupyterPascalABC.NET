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
    class Program
    {
        static void Main(string[] args)
        {
            Logger.Init();
            if (args.Length != 1)
            {
                Logger.Log("no arguments!");
                Environment.Exit(0);
            }
            Server server = new(args[0]);

            server.StartLoops();
        }
    }
}
