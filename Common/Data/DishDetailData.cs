using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Data
{
    public class DishDetailData
    {
        private int _dishDetailID;
        public int DishDetailID
        {
            get { return _dishDetailID; }
            set { _dishDetailID = value; }
        }

        private int _dishID;
        public int DishID
        {
            get { return _dishID; }
            set { _dishID = value; }
        }

        private string _recipeName;
        public string RecipeName
        {
            get { return _recipeName; }
            set { _recipeName = value; }
        }
       
    }
}
