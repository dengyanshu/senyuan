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
    public partial class FormB : Form
    {
        public FormB()
        {
            InitializeComponent();
        }
        //事件委托有2种 一种 是无返回值的action  一种是Func
        public event Action<string> settbEvent;
        private void button1_Click(object sender, EventArgs e)
        {
            string text = textBox1.Text.Trim();
            settbEvent(text);
        }
    }
}
