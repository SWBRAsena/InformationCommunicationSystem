using System;

namespace Ics
{
    class Program
    {
        static void Main(string[] args)
        {
            // 接続文字列
            string connStr = "Server=localhost;Port=5432;User ID=docker;Database=ics_db;Password=docker;Enlist=true;";

            //SqlConstruction.Construction(connStr, "");
            Calculation.Calculate(connStr);
        }
    }
}
