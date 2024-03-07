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


namespace EateryDuwamish
{
    public partial class DishDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private DishData GetFormData()
        {
            DishData dish = new DishData();
            dish.DishID = String.IsNullOrEmpty(hdfDishId.Value) ? 0 : Convert.ToInt32(hdfDishId.Value);
            dish.DishTypeID = Convert.ToInt32(ddlDishType.SelectedValue);
            dish.DishName = txtDishName.Text;
            dish.DishPrice = Convert.ToInt32(txtPrice.Text);
            return dish;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                DishData dish = GetFormData();
                int rowAffected = new DishSystem().InsertUpdateDish(dish);
                if (rowAffected <= 0)
                    throw new Exception("No Data Recorded");
                Session["save-success"] = 1;
                Response.Redirect("Dish.aspx");
            }
            catch (Exception ex)
            {
                notifDish.Show($"ERROR SAVE DATA: {ex.Message}", NotificationType.Danger);
            }
        }
    }
}