﻿using MyMaps.Models.POCOs;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyMaps.DataServices
{
    public class Dev_FPR : DataService
    {
        public string SendRequest(String request, String conditions)
        {
            String res = "";

            if (request.Equals("Dev_FPR_GetDistributors"))
            {
                res = this.Dev_FPR_GetDistributors(conditions);
            }
            else if (request.Equals("Dev_FPR_GetSalesMen"))
            {
                res = this.Dev_FPR_GetSalesMen(conditions);
            }
            else if (request.Equals("Dev_FPR_GetRoutes"))
            {
                res = this.Dev_FPR_GetRoutes(conditions);
            }
            else if (request.Equals("Dev_FPR_GetOutlets"))
            {
                res = this.Dev_FPR_GetOutlets(conditions);
            }
            else if (request.Equals("Dev_FPR_GetPoints"))
            {
                res = this.Dev_FPR_GetPoints(conditions);
            }

            return res;
        }

        public String Dev_FPR_GetPoints(String conditions)
        {
            List<string> conds = new List<string>(conditions.Split('|'));
            String data = "";
            String sdate = this.SearchVar(conds, "sDate");
            String edate = this.SearchVar(conds, "eDate");
            String distributor = this.SearchVar(conds, "Distributor");
            String salesman = this.SearchVar(conds, "Salesman");
            String route = this.SearchVar(conds, "Route");
            String outlet = this.SearchVar(conds, "Outlet");


            using (SqlConnection conn = new SqlConnection(Ctx))
            {
                using (SqlCommand cmd = new SqlCommand("map_spDev_FPR_GetPoints", conn) { CommandType = CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("sDate", sdate);
                    cmd.Parameters.AddWithValue("eDate", edate);
                    cmd.Parameters.AddWithValue("uDistributor ", distributor);
                    cmd.Parameters.AddWithValue("uSalesman ", salesman);
                    cmd.Parameters.AddWithValue("uRoute ", route);
                    cmd.Parameters.AddWithValue("uOutlet ", outlet);
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        List<Location> locs = new List<Location>();
                        while (rdr.Read())
                        {
                            Location l = new Location();
                            l.Lat = rdr["Latitude"].ToString();
                            l.Lon = rdr["Longitude"].ToString();
                            l.Route = rdr["RouteName"].ToString();
                            l.Outlet = rdr["OutletName"].ToString();
                            l.DocDate = rdr["TransactionDate"].ToString();
                            try
                            {
                                l.Sales_Amount = Convert.ToDouble(rdr["GrossAmount"].ToString());
                            }catch(Exception ex){

                            }
                            l.isDeviation = 1;

                            locs.Add(l);
                        }
                        data = JsonConvert.SerializeObject(locs);
                    }
                }
            }

            return data;
        }

        public String Dev_FPR_GetDistributors(String conditions)
        {
            List<string> conds = new List<string>(conditions.Split('|'));
            String data = "";
            String sdate = this.SearchVar(conds, "sDate");
            String edate = this.SearchVar(conds, "eDate");
            using (SqlConnection conn = new SqlConnection(Ctx))
            {
                using (SqlCommand cmd = new SqlCommand("map_spDev_FPR_GetDistributors", conn) { CommandType = CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("sDate", sdate);
                    cmd.Parameters.AddWithValue("eDate", edate);
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        List<BaseDto> dis = new List<BaseDto>();
                        while (rdr.Read())
                        {
                            BaseDto d = new BaseDto();
                            d.ID = rdr["DistributorID"].ToString();
                            d.Name = rdr["DistributorName"].ToString();
                            dis.Add(d);
                        }
                        data = JsonConvert.SerializeObject(dis);
                    }
                }
            }

            return data;
        }

        public String Dev_FPR_GetSalesMen(String conditions)
        {
            List<string> conds = new List<string>(conditions.Split('|'));
            String data = "";
            String sdate = this.SearchVar(conds, "sDate");
            String edate = this.SearchVar(conds, "eDate");
            String distributor = this.SearchVar(conds, "Distributor");

            using (SqlConnection conn = new SqlConnection(Ctx))
            {
                using (SqlCommand cmd = new SqlCommand("map_spDev_FPR_GetSalesMen", conn) { CommandType = CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("sDate", sdate);
                    cmd.Parameters.AddWithValue("eDate", edate);
                    cmd.Parameters.AddWithValue("uDistributor", distributor);

                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        List<BaseDto> dis = new List<BaseDto>();
                        while (rdr.Read())
                        {
                            BaseDto d = new BaseDto();
                            d.ID = rdr["SalesmanId"].ToString();
                            d.Name = rdr["SalesmanName"].ToString();
                            dis.Add(d);
                        }
                        data = JsonConvert.SerializeObject(dis);
                    }
                }
            }

            return data;
        }

        public String Dev_FPR_GetRoutes(String conditions)
        {
            List<string> conds = new List<string>(conditions.Split('|'));
            String data = "";
            String sdate = this.SearchVar(conds, "sDate");
            String edate = this.SearchVar(conds, "eDate");
            String distributor = this.SearchVar(conds, "Distributor");
            String salesman = this.SearchVar(conds, "Salesman");

            using (SqlConnection conn = new SqlConnection(Ctx))
            {
                using (SqlCommand cmd = new SqlCommand("map_spDev_FPR_GetRoutes", conn) { CommandType = CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("sDate", sdate);
                    cmd.Parameters.AddWithValue("eDate", edate);
                    cmd.Parameters.AddWithValue("uDistributor", distributor);
                    cmd.Parameters.AddWithValue("uSalesman", salesman);
                    
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        List<BaseDto> dis = new List<BaseDto>();
                        while (rdr.Read())
                        {
                            BaseDto d = new BaseDto();
                            d.ID = rdr["RouteId"].ToString();
                            d.Name = rdr["RouteName"].ToString();
                            dis.Add(d);
                        }
                        data = JsonConvert.SerializeObject(dis);
                    }
                }
            }

            return data;
        }

        public String Dev_FPR_GetOutlets(String conditions)
        {
            List<string> conds = new List<string>(conditions.Split('|'));
            String data = "";
            String sdate = this.SearchVar(conds, "sDate");
            String edate = this.SearchVar(conds, "eDate");
            String distributor = this.SearchVar(conds, "Distributor");
            String salesman = this.SearchVar(conds, "Salesman");
            String route = this.SearchVar(conds, "Route");

            using (SqlConnection conn = new SqlConnection(Ctx))
            {
                using (SqlCommand cmd = new SqlCommand("map_spDev_FPR_GetOutlets", conn) { CommandType = CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("sDate", sdate);
                    cmd.Parameters.AddWithValue("eDate", edate);
                    cmd.Parameters.AddWithValue("uDistributor", distributor);
                    cmd.Parameters.AddWithValue("uSalesman", salesman);
                    cmd.Parameters.AddWithValue("uRoute", route);

                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        List<BaseDto> dis = new List<BaseDto>();
                        while (rdr.Read())
                        {
                            BaseDto d = new BaseDto();
                            d.ID = rdr["OutletId"].ToString();
                            d.Name = rdr["OutletName"].ToString();
                            dis.Add(d);
                        }
                        IEnumerable<IGrouping<string, BaseDto>> dto_list = dis.GroupBy(n => n.ID);
                        List<BaseDto> dis2 = new List<BaseDto>();
                        foreach(IGrouping<string, BaseDto> g in dto_list){
                            BaseDto a = new BaseDto();
                            foreach (BaseDto bt in g)
                            {
                                a = bt;
                            }
                            dis2.Add(a);
                        }


                        data = JsonConvert.SerializeObject(dis2);
                    }
                }
            }

            return data;

        }
    }
}