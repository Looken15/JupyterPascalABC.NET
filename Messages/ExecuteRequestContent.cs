using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZMQServer.Messages
{
    class ExecuteRequestContent
    {

        public string code { get; set; }
        public bool silent { get; set; }
        public bool store_history { get; set; }
        public User_Expressions user_expressions { get; set; }
        public bool allow_stdin { get; set; }
        public bool stop_on_error { get; set; }
    }

    public class User_Expressions
    {
    }

}
