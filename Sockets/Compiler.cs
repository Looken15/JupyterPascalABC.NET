using NetMQ;
using NetMQ.Sockets;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using ZMQServer.Messages;
using static ZMQServer.Server;

namespace ZMQServer.Sockets
{
    public static class Compiler
    {
        public static SubscriberSocket outputSocket;
        public static int compilerOutputPort = 5558;
        public static string compilerOutputAddress = "tcp://127.0.0.1:" + compilerOutputPort;

        public static RequestSocket compilerSocket;
        public static int compilerPort = 5557;
        public static string compilerAddress = "tcp://127.0.0.1:"+compilerPort;

        public static Thread compilerLoop = null;
        public delegate void OutputHandler(string output);
        public static event OutputHandler? OutputReceived;

        public static Process compilerServerProcess = null;

        public static void StartLoop()
        {
            compilerLoop = new Thread(CompilerLoop);
            compilerLoop.Start();
            Logger.Log("compiler output socket started", Logger.shellFilename);
        }

        private static void CompilerLoop()
        {
            while (true)
            {
                var output = outputSocket.ReceiveFrameString();
                OutputReceived?.Invoke(output);
            }
        }

        public static void Init()
        {
            StartCompilerServer();

            compilerSocket = new RequestSocket();
            compilerSocket.Connect(compilerAddress);

            outputSocket = new SubscriberSocket();
            outputSocket.Connect(compilerOutputAddress);

            //shellSocket.Bind(shellAddress);
            //ShellMessageReceived += ShellMessageProcessing;
        }

        public static string RequestCompilation(string code)
        {
            compilerSocket.SendFrame(code);
            return compilerSocket.ReceiveFrameString();
        }

        public static void StartCompilerServer(string serverPath = "\\PABCCompiler\\ZMQServerPas.exe")
        {
            string exe = System.Reflection.Assembly.GetExecutingAssembly().Location;
            string exeDir = System.IO.Path.GetDirectoryName(exe);

            compilerServerProcess = new Process();
            compilerServerProcess.StartInfo.FileName = exeDir + serverPath;
            compilerServerProcess.StartInfo.Arguments = compilerPort.ToString() +" "+ compilerOutputPort.ToString();
            compilerServerProcess.StartInfo.UseShellExecute = false;
            compilerServerProcess.StartInfo.CreateNoWindow = true;

            compilerServerProcess.Start();
        }
    }
}
