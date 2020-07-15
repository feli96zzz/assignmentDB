// lớp nghiệp vụ
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ADO_Them_Xoa_Sua_TimKiem
{
    class UserBUS
    {
        private static UserBUS instance;
        public static UserBUS Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new UserBUS();
                }
                return instance;
            }

        }
        
        private UserBUS() { }

        public void Xem(DataGridView data)
        {
            data.DataSource = UserDAO.Instance.Xem();
        }

        public void HienThi(DataGridView data, string month, DateTimePicker dtpk)
        {
            data.DataSource = UserDAO.Instance.HienThi(month, dtpk);
        }
        public void DoanhThu(DataGridView data, string maNhaBan, DateTimePicker dtpk, DateTimePicker dtpk2)
        {
            data.DataSource = UserDAO.Instance.DoanhThu(maNhaBan, dtpk, dtpk2);
        }

        public void TimKiem(DataGridView data, string text)
        {
            data.DataSource = UserDAO.Instance.TimKiem(text);
        }

        public bool XoaTheoID(DataGridView data)
        {
            string ID = data.SelectedCells[0].OwningRow.Cells["id"].Value.ToString();
            return UserDAO.Instance.XoaTheoID(ID);
        }

        public bool Sua(DataGridView data)
        {
            DataGridViewRow row = data.SelectedCells[0].OwningRow;

            string id = row.Cells["id"].Value.ToString();
            string name = row.Cells["name"].Value.ToString();
            string description = row.Cells["description"].Value.ToString();
            string detailedInfo = row.Cells["detailedInfo"].Value.ToString();
            string brand = row.Cells["brand"].Value.ToString();
            string type = row.Cells["type"].Value.ToString();

            UserDTO user = new UserDTO() {Id = id, Name = name, Description = description, DetailedInfo = detailedInfo, Brand = brand, Type = type };
            


            return UserDAO.Instance.Sua(id, user);
        }


        public bool Them(DataGridView data)
        {
            DataGridViewRow row = data.SelectedCells[0].OwningRow;

            string name = row.Cells["name"].Value.ToString();
            string description = row.Cells["description"].Value.ToString();
            string detailedInfo = row.Cells["detailedInfo"].Value.ToString();
            string brand = row.Cells["brand"].Value.ToString();
            string type = row.Cells["type"].Value.ToString();

            UserDTO user = new UserDTO() { Name = name, Description = description, DetailedInfo = detailedInfo, Brand = brand, Type = type };


            return UserDAO.Instance.Them(user);
        }
    }
}
