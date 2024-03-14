using BusinessFacade;
using Common.Data;
using Common.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common.Data;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace EateryDuwamish
{
    public partial class DishDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["DishID"]))
            {
                int DishID = Convert.ToInt32(Request.QueryString["DishID"]);
                DishData dish = new DishSystem().GetDishByID(DishID);
                /* give dish ID value */
                LoadDishDetails(dish.DishID);
                lblDishName.Text = "dish name: "+dish.DishName;
                hdfDishID.Value = dish.DishID.ToString(); 
            }
        }

        private void FillForm(DishDetailData dishDetail)
        {
            hdfDishDetailID.Value = dishDetail.DishDetailID.ToString();
            hdfDishID.Value = dishDetail.DishID.ToString();
            txtRecipeName.Text = dishDetail.RecipeName;
        }

        private DishDetailData GetFormData()
        {
            DishDetailData dishDetail = new DishDetailData();
            dishDetail.DishDetailID = String.IsNullOrEmpty(hdfDishDetailID.Value) ? 0 : Convert.ToInt32(hdfDishDetailID.Value);
            dishDetail.DishID = Convert.ToInt32(hdfDishID.Value); 
            dishDetail.RecipeName = txtRecipeName.Text;
            return dishDetail;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DishDetailData dishDetail = GetFormData();
            try
            {
                int rowAffected = new DishDetailSystem().InsertUpdateDishDetail(dishDetail);
                if (rowAffected <= 0)
                    throw new Exception("No Data Recorded");
                Session["save-success"] = 1;
                string queryString = Request.QueryString.ToString();
                Response.Redirect($"DishDetail.aspx?{queryString}");
            }
            catch (Exception ex)
            {
                notifDish.Show($"ERROR SAVE DATA: {ex.Message}, dish detail data: {dishDetail.DishDetailID}", NotificationType.Danger);
            }
         }

        protected void btnDelete_Click(object sender, EventArgs e) {
            try
            {
                string strDeletedIDs = hdfDeletedDishes.Value;
                IEnumerable<int> deletedIDs = strDeletedIDs.Split(',').Select(Int32.Parse);
                int rowAffected = new DishDetailSystem().DeleteDishDetails(deletedIDs);
                if (rowAffected <= 0)
                    throw new Exception("No Data Deleted");
                Session["delete-success"] = 1;
                string queryString = Request.QueryString.ToString();
                Response.Redirect($"DishDetail.aspx?{queryString}");
            }
            catch (Exception ex)
            {
                notifDish.Show($"ERROR DELETE DATA: {ex.Message}", NotificationType.Danger);
            } 

        }

        private void LoadDishDetails(int DishID)
        {
            try
            {
                List<DishDetailData> ListDish = new DishDetailSystem().GetDishDetailListByID(DishID);
                rptDishDetail.DataSource = ListDish;
                rptDishDetail.DataBind();
            }
            catch (Exception ex)
            {
                notifDish.Show($"ERROR LOAD TABLE: {ex.Message}", NotificationType.Danger);
            }
        }

        protected void rptDishDetail_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EDIT")
            {
                int dishDetailID = Convert.ToInt32(e.CommandArgument.ToString());
                DishDetailData dish = new DishDetailSystem().GetDishDetailByID(dishDetailID);
                FillForm(new DishDetailData
                {
                    DishDetailID=dish.DishDetailID,
                    DishID = dish.DishID,
                    RecipeName = dish.RecipeName,
                });

                pnlFormDish.Visible = true;
                txtRecipeName.Focus();
            }
        }

        protected void rptDishDetail_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DishDetailData dishDetail = (DishDetailData)e.Item.DataItem;
                LinkButton lbRecipeName = (LinkButton)e.Item.FindControl("lbRecipeName");
                lbRecipeName.Text = dishDetail.RecipeName;
                lbRecipeName.CommandArgument = dishDetail.DishDetailID.ToString();


                HyperLink dishRecipeLink = (HyperLink)e.Item.FindControl("hlDishRecipe");
                dishRecipeLink.NavigateUrl = "~/DishRecipe.aspx?DishDetailID=" + dishDetail.DishDetailID;

                CheckBox chkChoose = (CheckBox)e.Item.FindControl("chkChoose");
                chkChoose.Attributes.Add("data-value", dishDetail.DishDetailID.ToString());
            }
        }

       


    }
}