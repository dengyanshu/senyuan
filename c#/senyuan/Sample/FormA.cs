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
    public partial class FormA : Form
    {
        public FormA()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FormB formb = new FormB();
            formb.settbEvent += setTb;
            formb.Show();
        }

        private void setTb(string text)
        {
            textBox1.Text = text;
        }

        private void FormA_Load(object sender, EventArgs e)
        {

        }
    }
}
