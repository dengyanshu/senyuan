using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace mes
{
    public class WriteLPT
    {
        #region 申明要引用的要调用的API
        //win32 api constants 
        private const uint GENERIC_READ = 0x80000000;
        private const uint GENERIC_WRITE = 0x40000000;
        private const int OPEN_EXISTING = 3;
        private const int INVALID_HANDLE_VALUE = -1;
        private const uint FILE_FLAG_OVERLAPPED = 0x40000000;   //异步通讯
        private const int MAXBLOCK = 4096;

        private const uint PURGE_TXABORT = 0x0001;  // Kill the pending/current writes to the comm port.
        private const uint PURGE_RXABORT = 0x0002;  // Kill the pending/current reads to the comm port.
        private const uint PURGE_TXCLEAR = 0x0004;  // Kill the transmit queue if there.
        private const uint PURGE_RXCLEAR = 0x0008;  // Kill the typeahead buffer if there.

        private const int EV_RXCHAR = 0x0001;

        [StructLayout(LayoutKind.Sequential)]
        private struct DCB
        {
            public int DCBlength;
            public int BaudRate;
            public int fBinary;
            public int fParity;
            public int fOutxCtsFlow;
            public int fOutxDsrFlow;
            public int fDtrControl;
            public int fDsrSensitivity;

            public int fTXContinueOnXoff;
            public int fOutX;
            public int fInX;
            public int fErrorChar;
            public int fNull;
            public int fRtsControl;

            public int fAbortOnError;
            public int fDummy2;
            public ushort wReserved;

            public ushort XonLim;
            public ushort XoffLim;
            public byte ByteSize;
            public byte Parity;
            public byte StopBits;
            public char XonChar;
            public char XoffChar;
            public char ErrorChar;

            public char EofChar;
            public char EvtChar;
            public ushort wReserved1;
        }
        /// <summary>
        /// 
        /// </summary>
        [StructLayout(LayoutKind.Sequential)]
        public struct COMMTIMEOUTS
        {
            public int ReadIntervalTimeout;
            public int ReadTotalTimeoutMultiplier;
            public int ReadTotalTimeoutConstant;
            public int WriteTotalTimeoutMultiplier;
            public int WriteTotalTimeoutConstant;
        }
        /// <summary>
        /// 
        /// </summary>
        [StructLayout(LayoutKind.Sequential)]
        public struct OVERLAPPED
        {
            public int Internal;
            public int InternalHigh;
            public int Offset;
            public int OffsetHigh;
            public int hEvent;
        }
        /// <summary>
        /// 
        /// </summary>
        [StructLayout(LayoutKind.Sequential)]
        public struct COMSTAT
        {
            public int cbOutQue;
            public int cbInQue;
            public int fReserved;
            public int fTxim;
            public int fEof;
            public int fXoffSent;
            public int fXoffHold;
            public int fRlsdHold;
            public int fDsrHold;
            public int fCtsHold;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="lpFileName">file name </param>
        /// <param name="dwDesiredAccess">access mode </param>
        /// <param name="dwShareMode">share mode </param>
        /// <param name="lpSecurityAttributes">SD</param>
        /// <param name="dwCreationDisposition">how to create </param>
        /// <param name="dwFlagsAndAttributes"> file attributes </param>
        /// <param name="hTemplateFile">handle to template file </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern int CreateFile(string lpFileName, uint dwDesiredAccess, int dwShareMode, int lpSecurityAttributes, int dwCreationDisposition, uint dwFlagsAndAttributes, int hTemplateFile);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to communications device </param>
        /// <param name="lpDCB">device-control block </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        private static extern bool GetCommState(int hFile, ref DCB lpDCB);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="lpDef">device-control string </param>
        /// <param name="lpDCB">device-control block </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        private static extern bool BuildCommDCB(string lpDef, ref DCB lpDCB);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to communications device </param>
        /// <param name="lpDCB">device-control block </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        private static extern bool SetCommState(int hFile, ref DCB lpDCB);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to comm device </param>
        /// <param name="lpCommTimeouts">time-out values </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool GetCommTimeouts(int hFile, ref COMMTIMEOUTS lpCommTimeouts);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to comm device </param>
        /// <param name="lpCommTimeouts">time-out values </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool SetCommTimeouts(int hFile, ref COMMTIMEOUTS lpCommTimeouts);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to file </param>
        /// <param name="lpBuffer">data buffer </param>
        /// <param name="nNumberOfBytesToRead">number of bytes to read </param>
        /// <param name="lpNumberOfBytesRead">number of bytes read </param>
        /// <param name="lpOverlapped">overlapped buffer </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool ReadFile(int hFile, byte[] lpBuffer, int nNumberOfBytesToRead, ref int lpNumberOfBytesRead, ref OVERLAPPED lpOverlapped);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to file </param>
        /// <param name="lpBuffer">data buffer </param>
        /// <param name="nNumberOfBytesToWrite">number of bytes to write </param>
        /// <param name="lpNumberOfBytesWritten">number of bytes written </param>
        /// <param name="lpOverlapped">overlapped buffer </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool WriteFile(int hFile, byte[] lpBuffer, int nNumberOfBytesToWrite, ref int lpNumberOfBytesWritten, ref OVERLAPPED lpOverlapped);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hObject">handle to object </param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool CloseHandle(int hObject);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to file</param>
        /// <param name="lpErrors"></param>
        /// <param name="lpStat"></param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool ClearCommError(int hFile, ref int lpErrors, ref COMSTAT lpStat);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile">handle to file</param>
        /// <param name="dwFlags"></param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool PurgeComm(int hFile, uint dwFlags);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile"></param>
        /// <param name="dwInQueue"></param>
        /// <param name="dwOutQueue"></param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool SetupComm(int hFile, int dwInQueue, int dwOutQueue);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile"></param>
        /// <param name="dwEvtMask">表明事件的掩码</param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool SetCommMask(int hFile, int dwEvtMask);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hFile"></param>
        /// <param name="dwEvtMask"></param>
        /// <param name="lpOverlapped"></param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern bool WaitCommEvent(int hFile, int dwEvtMask, ref OVERLAPPED lpOverlapped);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="lpSecurityAttributes"></param>
        /// <param name="bManualReset"></param>
        /// <param name="bInitialState"></param>
        /// <param name="lpName"></param>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern int CreateEvent(int lpSecurityAttributes, bool bManualReset, bool bInitialState, string lpName);
        #endregion

        /// <summary>
        /// SerialPort成員
        /// </summary>
        private int hComm = INVALID_HANDLE_VALUE;
        /// <summary>
        /// 标志并口初始化成功与否的标志
        /// </summary>
        private bool bOpened = false;
        /// <summary>
        /// 用属性返回标志变量
        /// </summary>
        public bool Opened
        {
            get { return bOpened; }
        }
        /// <summary>
        /// 并口的初始化函数
        /// </summary>
        /// <param name="lpFileName">端口名</param>
        /// <param name="baudRate">波特率</param>
        /// <param name="parity">校驗位</param>
        /// <param name="byteSize">數據位</param>
        /// <param name="stopBits">停止位</param>
        /// <returns></returns>
        public bool OpenPort(string lpFileName, int baudRate, byte parity, byte byteSize, byte stopBits)
        {
            #region
            if (hComm == INVALID_HANDLE_VALUE)
            {
                //uint ui = GENERIC_READ | GENERIC_WRITE;
                hComm = CreateFile(lpFileName, 0x40000000, 0, 0, OPEN_EXISTING, 0, 0);
                SetCommMask(hComm, EV_RXCHAR);
                return true;
            }
            else
            {
                //throw (new ApplicationException("並口已打開"));
            }
            SetupComm(hComm, MAXBLOCK, MAXBLOCK);

            COMMTIMEOUTS ctoCommPort = new COMMTIMEOUTS();
            GetCommTimeouts(hComm, ref ctoCommPort);
            ctoCommPort.ReadIntervalTimeout = Int32.MaxValue;
            ctoCommPort.ReadTotalTimeoutConstant = 0;
            ctoCommPort.ReadTotalTimeoutMultiplier = 0;
            ctoCommPort.WriteTotalTimeoutMultiplier = 10;
            ctoCommPort.WriteTotalTimeoutConstant = 1000;
            SetCommTimeouts(hComm, ref ctoCommPort);

            DCB dcbCommPort = new DCB();
            dcbCommPort.DCBlength = Marshal.SizeOf(dcbCommPort);
            GetCommState(hComm, ref dcbCommPort);    //取得並口的狀態

            dcbCommPort.BaudRate = baudRate;
            dcbCommPort.Parity = parity;
            dcbCommPort.ByteSize = byteSize;
            dcbCommPort.StopBits = stopBits;

            if (!SetCommState(hComm, ref dcbCommPort))
            {
                //throw (new ApplicationException("非法操作不能打开并口"));
            }
            PurgeComm(hComm, PURGE_RXCLEAR | PURGE_RXABORT);  //清空發送緩沖區的所有數據 
            PurgeComm(hComm, PURGE_TXCLEAR | PURGE_TXABORT);  //清空收掃沖的骨有據
            SetCommMask(hComm, EV_RXCHAR);
            bOpened = true;
            return true;
            #endregion
        }
        /// <summary>
        /// 清空發送緩沖區的所有數據
        /// </summary>
        public void CleanPortData()
        {
            PurgeComm(hComm, PURGE_RXCLEAR | PURGE_RXABORT);
        }
        /// <summary>
        /// 关闭并口
        /// </summary>
        /// <returns></returns>
        public bool ClosePort()
        {
            #region
            if (hComm == INVALID_HANDLE_VALUE)
            {
                return false;
            }
            if (CloseHandle(hComm))
            {
                hComm = INVALID_HANDLE_VALUE;
                bOpened = false;
                return true;
            }
            else
            {
                return false;
            }
            #endregion
        }
        /// <summary>
        /// 往并口写数据
        /// </summary>
        /// <param name="WriteBytes"></param>
        /// <returns></returns> 
        public bool WritePort(string text)
        {
            #region
            byte[] WriteBytes = System.Text.Encoding.Default.GetBytes(text);
            if (hComm == INVALID_HANDLE_VALUE)  //如果并口未打开
            {
                return false;
            }
            COMSTAT ComStat = new COMSTAT();
            int dwErrorFlags = 0;

            ClearCommError(hComm, ref dwErrorFlags, ref ComStat);
            if (dwErrorFlags != 0)
                PurgeComm(hComm, PURGE_TXCLEAR | PURGE_TXABORT);

            OVERLAPPED ovlCommPort = new OVERLAPPED();
            int BytesWritten = 0;
            // SET THE COMM TIMEOUTS.
            COMMTIMEOUTS ctoCommPort = new COMMTIMEOUTS();
            GetCommTimeouts(hComm, ref ctoCommPort);
            ctoCommPort.ReadIntervalTimeout = Int32.MaxValue;
            ctoCommPort.ReadTotalTimeoutConstant = 0;
            ctoCommPort.ReadTotalTimeoutMultiplier = 0;
            ctoCommPort.WriteTotalTimeoutMultiplier = 10;
            ctoCommPort.WriteTotalTimeoutConstant = 3000;
            //if (!SetCommTimeouts(hComm, ref ctoCommPort))
            //    return false;
            WriteFile(hComm, WriteBytes, WriteBytes.Length, ref BytesWritten, ref ovlCommPort);
            if (BytesWritten > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
            #endregion
        }
        /// <summary>
        /// 从并口读取数据
        /// </summary>
        /// <param name="NumBytes"></param>
        /// <param name="commRead"></param>
        /// <returns></returns> 
        public bool ReadPort(int NumBytes, ref byte[] commRead)
        {
            #region
            if (hComm == INVALID_HANDLE_VALUE)
            {
                return false;
            }
            COMSTAT ComStat = new COMSTAT();
            int dwErrorFlags = 0;

            ClearCommError(hComm, ref dwErrorFlags, ref ComStat);
            if (dwErrorFlags != 0)
                PurgeComm(hComm, PURGE_RXCLEAR | PURGE_RXABORT);

            if (ComStat.cbInQue > 0)
            {
                OVERLAPPED ovlCommPort = new OVERLAPPED();
                int BytesRead = 0;
                return ReadFile(hComm, commRead, NumBytes, ref BytesRead, ref ovlCommPort);
            }
            else
            {
                return false;
            }
            #endregion
        }
    }
}
