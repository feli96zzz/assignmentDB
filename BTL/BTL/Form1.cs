using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BTL
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnXem_Click(object sender, EventArgs e)
        {
            UserBUS.Instance.Xem(dtgvData);
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            if (UserBUS.Instance.Them(dtgvData))
            {
                MessageBox.Show("Them thành công");
            }
            else MessageBox.Show("Them thất bại");
            btnXem_Click(sender, e);
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            //MessageBox.Show(DataProvider.Instance.ExecuteNonQuery("delete Product where id_product = 2").ToString());
            if (UserBUS.Instance.Xoa(dtgvData))
            {
                MessageBox.Show("Xóa thành công");
            }
            else MessageBox.Show("Xóa thất bại");
            btnXem_Click(sender, e);
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            //comboBox1.DataSource = UserDAO.Instance.Xem();
            //comboBox1.DisplayMember = "id_product";
            if (UserBUS.Instance.Sua(dtgvData))
            {
                MessageBox.Show("Sửa thành công");
            }
            else MessageBox.Show("Sửa thất bại");
            btnXem_Click(sender, e);
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            UserBUS.Instance.TimKiem(dtgvData, dateTimePicker1);
        }

    }
}
