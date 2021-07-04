using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Npgsql;

namespace Ics
{
    class Calculation
    {
        private static double Distance(double rssi, int fs)
        {
            double distance = 0;
            distance = (Math.Pow(10, Math.Abs(rssi) / 20) * 3 * Math.Pow(10, 8)) / (4 * Math.PI * fs * Math.Pow(10, 6));
            return distance;
        }
        public static int Calculate(string connStr)
        {
            // SQL処理で用いる変数を予め宣言
            NpgsqlCommand cmd = null;
            //TransactionScopeの利用
            using (TransactionScope ts = new TransactionScope())
            {
                using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
                {
                    conn.Open();

                    cmd = new NpgsqlCommand("select ave_dbm, center_freq_mhz, location_x, location_y, ap_name, ap_x, ap_y from ics_table where location = 'a' and ave_dbm = " +
                        "(select max(ave_dbm) from ics_table where location = 'a')", conn);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            double d = Distance(reader.GetDouble(0), reader.GetInt32(1));
                            Console.WriteLine($"RSSI = {reader.GetDouble(0)}, fs = {reader.GetInt32(1)}");
                            Console.WriteLine($"location [a] in ({reader.GetDouble(2)}, {reader.GetDouble(3)}) ,nearest AP [{reader.GetString(4)}] in ({reader.GetDouble(5)}, {reader.GetDouble(6)}), Distance is {d}");
                        }
                    }
                }
                ts.Complete();
            }

            return 0;
        }
    }
}
