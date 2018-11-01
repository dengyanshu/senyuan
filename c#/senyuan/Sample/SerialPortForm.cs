using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;

namespace mes
{
    public partial class SerialPortForm : Form
    {

        public string comName;
        public string bote;
        public string databit;
        public string stopbit;
        public string jiaoyanbit;
        
        private SerialPortForm()
        {
            InitializeComponent();
        }
        //c#的单例不能使用懒汉式 因为窗体关闭的时候 该窗体对象不为null 而是dispose状态 c#的垃圾回收很奇怪
        private static SerialPortForm spForm ;
        public static SerialPortForm getInstance()
        {
            if (spForm == null || spForm.IsDisposed)
            {
                spForm = new SerialPortForm();
                
            }
            return spForm;
        }

        //加载的时候 读取我的device 的serialport信息
        private void SerialPortFrom_Load(object sender, EventArgs e)
        {
            
            string[] ports=SerialPort.GetPortNames();
            if (ports != null && ports.Length > 0)
            {
                cb1.DataSource = ports;
            }
            else {
                ports = new string[] { "COM1", "COM2" };
                cb1.DataSource = ports;
            
            }

            //给所有的combo 默认选择一个
            cb2.SelectedIndex = 1;

        }
        //确定按钮
        private void btn1_Click(object sender, EventArgs e)
        {
            //确定按钮 关闭窗体？隐藏窗体
            this.Visible = false;
            //传值到主窗体
            comEvent(cb1.Text, cb2.Text);
        }
        //串口选择
        private void cb1_SelectedIndexChanged(object sender, EventArgs e)
        {
            comName = cb1.Text.Trim();
        }
       
     
        private void comboBox5_SelectedIndexChanged(object sender, EventArgs e)
        {
            bote = cb2.Text.Trim();
        }        

        //窗体关闭的时候
        private void SerialPortForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.Visible = false;

        }

        //用事件给主窗体传值
        public event Action<string,string> comEvent;

      


    }
}
