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
        public static PushSocket heartbeatSocket;
        public static int heartbeatPort = 5554;
        public static string heartbeatAddress = "tcp://*:" + heartbeatPort;
        public static Thread heartbeatLoop = null;

        public static PushSocket inputSocket;
        public static int compilerInputPort = 5555;
        public static string compilerInputAddress = "tcp://*:" + compilerInputPort;

        public static PullSocket outputSocket;
        public static int compilerOutputPort = 5556;
        public static string compilerOutputAddress = "tcp://*:" + compilerOutputPort;

        public static RequestSocket compilerSocket;
        public static int compilerPort = 5557;
        public static string compilerAddress = "tcp://*:" + compilerPort;

        public static Thread compilerLoop = null;
        public delegate void OutputHandler(string output);
        public static event OutputHandler? OutputReceived;

        public static Process compilerServerProcess = null;

        public static void StartLoop()
        {
            compilerLoop = new Thread(CompilerLoop);
            compilerLoop.Start();

            heartbeatLoop = new Thread(HeartBeatLoop);
            heartbeatLoop.Start();

            OutputReceived += Shell.TempOutput;
        }

        private static void CompilerLoop()
        {
            while (true)
            {
                var output = outputSocket.ReceiveFrameString();
                OutputReceived?.Invoke(output);
            }
        }

        private static void HeartBeatLoop()
        {
            while (true)
            {
                heartbeatSocket.SendFrame("[ALIVE]");
                Thread.Sleep(1000);    
            }
        }

        public static void Init()
        {
            inputSocket = new PushSocket();
            inputSocket.Bind(compilerInputAddress);

            compilerSocket = new RequestSocket();
            compilerSocket.Bind(compilerAddress);

            outputSocket = new PullSocket();
            outputSocket.Bind(compilerOutputAddress);

            heartbeatSocket = new PushSocket();
            heartbeatSocket.Bind(heartbeatAddress);

            StartCompilerServer();
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
            compilerServerProcess.StartInfo.Arguments = compilerPort.ToString() +" "+ compilerOutputPort.ToString()+" "+compilerInputPort.ToString()+" "+heartbeatPort.ToString();
            compilerServerProcess.StartInfo.UseShellExecute = false;
            compilerServerProcess.StartInfo.CreateNoWindow = true;

            compilerServerProcess.Start();
        }

        public static void InputToCompiler(string input)
        {
            inputSocket.SendFrame(input);
        }
    }
}
