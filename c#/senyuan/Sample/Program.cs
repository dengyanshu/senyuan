using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace mes
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //主程序是登陆窗体 跳转到mainForm.Show();  loginForm.Visiable=false;mainForm关闭事件调用Application.Exit();
            Application.Run(new Form1());
        }
    }
}
