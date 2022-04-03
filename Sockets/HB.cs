using NetMQ;
using NetMQ.Sockets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using ZMQServer.Messages;

namespace ZMQServer.Sockets
{
    public static class HB
    {

        public static ResponseSocket hbSocket;
        public static string hbAddress;
        public static Thread hbSocketLoop = null;

        public static void Init(connection currentConnection)
        {

            hbSocket = new ResponseSocket();
            hbAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.hb_port}";
            hbSocket.Bind(hbAddress);
        }

        public static void StartLoop()
        {
            hbSocketLoop = new Thread(HBLoop);
            hbSocketLoop.Start();
            Logger.Log("hb socket started", Logger.hbFilename);
        }

        private static void HBLoop()
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
    }
}
