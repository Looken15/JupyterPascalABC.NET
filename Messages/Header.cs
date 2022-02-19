using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZMQServer.Messages
{
    public class Header
    {
        public string msg_id { get; set; }
        public string msg_type { get; set; }
        public string username { get; set; }
        public string session { get; set; }
        public DateTime date { get; set; }
        public string version { get; set; }

        public Dictionary<string, object> ToDict()
        {
            var retval = new Dictionary<string, object>();
            retval.Add("msg_id", msg_id);
            retval.Add("msg_type", msg_type);
            retval.Add("username", username);
            retval.Add("session", session);
            retval.Add("date", date);
            retval.Add("version", version);
            return retval;
        }
    }
}
