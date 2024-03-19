using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Data
{
    public class DishRecipeData
    {
        private int _dishRecipeID;
        public int DishRecipeID
        {
            get { return _dishRecipeID; }
            set { _dishRecipeID = value; }
        }

        private int _dishDetailID;
        public int DishDetailID
        {
            get { return _dishDetailID; }
            set { _dishDetailID = value; }
        }

        private string _ingredient;
        public string Ingredient
        {
            get { return _ingredient; }
            set { _ingredient = value; }
        }

        private int _quantity;
        public int Quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }

        private string _unit;
        public string Unit
        {
            get { return _unit; }
            set { _unit = value; }
        }

    }
}
