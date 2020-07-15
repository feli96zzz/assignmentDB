using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace ADO_Them_Xoa_Sua_TimKiem
{
    public class DataProvider
    {
        private static DataProvider instance;
        public static DataProvider Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new DataProvider();
                }
                return instance;
            }
            
        }

        private DataProvider() { }
        string connectionString = @"Data Source=.\SQLExpress;Initial Catalog=TIKI;Integrated Security=True";


        public DataTable ExcuteQuery(string query, object[] parameter = null)
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                //SqlCommand -> insert, update, delete do ko trả ra bảng chỉ ra biến dữ liệu
                //SqlDataAdapter -> select, để lấy hết bảng
                SqlCommand command = new SqlCommand(query, connection);
                if (parameter != null)
                {
                    string[] temp = query.Split(' ');
                    List<string> listPara = new List<string>();

                    foreach (string item in temp)
                    {
                        if (item[0] == '@')
                        {
                            listPara.Add(item);
                        }
                    }

                    for (int i = 0; i < parameter.Length; i++)
                    {
                        command.Parameters.AddWithValue(listPara[i], parameter[i]);
                    }
                }


                SqlDataAdapter adapter = new SqlDataAdapter(command);

                adapter.Fill(data);

                connection.Close();
            }
            return data;
        }
        
        public int ExecuteNonQuery(string query, object[] parameter = null)
        {
            int accpectedRows = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                if (parameter != null)
                {
                    string[] temp = query.Split(' ');
                    List<string> listPara = new List<string>();

                    foreach (string item in temp)
                    {
                        if (item != string.Empty && item[0] == '@')
                        {
                            listPara.Add(item);
                        }
                    }

                    for (int i = 0; i < parameter.Length; i++)
                    {
                        command.Parameters.AddWithValue(listPara[i], parameter[i]);
                    }
                }
                // thực hiện câu query trả về số dòng mà câu truy vấn thực hiện được
                accpectedRows = command.ExecuteNonQuery();
                connection.Close();
            }
            

            return accpectedRows;
        }
    }
}
