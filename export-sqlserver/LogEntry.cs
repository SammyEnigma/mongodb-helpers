using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MongoDB.Bson;

namespace Export_SQL2Mongo
{
    class LogEntry
    {
        public ObjectId id {get; set;}
        public string idColumn {get; set;}
        public DateTime dateTimeColumn {get; set;}
        public Boolean statusBitColumn {get; set;}
    }
}
