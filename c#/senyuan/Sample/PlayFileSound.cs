using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace mes
{
    public class PlayFileSound
    {
        [DllImport("winmm.dll")]
        private static extern long sndPlaySound(string lpszSoundName, long uFlags);

        public static void PlaySound(string fileName)
        {
            sndPlaySound(fileName, 1);
        }
    }
}
