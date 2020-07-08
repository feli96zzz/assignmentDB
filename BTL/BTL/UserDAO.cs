using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BTL
{
    class UserDAO
    {
        private static UserDAO instance;
        public static UserDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new UserDAO();
                }
                return instance;
            }
        }
        private UserDAO()
        {

        }
        public DataTable Xem()
        {
            string query = "SELECT * FROM dbo.productModel";
            return DataProvider.Instance.ExecuteQuery(query);
            
        }
        public DataTable TimKiem(DateTimePicker dtpk)
        {
            object[] parameter = new object[] { dtpk.Value };
            string query = "SELECT * FROM dbo.Product where stock_in_date < @Date";
            return DataProvider.Instance.ExecuteQuery(query, parameter);
        }
        public bool Xoa(string ID)
        {
            string query = "delete productmodel where id = @ID";
            object[] parameter = new object[] { ID };
            if (DataProvider.Instance.ExecuteNonQuery(query, parameter) > 0)
                return true;
            return false;
        }
        public bool Sua(int id, UserDTO productmodel)
        {
            string query = "Update productmodel set name = @name , description = @description , status = @status , detailedInfo = @detailInfo , brand = @brand , type = @type where id= @OldID";
            object[] para = new object[] { productmodel.Name, productmodel.Description, productmodel.Status, productmodel.DetailedInfo, productmodel.Brand,productmodel.Type, id };
            if (DataProvider.Instance.ExecuteNonQuery(query, para) > 0)
                return true;
            return false;
        }
        public bool Them(UserDTO productmodel)
        {
            string query = "INSERT INTO productModel VALUES( @name , @description , @status , @detailInfo , @brand , @type )";
            object[] para = new object[] { productmodel.Name, productmodel.Description, productmodel.Status, productmodel.DetailedInfo, productmodel.Brand, productmodel.Type};
            if (DataProvider.Instance.ExecuteNonQuery(query, para) > 0)
                return true;
            return false;
        }
    }
}
