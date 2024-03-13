using Common.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SystemFramework;

namespace DataAccess
{
    public class DishDetailDB
    {
        // SP DishDetail_GET
        public List<DishDetailData> GetDishDetailList()
        {
            try
            {
                string SpName = "dbo.DishDetail_Get";
                List<DishDetailData> ListDish = new List<DishDetailData>();
                using (SqlConnection SqlConn = new SqlConnection())
                {
                    SqlConn.ConnectionString = SystemConfigurations.EateryConnectionString;
                    SqlConn.Open();
                    SqlCommand SqlCmd = new SqlCommand(SpName, SqlConn);
                    SqlCmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataReader Reader = SqlCmd.ExecuteReader())
                    {
                        if (Reader.HasRows)
                        {
                            while (Reader.Read())
                            {
                                DishDetailData dishDetail = new DishDetailData();
                                dishDetail.DishDetailID = Convert.ToInt32(Reader["DishDetailID"]);
                                dishDetail.RecipeName= Convert.ToString(Reader["RecipeName"]); 
                                ListDish.Add(dishDetail);
                            }
                        }
                    }
                    SqlConn.Close();
                }
                return ListDish;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        //SPO Dish_InsertUpdate
        public int InsertUpdateDishDetail(DishDetailData dish, SqlTransaction SqlTran)
        {
            try
            {
                string SpName = "dbo.DishDetail_InsertUpdate";
                SqlCommand SqlCmd = new SqlCommand(SpName, SqlTran.Connection, SqlTran);
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlParameter DishDetailId = new SqlParameter("@DishDetailID", dish.DishDetailID);
                DishDetailId.Direction = ParameterDirection.InputOutput;
                SqlCmd.Parameters.Add(DishDetailId);

                SqlCmd.Parameters.Add(new SqlParameter("@RecipeName", dish.RecipeName));
                SqlCmd.Parameters.Add(new SqlParameter("@DishID", dish.DishID));
                return SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
         
    }
}
