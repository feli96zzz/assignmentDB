using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BTL
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
        public void TimKiem(DataGridView data, DateTimePicker dtpk)
        {
            data.DataSource = UserDAO.Instance.TimKiem(dtpk);
        }
        public bool Xoa(DataGridView data)
        {
            string ID = data.SelectedCells[0].OwningRow.Cells["id"].Value.ToString(); 
            return UserDAO.Instance.Xoa(ID);
        }
        public bool Sua(DataGridView data)
        {
            DataGridViewRow row = data.SelectedCells[0].OwningRow;
            int OldID =(int) row.Cells["id"].Value;
            int id = (int)row.Cells["id"].Value;
            string name = row.Cells["name"].Value.ToString();
            string description = row.Cells["description"].Value.ToString();
            string status = row.Cells["status"].Value.ToString();
            string detailedInfo = row.Cells["detailedInfo"].Value.ToString();
            string brand = row.Cells["brand"].Value.ToString();
            string type = row.Cells["type"].Value.ToString();
            UserDTO productmodel = new UserDTO() { Id = id, Name = name, Description = description, Status = status, DetailedInfo = detailedInfo, Brand=brand,Type = type };
            return UserDAO.Instance.Sua(OldID, productmodel);
        }
        public bool Them(DataGridView data)
        {
            DataGridViewRow row = data.SelectedCells[0].OwningRow;     
            string name = row.Cells["name"].Value.ToString();
            string description = row.Cells["description"].Value.ToString();
            string status = row.Cells["status"].Value.ToString();
            string detailedInfo = row.Cells["detailedInfo"].Value.ToString();
            string brand = row.Cells["brand"].Value.ToString();
            string type = row.Cells["type"].Value.ToString();
            UserDTO productmodel = new UserDTO() { Name = name, Description = description, Status = status, DetailedInfo = detailedInfo,Brand= brand, Type = type };
            return UserDAO.Instance.Them(productmodel);
        }
    }
}
