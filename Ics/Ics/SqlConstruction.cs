using Npgsql;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Ics
{
    class SqlConstruction
    {
        static string dir = Path.Combine("E:", "data", "school", "ICSystem", "data");
        public static int Construction(string connStr, string opt)
        {
            // SQL処理で用いる変数を予め宣言
            NpgsqlCommand cmd = null;
            switch (opt)
            {
                case "ap":
                    //TransactionScopeの利用
                    using (TransactionScope ts = new TransactionScope())
                    {
                        using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
                        {
                            conn.Open();

                            cmd = new NpgsqlCommand("DROP TABLE IF EXISTS ap_table;" +

                                "DROP SEQUENCE IF EXISTS ap_id_seq;" +

                                "CREATE SEQUENCE ap_id_seq " +
                                "INCREMENT BY 1 " +
                                "START WITH 1 " +
                                "NO CYCLE;" +

                                "CREATE TABLE IF NOT EXISTS " +
                                "ap_table (id int NOT NULL DEFAULT nextval('ap_id_seq'::regclass)," +
                                "ap_name varchar," +
                                "ap_floor int," +
                                "ap_x float," +
                                "ap_y float," +
                                "ap_y_floor float," +
                                "ap_y_height float," +
                                "CONSTRAINT ap_pkc PRIMARY KEY (id));", conn);
                            cmd.ExecuteNonQuery();

                            string apFile = Path.Combine(dir, "AP_coordinate.csv");
                            using (var writer = conn.BeginTextImport("COPY ap_table (ap_name," +
                                "ap_floor," +
                                "ap_x," +
                                "ap_y," +
                                "ap_y_floor," +
                                "ap_y_height) FROM STDIN WITH CSV HEADER"))
                            {
                                writer.Write(File.ReadAllText(apFile, Encoding.GetEncoding("UTF-8")));
                            }
                        }
                        ts.Complete();
                    }
                    break;
                case "location":
                    //TransactionScopeの利用
                    using (TransactionScope ts = new TransactionScope())
                    {
                        using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
                        {
                            conn.Open();

                            cmd = new NpgsqlCommand("DROP TABLE IF EXISTS location_table;" +

                                "DROP SEQUENCE IF EXISTS location_id_seq;" +

                                "CREATE SEQUENCE location_id_seq " +
                                "INCREMENT BY 1 " +
                                "START WITH 1 " +
                                "NO CYCLE;" +

                                "CREATE TABLE IF NOT EXISTS " +
                                "location_table (id int NOT NULL DEFAULT nextval('location_id_seq'::regclass)," +
                                "location_floor int," +
                                "building varchar," +
                                "location varchar," +
                                "location_x float," +
                                "location_y float," +
                                "location_y_floor float," +
                                "location_y_height float," +
                                "CONSTRAINT location_pkc PRIMARY KEY (id));", conn);
                            cmd.ExecuteNonQuery();

                            string locationFile = Path.Combine(dir, "location_coordinate_3F.csv");
                            using (var writer = conn.BeginTextImport("COPY location_table (" +
                                "location_floor," +
                                "building," +
                                "location," +
                                "location_x," +
                                "location_y," +
                                "location_y_floor," +
                                "location_y_height) FROM STDIN WITH CSV HEADER"))
                            {
                                writer.Write(File.ReadAllText(locationFile, Encoding.GetEncoding("UTF-8")));
                            }

                            locationFile = Path.Combine(dir, "location_coordinate_4F.csv");
                            using (var writer = conn.BeginTextImport("COPY location_table (" +
                                "location_floor," +
                                "building," +
                                "location," +
                                "location_x," +
                                "location_y," +
                                "location_y_floor," +
                                "location_y_height) FROM STDIN WITH CSV HEADER"))
                            {
                                writer.Write(File.ReadAllText(locationFile, Encoding.GetEncoding("UTF-8")));
                            }
                        }
                        ts.Complete();
                    }
                    break;
                case "measured":
                    //TransactionScopeの利用
                    using (TransactionScope ts = new TransactionScope())
                    {
                        using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
                        {
                            conn.Open();

                            cmd = new NpgsqlCommand("DROP TABLE IF EXISTS measured_table;" +

                                "DROP SEQUENCE IF EXISTS measured_id_seq;" +

                                "CREATE SEQUENCE measured_id_seq " +
                                "INCREMENT BY 1 " +
                                "START WITH 1 " +
                                "NO CYCLE;" +

                                "CREATE TABLE IF NOT EXISTS " +
                                "measured_table (id int NOT NULL DEFAULT nextval('measured_id_seq'::regclass)," +
                                "location_floor int," +
                                "location varchar," +
                                "ave_dBm float," +
                                "med_dBm float," +
                                "center_freq_MHz int," +
                                "counts_per_100 int," +
                                "ap_name varchar," +
                                "CONSTRAINT measured_pkc PRIMARY KEY (id));", conn);
                            cmd.ExecuteNonQuery();

                            string measuredFile = Path.Combine(dir, "measured_RSSI_3F.csv");
                            using (var writer = conn.BeginTextImport("COPY measured_table (" +
                                "location_floor," +
                                "location," +
                                "ave_dBm," +
                                "med_dBm," +
                                "center_freq_MHz," +
                                "counts_per_100," +
                                "ap_name) FROM STDIN WITH CSV HEADER"))
                            {
                                writer.Write(File.ReadAllText(measuredFile, Encoding.GetEncoding("UTF-8")));
                            }

                            measuredFile = Path.Combine(dir, "measured_RSSI_4F.csv");
                            using (var writer = conn.BeginTextImport("COPY measured_table (" +
                                "location_floor, " +
                                "location," +
                                "ave_dBm," +
                                "med_dBm," +
                                "center_freq_MHz," +
                                "counts_per_100," +
                                "ap_name) FROM STDIN WITH CSV HEADER"))
                            {
                                writer.Write(File.ReadAllText(measuredFile, Encoding.GetEncoding("UTF-8")));
                            }
                        }
                        ts.Complete();
                    }
                    break;
                case "ics":
                    //TransactionScopeの利用
                    using (TransactionScope ts = new TransactionScope())
                    {
                        using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
                        {
                            conn.Open();

                            cmd = new NpgsqlCommand("DROP TABLE IF EXISTS ics_table;" +
                                "CREATE TABLE ics_table AS " +
                                "SELECT measured_table.location_floor, measured_table.location, measured_table.ave_dBm, measured_table.med_dBm, measured_table.center_freq_MHz, measured_table.counts_per_100, measured_table.ap_name," +
                                "location_table.location_x, location_table.location_y, location_table.location_y_floor, location_table.location_y_height," +
                                "ap_table.ap_floor, ap_table.ap_x, ap_table.ap_y, ap_table.ap_y_floor, ap_table.ap_y_height " +
                                "FROM measured_table, location_table, ap_table " +
                                "WHERE ap_table.id < 63 " +
                                "AND measured_table.location_floor = location_table.location_floor " +
                                "AND measured_table.location = location_table.location " +
                                "AND measured_table.ap_name = ap_table.ap_name;" +
                                "ALTER TABLE ONLY ics_table ADD CONSTRAINT ics_pkc PRIMARY KEY(location_floor, location, ap_name, center_freq_MHz); ", conn);
                            cmd.ExecuteNonQuery();
                        }
                        ts.Complete();
                    }
                    break;
                default:
                    Construction(connStr, "ap");
                    Construction(connStr, "location");
                    Construction(connStr, "measured");
                    Construction(connStr, "ics");
                    break;
            }
            return 0;
        }
    }
}
