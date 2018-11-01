namespace mes
{
    partial class SerialPortForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.cb1 = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.cb2 = new System.Windows.Forms.ComboBox();
            this.btn1 = new System.Windows.Forms.Button();
            this.lab1 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // cb1
            // 
            this.cb1.FormattingEnabled = true;
            this.cb1.Location = new System.Drawing.Point(87, 61);
            this.cb1.Name = "cb1";
            this.cb1.Size = new System.Drawing.Size(121, 20);
            this.cb1.TabIndex = 0;
            this.cb1.SelectedIndexChanged += new System.EventHandler(this.cb1_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(52, 64);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(29, 12);
            this.label1.TabIndex = 2;
            this.label1.Text = "串口";
            // 
            // cb2
            // 
            this.cb2.FormattingEnabled = true;
            this.cb2.Items.AddRange(new object[] {
            "4800",
            "9600"});
            this.cb2.Location = new System.Drawing.Point(87, 101);
            this.cb2.Name = "cb2";
            this.cb2.Size = new System.Drawing.Size(121, 20);
            this.cb2.TabIndex = 9;
            this.cb2.SelectedIndexChanged += new System.EventHandler(this.comboBox5_SelectedIndexChanged);
            // 
            // btn1
            // 
            this.btn1.Location = new System.Drawing.Point(12, 166);
            this.btn1.Name = "btn1";
            this.btn1.Size = new System.Drawing.Size(260, 23);
            this.btn1.TabIndex = 11;
            this.btn1.Text = "确定";
            this.btn1.UseVisualStyleBackColor = true;
            this.btn1.Click += new System.EventHandler(this.btn1_Click);
            // 
            // lab1
            // 
            this.lab1.Location = new System.Drawing.Point(13, 333);
            this.lab1.Name = "lab1";
            this.lab1.Size = new System.Drawing.Size(259, 62);
            this.lab1.TabIndex = 12;
            
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(43, 108);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(41, 12);
            this.label5.TabIndex = 13;
            this.label5.Text = "波特率";
            // 
            // SerialPortForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 404);
            this.ControlBox = false;
            this.Controls.Add(this.label5);
            this.Controls.Add(this.lab1);
            this.Controls.Add(this.btn1);
            this.Controls.Add(this.cb2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cb1);
            this.Name = "SerialPortForm";
            this.Text = "SerialPort";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.SerialPortForm_FormClosing);
            this.Load += new System.EventHandler(this.SerialPortFrom_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cb1;
        private System.Windows.Forms.Label label1;
       
        private System.Windows.Forms.ComboBox cb2;
        private System.Windows.Forms.Button btn1;
        private System.Windows.Forms.Label lab1;
        private System.Windows.Forms.Label label5;
    }
}