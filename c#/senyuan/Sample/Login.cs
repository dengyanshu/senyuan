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
    /// <summary>
    /// 该登陆窗体是初始窗体    登陆逻辑完成 跳转到主窗体
    /// </summary>
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }
        //简单模拟登陆窗体  登陆成功 跳转到主窗体   并且该窗体 不能关闭 
        //如果关闭 则当前所有应用结束  应该用visiable=false 进行控制  并且 主窗体关闭事件中写 application.exit();
        private void button1_Click(object sender, EventArgs e)
        {
            Form1 from_main = new Form1();
            from_main.Show();
            //登陆成功 该窗体visiable=false 隐藏 不能关闭 否则应用结束 主窗体关闭事件中 Application.Exit();
            this.Visible = false;
        }
    }
}
