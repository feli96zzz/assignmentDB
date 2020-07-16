using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
// thêm vào
using System.Data.SqlClient;

namespace ADO_Them_Xoa_Sua_TimKiem
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void BtnXem_Click(object sender, EventArgs e)
        {
            UserBUS.Instance.Xem(dtgvData);
        }

        private void BtnThem_Click(object sender, EventArgs e)
        {
            if (UserBUS.Instance.Them(dtgvData))
            {
                MessageBox.Show("Thêm thành công");
                BtnXem_Click(sender, e);
            }
            else
            {
                MessageBox.Show("Thêm không thành công");
            }
        }

        private void BtnXoa_Click(object sender, EventArgs e)
        {
            if (UserBUS.Instance.XoaTheoID(dtgvData))
            {
                MessageBox.Show("Xóa thành công");
                BtnXem_Click(sender, e);
            }
            else
            {
                MessageBox.Show("Xóa không thành công");
            }
        }

        private void BtnSua_Click(object sender, EventArgs e)
        {
            if (UserBUS.Instance.Sua(dtgvData))
            {
                MessageBox.Show("Sửa thành công");
                BtnXem_Click(sender, e);
            }
            else
            {
                MessageBox.Show("Sửa không thành công");
                BtnXem_Click(sender, e);
            }
        }

        private void BtnDoanhThu_Click(object sender, EventArgs e)
        {
            UserBUS.Instance.DoanhThu(dtgvData, txbTimKiem.Text ,dateTimePicker1, dateTimePicker2);
            //string query = "SELECT ID as ID, Name as N'Tên', DateOfBirth as N'Ngày sinh', Info as N'Thông tin', Sex as N'Giới tính' FROM dbo.Users WHERE DateOfBirth > @date";// + txbTimKiem.Text;
            //command.Parameters.AddWithValue("@date", dateTimePicker1.Value);
            //object[] parameter = new object[] { dateTimePicker1.Value };
            //dtgvData.DataSource = DataProvider.Instance.ExcuteQuery(query, parameter);
        }

        private void BtnTiemKiem_Click(object sender, EventArgs e)
        {
            UserBUS.Instance.TimKiem(dtgvData, txbTimKiem.Text);
        }

        private void BtnHienThi_Click(object sender, EventArgs e)
        {
            UserBUS.Instance.HienThi(dtgvData, txbTimKiem.Text, dateTimePicker1);
        }
    }
}
