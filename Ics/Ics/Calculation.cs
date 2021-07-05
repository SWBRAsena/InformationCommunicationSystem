using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Npgsql;
using static System.Math;

namespace Ics
{
    class Calculation
    {
        static string dir = Path.Combine("..", "..", "..", "..", "..", "data");
        private static double Distance(double rssi, int fs)
        {
            double distance = 0;
            distance = (Pow(10, Abs(rssi) / 20) * 3 * Pow(10, 8)) / (4 * PI * fs * Pow(10, 6));
            return distance;
        }
        public static int Calculate(string connStr)
        {
            List<string> points = new List<string>();
            // SQL処理で用いる変数を予め宣言
            NpgsqlCommand cmd = null;

            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                cmd = new NpgsqlCommand("select distinct location from ics_table", conn);
                using (NpgsqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        points.Add(reader.GetString(0));
                    }
                }
            }


            string outFile = Path.Combine(dir, "output.csv");
            using (StreamWriter sw = new StreamWriter(outFile))
            {
                sw.WriteLine("point,x,y,AP1,a1,b1,L,AP2,a2,b2,esti_x,esti_y,x_diff,y_diff");
                foreach (string point in points)
                {
                    string lineStr = null;
                    double heightDistance = 1.5;
                    List<double> a = new List<double>();
                    List<double> b = new List<double>();
                    double x = 0;
                    double y = 0;
                    double L = 0;

                    using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
                    {
                        conn.Open();

                        // 上位三つ　select * from ics_table where location = 'a' order by ave_dbm OFFSET 0 LIMIT 3
                        // 測定点ごとの最大値　select location, max(ave_dbm) from ics_table group by location
                        // 最近APを選ぶ　select ave_dbm, center_freq_mhz, location_x, location_y, ap_name, ap_x, ap_y, location_z_height, ap_z_height, location_floor, ap_floor from ics_table where location = 'a' and ave_dbm = (select max(ave_dbm) from ics_table where location = 'a')

                        cmd = new NpgsqlCommand($"select ave_dbm, center_freq_mhz, location_x, location_y, ap_name, ap_x, ap_y, location_z_height, ap_z_height, location_floor, ap_floor from ics_table where location = '{point}' and location_floor = 4 order by ave_dbm DESC OFFSET 0 LIMIT 3", conn);
                        using (NpgsqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                L = Distance(reader.GetDouble(0), reader.GetInt32(1));
                                a.Add(reader.GetDouble(5));
                                b.Add(reader.GetDouble(6));
                                x = reader.GetDouble(2);
                                y = reader.GetDouble(3);
                                string apName = reader.GetString(4);

                                lineStr = $"{point},{x},{y},{apName},{a[0]},{b[0]},{L}";

                                Console.WriteLine($" RSSI = {reader.GetDouble(0)}, fs = {reader.GetInt32(1)}");
                                Console.WriteLine($" location [a] in ({x}, {y}) ,nearest AP [{apName}] in ({a[0]}, {b[0]}), Distance is {L} m.");
                                int floorDistance = reader.GetInt32(10) - reader.GetInt32(9);
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

                            if (reader.Read())
                            {
                                string apName = reader.GetString(4);
                                a.Add(reader.GetDouble(5));
                                b.Add(reader.GetDouble(6));
                                lineStr = $"{lineStr},{apName},{a[1]},{b[1]}";
                            }
                        }
                    }
                    double estiX = 0;
                    double estiY = 0;
                    bool fx = false;
                    bool fy = false;

                    if (a[0] == a[1] && b[0] == b[1])
                    {
                        estiX = a[0];
                        estiY = b[0];
                        fx = true;
                        fy = true;
                    }
                    else if (a[0] == a[1] && b[0] != b[1])
                    {
                        estiX = a[0];
                        fx = true;
                    }
                    else if (a[0] != a[1] && b[0] == b[1])
                    {
                        estiY = b[0];
                        fy = true;
                    }
                    if (fx == false)
                    {
                        if (((Pow(L, 2)) / (((b[1] - b[0]) / (a[1] - a[0])) + 1)) > 0)
                        {
                            estiX = Sqrt((Pow(L, 2)) / (((b[1] - b[0]) / (a[1] - a[0])) + 1)) + a[0];
                        }
                        else
                        {
                            estiX = -Sqrt(Abs((Pow(L, 2)) / (((b[1] - b[0]) / (a[1] - a[0])) + 1))) + a[0];
                        }
                    }
                    if (fy == false)
                    {
                        if (((Pow(L, 2)) / (((a[1] - a[0]) / (b[1] - b[0])) + 1)) > 0)
                        {
                            estiY = Sqrt((Pow(L, 2)) / (((a[1] - a[0]) / (b[1] - b[0])) + 1)) + b[0];
                        }
                        else
                        {
                            estiY = -Sqrt(Abs((Pow(L, 2)) / (((a[1] - a[0]) / (b[1] - b[0])) + 1))) + b[0];
                        }
                    }

                    sw.WriteLine($"{lineStr},{estiX},{estiY},{estiX-x},{estiY-y}");
                }
            }
            return 0;
        }
    }
}
