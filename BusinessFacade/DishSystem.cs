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
    public class DishSystem
    {
        public List<DishData> GetDishList()
        {
            try
            {
                return new DishDB().GetDishList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DishData GetDishByID(int dishID)
        {
            try
            {
                return new DishDB().GetDishByID(dishID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int InsertUpdateDish(DishData dish)
        {
            try
            {
                return new DishRule().InsertUpdateDish(dish);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int DeleteDishes(IEnumerable<int> dishIDs)
        {
            try
            {
                string strDeletedDishDetailsId = "";
                string strDeletedDishRecipesId = "";

                foreach (int dishID in dishIDs)
                {
                    List<DishDetailData> dishDetails = new DishDetailSystem().GetDishDetailListByID(dishID);

                    foreach (DishDetailData dishDetail in dishDetails)
                    {
                        strDeletedDishDetailsId = strDeletedDishDetailsId + "," + dishDetail.DishDetailID;

                        List<DishRecipeData> dishRecipes = new DishRecipeSystem().GetDishRecipeListByID(dishDetail.DishDetailID);

                        foreach (DishRecipeData dishRecipe in dishRecipes)
                        {
                            strDeletedDishRecipesId = strDeletedDishRecipesId + "," + dishRecipe.DishRecipeID;
                        }
                    }
                }

                IEnumerable<int> deletedDishRecipesId = strDeletedDishRecipesId.Split(',').Where(s => !string.IsNullOrWhiteSpace(s)).Select(int.Parse);
                new DishRecipeSystem().DeleteDishRecipes(deletedDishRecipesId);

                IEnumerable<int> deletedDishDetailsId = strDeletedDishDetailsId.Split(',').Where(s => !string.IsNullOrWhiteSpace(s)).Select(int.Parse);
                new DishDetailSystem().DeleteDishDetails(deletedDishDetailsId);


                return new DishRule().DeleteDishes(dishIDs);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
