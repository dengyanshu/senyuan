using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace mes
{
    public partial class form_input_pwd : Form
    {
        /// <summary>
        /// 输入的密码，用于窗体间数据的传值，传出
        /// </summary>
        public string Pwd = "";
        public form_input_pwd()
        {
            InitializeComponent();
        }
        /// <summary>
        /// 窗体加载事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void form_input_pwd_Load(object sender, EventArgs e)
        {
            this.txt_pwd.Text = "";
            this.txt_pwd.Focus();
            this.txt_pwd.Select();
        }
        /// <summary>
        /// 密码框的键盘事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                Pwd = this.txt_pwd.Text.Trim();
                this.Close();
            }
            else if (e.KeyCode == Keys.Escape)
            {
                Pwd = "";
                this.Close();
            }
        }
    }
}
