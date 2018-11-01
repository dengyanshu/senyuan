using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace mes
{
    class USBPrint
    {

        public static void WinApiPrintByte(string p_PrintName, byte[] p_Byte)
        {
            if (p_PrintName != null && p_PrintName.Length > 0)
            {
                IntPtr _PrintHandle;
                IntPtr _JobHandle = Marshal.AllocHGlobal(100);
                /**
                if (Win32API.OpenPrinter(p_PrintName, out _PrintHandle, IntPtr.Zero))
                {
                    ADDJOB_INFO_1 _JobInfo = new ADDJOB_INFO_1();
                    int _Size;
                    AddJob(_PrintHandle, 1, _JobHandle, 100, out _Size);
                    _JobInfo = (ADDJOB_INFO_1)Marshal.PtrToStructure(_JobHandle, typeof(ADDJOB_INFO_1));
                    System.IO.File.WriteAllBytes(p_PrintName, p_Byte);
                    ScheduleJob(_PrintHandle, _JobInfo.JobID);
                    ClosePrinter(_PrintHandle);
                    Marshal.FreeHGlobal(_JobHandle);
                }
                 * */
            }
        }

        [DllImport("User32.dll", CharSet = CharSet.Auto)]
        internal static extern IntPtr FindWindow(string lpEnumFunc, string lParam);
        [DllImport("User32.dll", CharSet = CharSet.Auto)]
        internal static extern void SetForegroundWindow(IntPtr lpEnumFunc);
        [DllImport("User32.dll", CharSet = CharSet.Auto)]
        internal static extern void keybd_event(byte key, int a, int b, int c);
        [DllImport("User32.dll", CharSet = CharSet.Auto)]
        internal static extern int MapVirtualKey(int code, int map);


        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
        public struct ADDJOB_INFO_1
        {
            [MarshalAs(UnmanagedType.LPTStr)]
            public string lpPath;
            public Int32 JobID;
        }
        [DllImport("winspool.drv", CharSet = CharSet.Auto)]
        public static extern bool AddJob(IntPtr ptrPrinter, Int32 iLevel, IntPtr ptrJob, Int32 iSize, out Int32 iCpSize);

        [DllImport("winspool.drv", CharSet = CharSet.Auto)]
        public static extern bool ScheduleJob(IntPtr ptrPrinter, Int32 JobID);

        [DllImport("winspool.drv", CharSet = CharSet.Auto)]
        public static extern bool ClosePrinter(IntPtr ptrPrinter);
    }
}
