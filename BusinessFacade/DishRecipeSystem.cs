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
    public class DishRecipeSystem
    {
        public List<DishRecipeData> GetDishRecipeListByID(int DishDetailID)
        {
            try
            {
                return new DishRecipeDB().GetDishRecipeListByID(DishDetailID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int InsertUpdateDishRecipe(DishRecipeData dishRecipe)
        {
            try
            {
                return new DishRecipeRule().InsertUpdateDishRecipe(dishRecipe);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int DeleteDishRecipes(IEnumerable<int> dishRecipeIDs)
        {
            try
            {
                return new DishRecipeRule().DeleteDishRecipes(dishRecipeIDs);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
