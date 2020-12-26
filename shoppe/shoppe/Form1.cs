using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;

namespace shoppe
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlCommand command;
        SqlConnection conn = new SqlConnection(@"Data Source=DESKTOP-KMNS09Q\SQLEXPRESS;Initial Catalog=Shopee;Integrated Security=True");//Nho doi lai duong dan
        SqlDataAdapter adapter = new SqlDataAdapter();
        public Form1()
        {
            InitializeComponent();
            pictureBox1.Image = new Bitmap(Application.StartupPath + "\\image\\94557138_1204930936504722_3329135653433638912_n.png");
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        void Login()
        {
            command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "sp_DangNhap";
            command.Parameters.Add("@tendangnhap", SqlDbType.NVarChar).Value = tbTK.Text.Trim();
            command.Parameters.Add("@matkhau", SqlDbType.NVarChar).Value = tbMK.Text.Trim();
            adapter.SelectCommand = command;
            SqlDataReader dta = command.ExecuteReader();
            if (dta.Read() == true)
            {
                MessageBox.Show("Đăng nhập thành công!");
                this.Hide();
            }
            else
            {
                MessageBox.Show("Đăng nhập thất bại!");
            }
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
            connection.Open();
            Login();
            connection.Close();
            /*try
            {
                conn.Open();
                /*string tk=tbTK.Text;
                string mk=tbMK.Text;
                string sql="select * from NguoiDung where TaiKhoan= '"+tk+"' and MatKhau='"+mk+"'";
                SqlCommand cmd=new SqlCommand(sql, conn);
                SqlDataReader dta=cmd.ExecuteReader();
                if(dta.Read()==true)
                {
                    MessageBox.Show("Đăng nhập thành công!");
                    this.Hide();
                    //FormMain mainfrm = new FormMain();
                    //mainfrm.ShowDialog();
                }
                else{
                    MessageBox.Show("Đăng nhập thất bại!");
                }
            }
            catch(Exception)
            {
                MessageBox.Show("Lỗi kết nối!");
            }*/
        }
    }
}
