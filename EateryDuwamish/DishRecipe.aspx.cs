﻿using BusinessFacade;
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

        private void FillForm(DishRecipeData dishRecipe)
        {
            hdfDishRecipeID.Value = dishRecipe.DishRecipeID.ToString();
            hdfDishDetailID.Value = dishRecipe.DishDetailID.ToString();
            txtIngredient.Text = dishRecipe.Ingredient;
            txtQuantity.Text = dishRecipe.Quantity.ToString();
            txtUnit.Text = dishRecipe.Unit.ToString();
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string strDeletedIDs = hdfDeletedDishes.Value;
                IEnumerable<int> deletedIDs = strDeletedIDs.Split(',').Select(Int32.Parse);
                int rowAffected = new DishRecipeSystem().DeleteDishRecipes(deletedIDs);
                if (rowAffected <= 0)
                    throw new Exception("No Data Deleted");
                Session["delete-success"] = 1;
                string queryString = Request.QueryString.ToString();
                Response.Redirect($"DishRecipe.aspx?{queryString}");
            }
            catch (Exception ex)
            {
                notifDish.Show($"ERROR DELETE DATA: {ex.Message} ", NotificationType.Danger);
            }
        }

        protected void rptDishRecipe_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EDIT")
            {    
                int dishRecipeID = Convert.ToInt32(e.CommandArgument.ToString());
                //TODO: Bikin GetDishRecipeByID
                DishRecipeData dishRecipe = new DishRecipeSystem().GetDishRecipeByID(dishRecipeID);
                FillForm(new DishRecipeData
                {
                    DishRecipeID = dishRecipe.DishRecipeID,
                    DishDetailID = dishRecipe.DishDetailID,
                    Ingredient = dishRecipe.Ingredient,
                    Quantity=dishRecipe.Quantity,
                    Unit=dishRecipe.Unit
                }); 

                pnlFormDish.Visible = true;
                txtIngredient.Focus();
            }
        }

        protected void rptDishRecipe_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DishRecipeData dishRecipe= (DishRecipeData)e.Item.DataItem;
                LinkButton lbIngridient= (LinkButton)e.Item.FindControl("lbIngredient");
                 Literal litQuantity = (Literal)e.Item.FindControl("litQuantity");
                Literal litUnit= (Literal)e.Item.FindControl("litUnit");

                lbIngridient.Text = dishRecipe.Ingredient;
                lbIngridient.CommandArgument = dishRecipe.DishRecipeID.ToString();

                litQuantity.Text = dishRecipe.Quantity.ToString();
                litUnit.Text = dishRecipe.Unit.ToString();


                CheckBox chkChoose = (CheckBox)e.Item.FindControl("chkChoose");
                chkChoose.Attributes.Add("data-value", dishRecipe.DishRecipeID.ToString()); 
            }
        }

    }
}