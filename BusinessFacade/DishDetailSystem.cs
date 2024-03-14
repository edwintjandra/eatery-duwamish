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
