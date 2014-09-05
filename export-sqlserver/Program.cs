using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
//Use NuGet Package manager to install the mongodbcsharpdriver: Install-Package mongocsharpdriver
using MongoDB.Bson;
using MongoDB.Driver;
using System.Diagnostics;

namespace Export_SQL2Mongo
{
    class Program
    {
        static void Main(string[] args)
        {
            //For testing purposes we used a timer
            Stopwatch timer = new Stopwatch();
            timer.Start();

            //Connection string for SQL Server.  Best practices probably put this in a settings file
            string connectionString = "user id=yourusername;" +
                                       "password=yourpassword;server=yoursqlservername;" +
                                       "database=yourdbname; " +
                                       "connection timeout=30";

            //Define the query to select data.  In our case we created a view in sql
            string query = "SELECT * FROM dbo.yourtablename";

            DataTable table = new DataTable();

            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(query, connection);
            connection.Open();

            //Here we are creating the mongodb connection string and opening the connection
            //To create multiple servers use mongodb://server1:port, server2:port, server3:port
            //You must use the DNS name that the replica is usin gin rs.conf()  Otherwise you will run into sporadic No Such Host errors.
            var mongoConnectionString = "mongodb://mongodbhostname";
            var client = new MongoClient(mongoConnectionString);
            var server = client.GetServer();
            var database = server.GetDatabase("yourmongodbdatabasename");

            //Note the <LogEntry> corresponds to our LogEntry class.  If our object was named PersonEntity we would have use <PersonEntity>
            var collection = database.GetCollection<LogEntry>("yourmongodbcollectionname");

            SqlDataReader reader = cmd.ExecuteReader();

            // Read through the SQL Server data and put the columns into the Log object
            while (reader.Read())
            {

                var logEntryObj = new LogEntry
                {
                    recId = reader["idColumnNameFromSQL_DB"].ToString()
                    ,
                    logDateTime = (DateTime)reader["dateTimeColumnNameFromSQL_DB"]
                    ,
                    logStatusBit = (Boolean)reader["statusBitColumnNameFromSQL_DB"]
                };

                //Insert the above defined object into the 
                collection.Insert(logEntryObj);
            }

            // Call Close when done reading.
            reader.Close();

            //Timer stuff. YOLO
            timer.Stop();
            TimeSpan x = timer.Elapsed;

            string runtime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}"
                , x.Hours, x.Minutes, x.Seconds, x.Milliseconds / 10);
            Console.WriteLine("Runtime " + runtime);
            Console.Read();

        }
    }
}
