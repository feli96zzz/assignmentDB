// lớp xử lý data access object
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ADO_Them_Xoa_Sua_TimKiem
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

        private UserDAO() { }
        public DataTable Xem()
        {
            string query = "select * from dbo.productModel";

            return DataProvider.Instance.ExcuteQuery(query);
        }

        public DataTable HienThi(string month, DateTimePicker dtpk)
        {
            object[] parameter = new object[] { month, dtpk.Value};
            string query = "incompetent_products @month , @date";

            return DataProvider.Instance.ExcuteQuery(query, parameter);
        }

        public DataTable DoanhThu(string maNhaBan, DateTimePicker dtpk, DateTimePicker dtpk2)
        {
            object[] parameter = new object[] {maNhaBan, dtpk.Value, dtpk2.Value};
            string query = "select dbo.doanhThu( @maNhaBan , @fromDate , @toDate )";

            return DataProvider.Instance.ExcuteQuery(query, parameter);
        }


        public DataTable TimKiem(string text)
        {
            object[] parameter = new object[] { text };
            string query = "select * from dbo.productModel where name like @var";
            
            return DataProvider.Instance.ExcuteQuery(query, parameter);
        }

        public bool XoaTheoID(string id)
        {
            string query = "delProcMod @id";
            object[] para = new object[] { id };
            if (DataProvider.Instance.ExecuteNonQuery(query, para) > 0)
                return true;
            return false;
        }

        public bool Sua(string id, UserDTO user)
        {
            string query = "update_productModel @id , @name , @description , @detailedInfo , @brand , @type";
            object[] para = new object[] {user.Id, user.Name, user.Description, user.DetailedInfo, user.Brand, user.Type };
            if (DataProvider.Instance.ExecuteNonQuery(query, para) > 0)
            {
                return true;
            }
            return false;
        }

        public bool Them(UserDTO user)
        {
            string query = "productModel_Add @name , @description , @detailInfo , @brand , @type";
            object[] para = new object[] { user.Name, user.Description, user.DetailedInfo, user.Brand, user.Type };
            if (DataProvider.Instance.ExecuteNonQuery(query, para) > 0)
            {
                return true;
            }
            return false;
        }

    }
}
