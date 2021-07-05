using System;
using System.Collections.Generic;
using static System.Math;

namespace Ics
{
    class Program
    {
        static void Main(string[] args)
        {
            // 接続文字列
            string connStr = "Server=localhost;Port=5432;User ID=docker;Database=ics_db;Password=docker;Enlist=true;";

            //List<double> a = new List<double>() { 0,15.6};
            //List<double> b = new List<double>() { 9.2,0};
            //double L = 5.2973157670353;

            //double estiX = Sqrt((Pow(L, 2)) / (((b[1] - b[0]) / (a[1] - a[0])) + 1)) + a[0];
            //double estiY = -Sqrt(Abs((Pow(L, 2)) / (((a[1] - a[0]) / (b[1] - b[0])) + 1))) + b[0];

            //Console.WriteLine(estiX);
            //Console.WriteLine(estiY);

            //SqlConstruction.Construction(connStr, "");
            Calculation.Calculate(connStr);
        }
    }
}
