using BusinessFacade;
using Common.Data;
using Common.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EateryDuwamish
{
    public partial class DishRecipe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["DishDetailID"]))
            {
                int DishDetailID = Convert.ToInt32(Request.QueryString["DishDetailID"]);
                hdfDishDetailID.Value = DishDetailID.ToString();
                LoadDishRecipes(DishDetailID);
            }
        }

        private void LoadDishRecipes(int DishDetailID)
        {
            try
            {
                List<DishRecipeData> ListDish = new DishRecipeSystem().GetDishRecipeListByID(DishDetailID);
                rptDishRecipe.DataSource = ListDish;
                rptDishRecipe.DataBind();
            }
            catch (Exception ex)
            {
                /*
                notifDish.Show($"ERROR LOAD TABLE: {ex.Message}", NotificationType.Danger);
                */
            }
        }

        private DishRecipeData GetFormData()
        {
            DishRecipeData dishRecipe = new DishRecipeData();
            dishRecipe.DishRecipeID = String.IsNullOrEmpty(hdfDishRecipeID.Value) ? 0 : Convert.ToInt32(hdfDishRecipeID.Value);
            dishRecipe.DishDetailID= Convert.ToInt32(hdfDishDetailID.Value);
            dishRecipe.Ingredient= txtIngredient.Text;
            dishRecipe.Quantity = Convert.ToInt32(txtQuantity.Text);
            dishRecipe.Unit= Convert.ToInt32(txtUnit.Text);
            return dishRecipe;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                DishRecipeData dishRecipe = GetFormData();
                int rowAffected = new DishRecipeSystem().InsertUpdateDishRecipe(dishRecipe);
                if (rowAffected <= 0)
                    throw new Exception("No Data Recorded");
                Session["save-success"] = 1;
                string queryString = Request.QueryString.ToString();
                Response.Redirect($"DishRecipe.aspx?{queryString}"); 
            }
            catch (Exception ex)
            {
                /*
                notifDish.Show($"ERROR SAVE DATA: {ex.Message}", NotificationType.Danger); */
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e) { 
        }

        protected void rptDishRecipe_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DishRecipeData dishRecipe= (DishRecipeData)e.Item.DataItem;
                Literal litIngredient = (Literal)e.Item.FindControl("litIngredient");
                Literal litQuantity = (Literal)e.Item.FindControl("litQuantity");
                Literal litUnit= (Literal)e.Item.FindControl("litUnit");

                litIngredient.Text = dishRecipe.Ingredient;
                litQuantity.Text = dishRecipe.Quantity.ToString();
                litUnit.Text = dishRecipe.Unit.ToString();


                CheckBox chkChoose = (CheckBox)e.Item.FindControl("chkChoose");
                /*
                chkChoose.Attributes.Add("data-value", dishDetail.DishDetailID.ToString()); */
            }
        }

    }
}