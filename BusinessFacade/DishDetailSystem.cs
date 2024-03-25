using BusinessRule;
using Common.Data;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessFacade
{
    public class DishDetailSystem
    {
        public List<DishDetailData> GetDishDetailList()
        {
            try
            {
                return new DishDetailDB().GetDishDetailList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<DishDetailData> GetDishDetailListByID(int DishID)
        {
            try
            {
                return new DishDetailDB().GetDishDetailListByID(DishID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int InsertUpdateDishDetail(DishDetailData dishDetail)
        {
            try
            {
                return new DishDetailRule().InsertUpdateDishDetail(dishDetail);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int DeleteDishDetails(IEnumerable<int> dishDetailIDs)
        {
            try
            {
                string strDeletedDishRecipesId = "";

                foreach (int dishDetailId in dishDetailIDs)
                {
                    List<DishRecipeData> dishRecipes = new DishRecipeSystem().GetDishRecipeListByID(dishDetailId);

                    foreach (DishRecipeData dishRecipe in dishRecipes)
                    {
                        strDeletedDishRecipesId = strDeletedDishRecipesId + "," + dishRecipe.DishRecipeID;
                    }
                }
                 

                IEnumerable<int> deletedDishRecipesId = strDeletedDishRecipesId.Split(',').Where(s => !string.IsNullOrWhiteSpace(s)).Select(int.Parse);
                new DishRecipeSystem().DeleteDishRecipes(deletedDishRecipesId);

                return new DishDetailRule().DeleteDishDetails(dishDetailIDs);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DishDetailData GetDishDetailByID(int dishDetailID)
        {
            try
            {
                return new DishDetailDB().GetDishDetailByID(dishDetailID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
