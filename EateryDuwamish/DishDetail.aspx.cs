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
                LoadDishDetails(DishID);
            }
        }

        private DishDetailData GetFormData()
        {
            DishDetailData dishDetail = new DishDetailData();
            dishDetail.DishDetailID = String.IsNullOrEmpty(hdfDishDetailId.Value) ? 0 : Convert.ToInt32(hdfDishDetailId.Value);
            dishDetail.DishID = Convert.ToInt32(txtDishId.Text); ;
            dishDetail.RecipeName = txtRecipeName.Text;
            return dishDetail;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO msDishDetail (DishID, RecipeName,AuditedActivity,AuditedTime) VALUES (@DishID, @RecipeName,@AuditedActivity,@AuditedTime)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@DishID", Convert.ToInt32(txtDishId.Text));
                command.Parameters.AddWithValue("@RecipeName", txtRecipeName.Text);
                command.Parameters.AddWithValue("@AuditedActivity", 'I');
                command.Parameters.AddWithValue("@AuditedTime", "2024-03-08 13:22:46.767");

                connection.Open();
                command.ExecuteNonQuery();
            }
            Response.Redirect(Request.Url.AbsoluteUri);

        }

        private void LoadDishDetails(int DishID)
        {
            try
            {
                List<DishDetailData> ListDish = new DishDetailSystem().GetDishDetailList();
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

        protected void rptDishDetail_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EDIT")
            {
                
            }
        }

      
    }
}