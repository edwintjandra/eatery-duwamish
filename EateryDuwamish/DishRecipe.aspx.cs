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
            LoadDishDetails(Convert.ToInt32(Request.QueryString["DishDetailID"]));
        }

        private void LoadDishDetails(int DishDetailID)
        {
            try
            {
                List<DishRecipeData> ListDish = new DishRecipeSystem().GetDishRecipeListByID(DishDetailID);
                rptDishDetail.DataSource = ListDish;
                rptDishDetail.DataBind();
            }
            catch (Exception ex)
            {
                /*
                notifDish.Show($"ERROR LOAD TABLE: {ex.Message}", NotificationType.Danger);
                */
            }
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
                litUnit.Text = dishRecipe.Quantity.ToString();


                CheckBox chkChoose = (CheckBox)e.Item.FindControl("chkChoose");
                /*
                chkChoose.Attributes.Add("data-value", dishDetail.DishDetailID.ToString()); */
            }
        }

    }
}