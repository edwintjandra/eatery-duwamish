﻿using BusinessFacade;
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
                /* give dish ID value */
                LoadDishDetails(DishID);
                hdfDishID.Value = DishID.ToString();
            }
        }

        private void FillForm(DishDetailData dishDetail)
        {
            //hdfDishId.Value = dishDetail.DishID.ToString();
            /* 
             fill other value
             */
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
            try
            {
                DishDetailData dishDetail = GetFormData();
                int rowAffected = new DishDetailSystem().InsertUpdateDishDetail(dishDetail);
                if (rowAffected <= 0)
                    throw new Exception("No Data Recorded");
                Session["save-success"] = 1;
                Response.Redirect("DishDetail.aspx");
            }
            catch (Exception ex)
            {
                notifDish.Show($"ERROR SAVE DATA: {ex.Message}", NotificationType.Danger);
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

        protected void rptDishDetail_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DishDetailData dishDetail = (DishDetailData)e.Item.DataItem;
                LinkButton lbRecipeName = (LinkButton)e.Item.FindControl("lbRecipeName");
                lbRecipeName.Text = dishDetail.RecipeName;
 
 
                CheckBox chkChoose = (CheckBox)e.Item.FindControl("chkChoose");
                chkChoose.Attributes.Add("data-value", dishDetail.DishDetailID.ToString());
            }
        }

        protected void rptDish_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
        }


    }
}