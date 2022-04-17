using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace ZMQServer
{
    public static class Logger
    {
        public const string hbFilename = "hb.txt";
        public const string shellFilename = "shell.txt";
        public const string iopubFilename = "iopub.txt";
        public const string controlFilename = "control.txt";
        public const string stdinFilename = "stdin.txt";

        //private static string logPath = @"C:\Users\Tema-\Desktop\JupyterPascalABC.NET\Log\";
        //private static string logPath = @"C:\Users\barakuda\Desktop\jupyter\logs\";
        private static string logPath = null;

        public static void Init()
        {
            string exe = System.Reflection.Assembly.GetExecutingAssembly().Location;
            string exeDir = System.IO.Path.GetDirectoryName(exe);
            if (logPath == null)
                logPath = exeDir + @"\logs\";
            if (!Directory.Exists(logPath))
                Directory.CreateDirectory(logPath);
            Clear();
        }

        public static void Clear()
        {
            File.WriteAllText(logPath + hbFilename, "");
            File.WriteAllText(logPath + shellFilename, "");
            File.WriteAllText(logPath + iopubFilename, "");
            File.WriteAllText(logPath + controlFilename, "");
            File.WriteAllText(logPath + stdinFilename, "");
        }

        public static void Log(string message, string filenameTo = "commonLog.txt")
        {
            string path = logPath + filenameTo;

            message = DateTime.Now + " " + message + "\n";

            File.AppendAllText(path, message);
            if (filenameTo != "commonLog.txt")
                File.AppendAllText(logPath + "commonLog.txt", message);
        }

        public static void Log(List<string> message, string filenameTo = "commonLog.txt")
        {
            string path = logPath + filenameTo;

            var stringMessage = DateTime.Now + "\n" + string.Join('\n', message) + "\n";

            File.AppendAllText(path, stringMessage);
            if (filenameTo != "commonLog.txt")
                File.AppendAllText(logPath + "commonLog.txt", stringMessage);
        }
    }
}
