using NetMQ;
using NetMQ.Sockets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using ZMQServer.Messages;

namespace ZMQServer.Sockets
{
    public static class Iopub
    {

        public static PublisherSocket iopubSocket;
        public static string iopubAddress;
        public static Thread iopubSocketLoop = null;

        public static void Init(connection currentConnection)
        {
            iopubSocket = new PublisherSocket();
            iopubAddress = $"{currentConnection.transport}://{currentConnection.ip}:{currentConnection.iopub_port}";
            iopubSocket.Bind(iopubAddress);
        }

        public static void SendExecutionData(string data, Header parentHeader, List<byte[]> identeties)
        {
            var ourHeader = Server.Dict("msg_id", Guid.NewGuid(),
                                         "session", Server.global_session,
                                         "username", "username",
                                         "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                         "msg_type", "execute_result",
                                         "version", "5.3");
            var metadata = Server.Dict();
            var content = Server.Dict("execution_count", Server.executionCounter,
                                "data", Server.Dict("text/html", data),
                                "metadata", Server.Dict());

            foreach (var item in identeties)
            {
                iopubSocket.SendMoreFrame(item);
            }

            Logger.Log(JsonSerializer.Serialize(ourHeader), "iopub.txt");
            Logger.Log(JsonSerializer.Serialize(parentHeader.ToDict()), "iopub.txt");
            Logger.Log(JsonSerializer.Serialize(metadata), "iopub.txt");
            Logger.Log(JsonSerializer.Serialize(content), "iopub.txt");

            iopubSocket.SendMoreFrame("<IDS|MSG>");
            iopubSocket.SendMoreFrame(Server.CreateSign(Server.currentConnection.key,
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

        public static void SendStatus(string status, Header parentHeader, List<byte[]> identeties)
        {
            var ourHeader = Server.Dict("msg_id", Guid.NewGuid(),
                                         "session", Server.global_session,
                                         "username", "username",
                                         "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                         "msg_type", "status",
                                         "version", "5.3");
            var metadata = Server.Dict();
            var content = Server.Dict("execution_state", status);

            foreach (var item in identeties)
            {
                iopubSocket.SendMoreFrame(item);
            }

            iopubSocket.SendMoreFrame("<IDS|MSG>");
            iopubSocket.SendMoreFrame(Server.CreateSign(Server.currentConnection.key,
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

        public static void ClearOutput()
        {
            var identeties = Server.shellIdenteties;
            var parentHeader = Server.shellParentHeader;

            var ourHeader = Server.Dict("msg_id", Guid.NewGuid(),
                                         "session", Server.global_session,
                                         "username", "username",
                                         "date", DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.ffffff"),
                                         "msg_type", "clear_output",
                                         "version", "5.3");
            var metadata = Server.Dict();
            var content = Server.Dict("wait", "false");

            foreach (var item in identeties)
            {
                iopubSocket.SendMoreFrame(item);
            }

            iopubSocket.SendMoreFrame("<IDS|MSG>");
            iopubSocket.SendMoreFrame(Server.CreateSign(Server.currentConnection.key,
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

            SendExecutionData("", parentHeader, identeties);
            Server.executionCounter--;
        }

    }
}
