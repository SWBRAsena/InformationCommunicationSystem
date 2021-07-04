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

                    // 上位三つ　select * from ics_table where location = 'a' order by ave_dbm OFFSET 0 LIMIT 3
                    // 測定点ごとの最大値　select location, max(ave_dbm) from ics_table group by location

                    cmd = new NpgsqlCommand("select ave_dbm, center_freq_mhz, location_x, location_y, ap_name, ap_x, ap_y, location_z_height, ap_z_height, location_floor, ap_floor from ics_table where location = 'a' and ave_dbm = " +
                        "(select max(ave_dbm) from ics_table where location = 'a')", conn);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            double d = Distance(reader.GetDouble(0), reader.GetInt32(1));
                            Console.WriteLine($" RSSI = {reader.GetDouble(0)}, fs = {reader.GetInt32(1)}");
                            Console.WriteLine($" location [a] in ({reader.GetDouble(2)}, {reader.GetDouble(3)}) ,nearest AP [{reader.GetString(4)}] in ({reader.GetDouble(5)}, {reader.GetDouble(6)}), Distance is {d} m.");
                            int floorDistance = reader.GetInt32(10) - reader.GetInt32(9);
                            double heightDistance = 1.5;
                            switch (floorDistance)
                            {
                                case -2:
                                    heightDistance = 5.7;
                                    break;
                                case -1:
                                    heightDistance = 2.1;
                                    break;
                                case 0:
                                    heightDistance = 1.5;
                                    break;
                                case 1:
                                    heightDistance = 3.5;
                                    break;
                                case 2:
                                    heightDistance = 7.1;
                                    break;
                            }
                            // APは測定点の45度方向にいると仮定する

                        }
                    }
                }
                ts.Complete();
            }

            return 0;
        }
    }
}
