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
    public class DishRecipeDB
    {
        //SPO DishRecipe_InsertUpdate
        public int InsertUpdateDishRecipe(DishRecipeData dishRecipe, SqlTransaction SqlTran)
        {
            try
            {
                string SpName = "dbo.DishRecipe_InsertUpdate";
                SqlCommand SqlCmd = new SqlCommand(SpName, SqlTran.Connection, SqlTran);
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlParameter DishRecipeId = new SqlParameter("@DishRecipeID", dishRecipe.DishRecipeID);
                DishRecipeId.Direction = ParameterDirection.InputOutput;
                SqlCmd.Parameters.Add(DishRecipeId);

                SqlCmd.Parameters.Add(new SqlParameter("@DishDetailID", dishRecipe.DishDetailID));
                SqlCmd.Parameters.Add(new SqlParameter("@Ingredient", dishRecipe.Ingredient));
                SqlCmd.Parameters.Add(new SqlParameter("@Quantity", dishRecipe.Quantity));
                SqlCmd.Parameters.Add(new SqlParameter("@Unit", dishRecipe.Unit)); 

                return SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int DeleteDishRecipes(string dishRecipeIDs, SqlTransaction SqlTran)
        {
            try
            {
                string SpName = "dbo.DishRecipe_Delete";
                SqlCommand SqlCmd = new SqlCommand(SpName, SqlTran.Connection, SqlTran);
                SqlCmd.CommandType = CommandType.StoredProcedure;
                SqlCmd.Parameters.Add(new SqlParameter("@DishRecipeIDs", dishRecipeIDs));
                return SqlCmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //belom diubah ke SPO yang versi Recipe
        public List<DishRecipeData> GetDishRecipeListByID(int DishDetailID)
        {
            try
            {
                string SpName = "dbo.DishRecipe_GetByDishRecipeID";
                List<DishRecipeData> ListDishRecipe = new List<DishRecipeData>();

                using (SqlConnection SqlConn = new SqlConnection())
                {
                    SqlConn.ConnectionString = SystemConfigurations.EateryConnectionString;
                    SqlConn.Open();
                    SqlCommand SqlCmd = new SqlCommand(SpName, SqlConn);
                    SqlCmd.CommandType = CommandType.StoredProcedure;
                    SqlCmd.Parameters.Add(new SqlParameter("@DishDetailID", DishDetailID));

                    using (SqlDataReader Reader = SqlCmd.ExecuteReader())
                    {
                        if (Reader.HasRows)
                        {
                            while (Reader.Read())
                            {
                                DishRecipeData dishRecipe= new DishRecipeData();
                                dishRecipe.DishRecipeID = Convert.ToInt32(Reader["DishRecipeID"]);
                                dishRecipe.DishDetailID = Convert.ToInt32(Reader["DishDetailID"]);
                                dishRecipe.Ingredient= Convert.ToString(Reader["Ingredient"]);
                                dishRecipe.Quantity = Convert.ToInt32(Reader["Quantity"]);
                                dishRecipe.Unit= Convert.ToInt32(Reader["Unit"]);
                                ListDishRecipe.Add(dishRecipe);
                            }
                        }
                    }
                    SqlConn.Close();
                }
                return ListDishRecipe;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
