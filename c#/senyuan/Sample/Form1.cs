using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Data.SqlClient;
using System.IO.Ports;
using LabelManager2;

namespace mes
{
    public partial class Form1 : Form


    {

        //单独调试数据库应用时需用到参数
        public string DatabaseServer; //数据库服务器
        public string DatabaseName;//数据库名
        public string DatabaseUser;//数据库用户
        public string DatabasePassword; //密码


        private string com_name="COM1"; //串口选择
        private string bote="9600";//选择
        private SerialPort sp;

        /**
        private string jb = @"
                            ^XA
                            ^JMA
                            ^PR2
                            ^LH130,70
                            ^BY3,3,N^FO10,0^BCN,90,N,N,N^FD21530313697S23000556^FS
                            ^A0N,45,57^FO10,102^CI0^FH_^FDS/N:21530313697S23000556^FS

                            ^BY3,3,N^FO10,167^BCN,90,N,N,N^FD54A51B36FD50^FS
                            ^A0N,45,54^FO10,269^CI0^FH_^FDMAC:54A51B36FD50^FS
                            ^XZ

                            ";*/

        private string jb = @"^XA
                                ^MMT
                                ^PW1181
                                ^LL0768
                                ^LS0
                                ^FT238,51^A0N,33,33^FH\^FDGONGKA^FS
                                ^FT40,51^A0N,33,33^FH\^FDNAME^FS
                                ^FT40,116^A0N,33,33^FH\^FDCLASS^FS
                                ^BY4,3,68^FT42,203^BCN,,Y,N
                                ^FD>:CARDID^FS
                                ^PQ1,0,1,Y^XZ


                                ";

        public Form1()
        {
            InitializeComponent();
        }

        //表单载入  从数据库读取所有信息  dgv 展示
        private void Form1_Load(object sender, EventArgs e)
        {
            //1、读取下当前设备的串口信息
            string[] ports = SerialPort.GetPortNames();
            if (ports.Length == 0)
            {
                showMessage("当前设备没有串口，请注意！", true);
            }

            //2、初始化串口
            sp = new SerialPort();
            sp.PortName = com_name;
            sp.BaudRate = Convert.ToInt32(bote);
            sp.StopBits = StopBits.One;
            sp.DataBits = 8;
            sp.Parity = Parity.None;




            string sql = "select *  from  employee";
            DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnSting(), CommandType.Text, sql);
            dataGridView1.AutoGenerateColumns = false;
            dataGridView1.DataSource = ds.Tables[0];
            showMessage("获取数据成功！共从数据库取到" + dataGridView1.Rows.Count + "条数据", false);
        }

     
       
        //搜索后台数据 重现加载dgv
        private void btn1_Click(object sender, EventArgs e)
        {
            string text=tb1.Text.Trim();
            string sql = "select *  from  employee where EmployeeName  LIKE '%" + text + "%'";
            DataSet ds = SqlHelper.ExecuteDataset(SqlHelper.GetConnSting(), CommandType.Text, sql);
            dataGridView1.AutoGenerateColumns = false;
            dataGridView1.DataSource = ds.Tables[0];
            if (dataGridView1.Rows.Count > 0)
            {
                dataGridView1.Rows[0].Selected = true;
                playOKSound();
                showMessage("通过关键字" + text + "获取数据成功！共从数据库取到" + dataGridView1.Rows.Count + "条数据", false);
            }
            else
            {
                playFailSound();
                showMessage("通过关键字" + text + "获取数据失败！共从数据库取到" + dataGridView1.Rows.Count + "条数据", true);
            }
            
        }
        //串口设置按钮
        private void btn3_Click(object sender, EventArgs e)
        {
            //c#很奇怪的地方 懒汉式单例会因为对象已释放 而出现异常 因为c#的窗体关闭 该对象还不是null 只是被销毁了 c#的垃圾回收器跟java很不一样
            SerialPortForm spFrom = SerialPortForm.getInstance();
            spFrom.comEvent += setComAndBote;
            spFrom.Show();
        }

        //主窗体设置com 口和波特率事件
        private void setComAndBote(string com,string bote)
        {
            this.com_name = com;
            this.bote = bote;
            sp.PortName = com_name;
            sp.BaudRate = Convert.ToInt32(bote);
        }





        //打印
        private void button2_Click(object sender, EventArgs e)
        {
            DataGridViewRow dgvrow = dataGridView1.SelectedRows[0];
            string cell0 = dgvrow.Cells[0].Value.ToString();//物理卡号
            string cell1 = dgvrow.Cells[1].Value.ToString();//name
            string cell2 = dgvrow.Cells[2].Value.ToString();
            string cell3 = dgvrow.Cells[3].Value.ToString();//class
            string cell4 = dgvrow.Cells[4].Value.ToString();
            string cell5 = dgvrow.Cells[5].Value.ToString();//工卡
            string cell6 = dgvrow.Cells[6].Value.ToString();
            string cell7 = dgvrow.Cells[7].Value.ToString();

            /**
             * 串口打印
            sp.Open();
            jb = jb.Replace("NAME",cell1).Replace("CLASS",cell3).Replace("GONGKA",cell5).Replace("CARDID",cell0);
            sp.Write(jb);
            sp.Close();
            */

            /**
             
             并口打印
             
            WriteLPT write = new WriteLPT();
            write.OpenPort("LPT1", 9600, 0, 8, 1);
            jb = jb.Replace("NAME", "NAME:"+cell1).Replace("CLASS", "CLASS:"+cell3).Replace("GONGKA", "GONGKA:"+cell5).Replace("CARDID", cell0);
            write.WritePort(jb);
            write.ClosePort();
            */

            LabelManager2.ApplicationClass labApp = null;
            LabelManager2.Document doc = null;
            string labFileName = System.Windows.Forms.Application.StartupPath + @"\emp2.Lab";
            //string labFileName =  @"d:\lab\emp2.Lab";
           
            try
            {

                if (!File.Exists(labFileName))
                {
                    MessageBox.Show("没有找到标签模版");
                    return;
                }
                labApp = new LabelManager2.ApplicationClass();
                labApp.Documents.Open(labFileName, false);// 调用设计好的label文件
                doc = labApp.ActiveDocument;


                
                //下面这些是给模板的变量传值进去                         
                doc.Variables.FormVariables.Item("Var0").Value = "姓名："+cell1;
                doc.Variables.FormVariables.Item("Var1").Value = "工卡：" + cell5;
                doc.Variables.FormVariables.Item("Var2").Value = "班组：" + cell3;
                doc.Variables.FormVariables.Item("Var3").Value = cell0;



                //下面这行是打印份数的定义
                doc.PrintDocument(1);






            }
            catch (Exception ex)
            {
                MessageBox.Show("出錯啦，原因如下：\n\r" + ex.Message, "出錯啦");
            }
            finally
            {
                labApp.Documents.CloseAll(true);
                labApp.Quit();//退出
                labApp = null;
                doc = null;
                GC.Collect(0);
            }

            PlayYesSound();

           

        }


        //测试打印
        private void btn4_Click(object sender, EventArgs e)
        {
            sp.Open();
            sp.Write(jb);
            showMessage("当前串口设置为：" + sp.BaudRate + "," + sp.DataBits + "," + sp.Parity + "," + sp.StopBits, true);
            sp.Close();
        }



        //登陆窗体跳转过来的  登陆窗体 visable=false; 直接关闭主窗体 应用结束不了 
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            System.Windows.Forms.Application.Exit();
        }


        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            this.Close();
            //showMessage("你的输入有误", true);
        }





        /// <summary>
        /// 播放OK声音
        /// </summary>
        public void playOKSound()
        {
            System.Media.SystemSounds.Asterisk.Play();
        }
        /// <summary>
        /// 播放Fail声音
        /// </summary>
        public void playFailSound()
        {
            System.Media.SystemSounds.Hand.Play();
        }


        private void PlayYesSound()
        {
            try
            {
                System.Media.SystemSounds.Asterisk.Play();
            }
            catch (Exception ex)
            {
                showMessage(ex.Message, true);
                return;
            }
        }
        private void PlayNOSound()
        {
            try
            {
                //string path = System.Windows.Forms.Application.StartupPath + "\\" + FilePath.Substring(FilePath.LastIndexOf("/") + 1);
                string path = "";
                if (File.Exists(path))
                {
                    PlayFileSound.PlaySound(path);
                }
            }
            catch (Exception ex)
            {
                showMessage(ex.Message, true);
                return;
            }
        }


        /// <summary>
        /// 向信息框送入信息
        /// </summary>
        /// <param name="yourMessage"></param>
        /// <param name="isWaring"></param>
        public void showMessage(string yourMessage, bool isWaring)
        { //向信息框送入信息。
            #region
            try
            {
                yourMessage = yourMessage.Replace("ServerMessage:", "");
                richTextBox1.Text = richTextBox1.Text + System.DateTime.Now.ToLongTimeString() + " - " + yourMessage + "\r\n";
                richTextBox1.Select(0, richTextBox1.Text.Length);
                richTextBox1.SelectionColor = Color.Yellow;
                if (richTextBox1.Text.Length > 5000)
                {
                    richTextBox1.Text = richTextBox1.Text.Substring(richTextBox1.Text.Length - 5000);
                }

                if (isWaring == true)
                {
                    richTextBox1.Select(richTextBox1.Text.Length - yourMessage.Length - 1, yourMessage.Length);
                    richTextBox1.SelectionColor = Color.Red;
                    richTextBox1.SelectionFont = new System.Drawing.Font("微软雅黑", 12F);
                }
                else
                {
                    richTextBox1.Select(richTextBox1.Text.Length - yourMessage.Length - 1, yourMessage.Length);
                    richTextBox1.SelectionColor = Color.GreenYellow;
                    richTextBox1.SelectionFont = new System.Drawing.Font("微软雅黑", 12F);
                }
                //让文本框获取焦点   
                //this.richTextBox1.Focus();
                //设置光标的位置到文本尾   
                this.richTextBox1.Select(this.richTextBox1.TextLength, 0);
                //滚动到控件光标处   
                this.richTextBox1.ScrollToCaret();

                //将内容存为文件。
                if (System.IO.File.Exists(System.Windows.Forms.Application.StartupPath + @"\showMessageStdTxn.txt") == true)
                {
                    System.IO.File.Delete(System.Windows.Forms.Application.StartupPath + @"\showMessageStdTxn.txt");
                }
                richTextBox1.SaveFile(System.Windows.Forms.Application.StartupPath + @"\showMessageStdTxn.txt", RichTextBoxStreamType.PlainText);
            }
            catch
            { }
            #endregion
        }



        /// <summary>
        /// 更新一个由客户端传回的记录集
        /// </summary>
        /// <param name="DataSetWithSQL"></param>
        /// <param name="SQLString"></param>
        /// <returns></returns>
        public bool UpdateDataSetBySQL(DataSet DataSetWithSQL, string SQLString)
        {
            #region
            try
            {

                string ConnectionString = "Data Source=" + DatabaseServer +
                        ";Initial Catalog=" + DatabaseName +
                        ";password=" + DatabasePassword +
                        ";Persist Security Info=True;User ID=" + DatabaseUser;
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {

                    conn.ConnectionString = ConnectionString;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(SQLString, conn);
                    SqlCommandBuilder objCommandBuilder = new SqlCommandBuilder(da);
                    da.Update(DataSetWithSQL.Tables[0]);
                    conn.Close();
                    return true;
                }

            }
            catch (Exception er)
            {
                MessageBox.Show(er.ToString(), this.Text, MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            #endregion
        }
        /// <summary>
        /// 通用执行存储过程程序.
        /// </summary>
        /// <param name="SQLCmd">传入的SqlCommand对象</param>
        /// <param name="ReturnDataSet">执行存储过程后返回的数据集</param>
        /// <param name="ReturnValue">执行存储过程的返回值</param>
        /// <returns>将SQLCmd执行后的参数刷新并传回，主要返回存储过程中的out参数</returns>
        public SqlCommand RunStoredProcedure(SqlCommand SQLCmd, out DataSet ReturnDataSet, out int ReturnValue)
        {
            #region
            ReturnValue = 0;
            try
            {

                string ConnectionString = "Data Source=" + DatabaseServer +
                        ";Initial Catalog=" + DatabaseName +
                        ";password=" + DatabasePassword +
                        ";Persist Security Info=True;User ID=" + DatabaseUser;
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    SQLCmd.Connection = conn;
                    SQLCmd.CommandType = CommandType.StoredProcedure;
                    SQLCmd.CommandTimeout = conn.ConnectionTimeout;
                    SQLCmd.Parameters.Add("RETURN_VALUE", SqlDbType.Int);
                    SQLCmd.Parameters["RETURN_VALUE"].Direction = ParameterDirection.ReturnValue;

                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = SQLCmd;

                    DataSet ds = new DataSet("WCFSQLDataSet");
                    adapter.Fill(ds, "WCFSQLDataSet");

                    ReturnDataSet = ds;
                    conn.Close();
                    ReturnValue = (int)SQLCmd.Parameters["RETURN_VALUE"].Value;
                    //ReturnValue = int.Parse(SQLCmd.Parameters["RETURN_VALUE"].Value.ToString());
                    return SQLCmd;
                }


            }
            catch (Exception er)
            {
                ReturnDataSet = null;
                MessageBox.Show(er.ToString(), this.Text, MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            #endregion
        }
        /// <summary>
        /// 执行一个指定的SQL字串，并返回一个记录集
        /// 在浏览器下执行时，直接调用浏览器的WCF服务器来传送记录集
        /// </summary>
        /// <param name="SQLString">SQL字串</param>
        /// <returns>返回的记录集</returns>
        public DataSet GetDataSetWithSQLString(string SQLString)
        {
            #region
            try
            {

                string ConnectionString = "Data Source=" + DatabaseServer +
                                    ";Initial Catalog=" + DatabaseName +
                                    ";password=" + DatabasePassword +
                                    ";Persist Security Info=True;User ID=" + DatabaseUser;
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    SqlCommand comm = new SqlCommand();
                    comm.Connection = conn;
                    comm.CommandText = SQLString;

                    comm.CommandType = CommandType.Text;
                    comm.CommandTimeout = conn.ConnectionTimeout;

                    DataSet ds = new DataSet("SQLDataSet");
                    SqlDataAdapter adapter = new SqlDataAdapter();
                    adapter.SelectCommand = comm;
                    adapter.Fill(ds, "SQLDataSet");

                    conn.Close();
                    return ds;
                }

            }
            catch (Exception e)
            {
                MessageBox.Show(e.ToString(), this.Text, MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            #endregion
        }




        #region 公共的方法，操作数据库的方法
        /// <summary>
        /// 执行返回受影响的行数的方法
        /// </summary>
        /// <returns></returns>
        private int ExecuteNonQuery(string sql)
        {
            #region
            int result = 0;
            string ConnectionString = "Data Source=" + DatabaseServer +
                            ";Initial Catalog=" + DatabaseName +
                            ";password=" + DatabasePassword +
                            ";Persist Security Info=True;User ID=" + DatabaseUser;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                if (con.State == ConnectionState.Closed) { con.Open(); }
                SqlCommand cmd = null;
                try
                {
                    cmd = new SqlCommand(sql, con);
                    result = cmd.ExecuteNonQuery();
                }
                catch { result = 0; }
            }
            return result;
            #endregion
        }
        /// <summary>
        /// 执行返回第一行的第一列的方法
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        private object ExecuteScalar(string sql)
        {
            #region
            object obj = null;
            string ConnectionString = "Data Source=" + DatabaseServer +
                            ";Initial Catalog=" + DatabaseName +
                            ";password=" + DatabasePassword +
                            ";Persist Security Info=True;User ID=" + DatabaseUser;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                if (con.State == ConnectionState.Closed) { con.Open(); }
                SqlCommand cmd = null;
                try
                {
                    cmd = new SqlCommand(sql, con);
                    obj = cmd.ExecuteScalar();
                }
                catch { obj = null; }
            }
            return obj;
            #endregion
        }
        /// <summary>
        /// 查询返回数据表的方法
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        private DataTable GetDataTableBySql(string sql)
        {
            #region
            DataTable dt = new DataTable();
            string ConnectionString = "Data Source=" + DatabaseServer +
                            ";Initial Catalog=" + DatabaseName +
                            ";password=" + DatabasePassword +
                            ";Persist Security Info=True;User ID=" + DatabaseUser;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                if (con.State == ConnectionState.Closed) { con.Open(); }
                SqlDataAdapter sda = null;
                try
                {
                    sda = new SqlDataAdapter(sql, con);
                    sda.Fill(dt);
                }
                catch { dt = null; }
            }
            return dt;
            #endregion
        }
        /// <summary>
        /// 只能输入数字的方法，
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txt_KeyPress(object sender, KeyPressEventArgs e)
        {
            #region
            TextBox textBox = sender as TextBox;
            char a = e.KeyChar;
            textBox.SelectedText = "";
            string text = textBox.Text.Trim();
            if (e.KeyChar == (char)8)
            {
                if (text.Trim().Length > 0)
                {
                    text = text.Substring(0, text.Length - 1);
                }
                else
                {
                    text = "";
                }
            }
            else
            {
                switch (a)
                {
                    case '1':
                        text = text + "1";
                        break;
                    case '2':
                        text = text + "2";
                        break;
                    case '3':
                        text = text + "3";
                        break;
                    case '4':
                        text = text + "4";
                        break;
                    case '5':
                        text = text + "5";
                        break;
                    case '6':
                        text = text + "6";
                        break;
                    case '7':
                        text = text + "7";
                        break;
                    case '8':
                        text = text + "8";
                        break;
                    case '9':
                        text = text + "9";
                        break;
                    case '0':
                        text = text + "0";
                        break;
                }
            }
            textBox.Text = "";
            textBox.Text = text;
            textBox.SelectionStart = textBox.Text.Length;
            e.Handled = true;
            #endregion
        }
        #endregion


        /*
         * 
         *  
         * Set the printer to Shared, and make note of the name that you give it.
            Then go to Start | Run, and enter the line
            NET USE LPT1 \\name of your computer\shared name of printer
            You will now be able to issue the command
            COPY /b \path\filename.prn LPT1:

            /b 参数不用也可以。*/
        private void button1_Click(object sender, EventArgs e)
        {

            string wo = "TEST002";
            string tmpFile = "d:\\123.txt";
            string prtName = @"\\WIN7-20140313GI\test";
            StringBuilder str = new StringBuilder();

            str.Append("^XA \r\n"); //打印命令开始
            str.Append("^LL 600^FS \r\n");//定义标签长度 105SL 300 DPI (1mm 12pt) 50mm*12
            str.Append("^PW 1200 \r\n");  //定义标签寬度 100mm*12
            str.Append("^FO40,60^A@N,55,35,E:ARIALR.FNT^FDWO:" + wo + "^FS \r\n");//定义坐标,字体
            str.Append("^FO40,150^BY4,4^BCN,100,N,N,N,A^FR^FD" + wo + "^FS \r\n");//128码
            str.Append("^XZ");//结束打印



            using (System.IO.StreamWriter sw = new System.IO.StreamWriter(tmpFile))
            {
                sw.Write(str.ToString());
            }

            System.IO.File.Copy(tmpFile, prtName, true);
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            sp.StopBits = StopBits.One;
            sp.DataBits = 8;
            sp.Parity = Parity.Even;
            sp.Open();
            sp.Write(jb);
            showMessage("当前串口设置为：" + sp.BaudRate + "," + sp.DataBits + "," + sp.Parity + "," + sp.StopBits, true);
            sp.Close();
        }
        //数据位8 无校验
        private void button3_Click(object sender, EventArgs e)
        {
            

            SerialPort sp = new SerialPort();
            sp.PortName = "COM1";
            sp.BaudRate = 9600;
            sp.StopBits = StopBits.One;
            sp.DataBits = 8;
            sp.Parity = Parity.None;
            sp.Open();
            sp.Write(jb);
            showMessage("当前串口设置为：" + sp.BaudRate + "," + sp.DataBits + "," + sp.Parity + "," + sp.StopBits, true);
            showMessage("发送给串口的数据为：" + jb,true);
            sp.Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            WriteLPT write = new WriteLPT();
            write.OpenPort("LPT1", 9600, 0, 8, 1);
            string jb = @"^XA

^CI26

^SEE:GB18030.DAT  

^CW1,E:SIMSUN.FNT  

^FO200,200^A1N,48,48^FD中文^FS 

^FT448,288^BQ2,2,10^A1N,48,48^FD中文^FS  

^XZ
";
            write.WritePort(jb);
            write.ClosePort();
        }
        //用codesoft打印
        private void button1_Click_1(object sender, EventArgs e)
        {
                LabelManager2.ApplicationClass labApp = null;
                LabelManager2.Document doc = null;
                string labFileName=System.Windows.Forms.Application.StartupPath + @"\emp.Lab";              
                try
                {
 
                    if (!File.Exists(labFileName))
                    {
                        MessageBox.Show("没有找到标签模版");
                        return;
                    }
                    labApp = new LabelManager2.ApplicationClass();
                    labApp.Documents.Open(labFileName, false);// 调用设计好的label文件
                    doc = labApp.ActiveDocument;
                        
                        
                         
                    //下面这些是给模板的变量传值进去                         
                    doc.Variables.FormVariables.Item("name").Value = "zhangsan";
                    doc.Variables.FormVariables.Item("card").Value = "054545";
                    doc.Variables.FormVariables.Item("class").Value = "class121212";
                    doc.Variables.FormVariables.Item("cardid").Value = "5454545";
                           
                    //下面这行是打印份数的定义
                    doc.PrintDocument(1);
                          
                 
 
                        
                    
                   
                }
                catch (Exception ex)
                {
                    MessageBox.Show("出錯啦，原因如下：\n\r"+ex.Message,"出錯啦");
                }
                finally
                {
                    labApp.Documents.CloseAll(true);
                    labApp.Quit();//退出
                    labApp = null;
                    doc = null;
                    GC.Collect(0);
                }
                

        }

       

    }
}