using System;
using System.Diagnostics;
using System.ComponentModel;


class TestClass
{
    private Process startProcessWithOutput(string command, string[] args, bool showWindow)
    {
        Process p = new Process();
        string argsString = "";
        for (int i=0; i<args.Length; i++) 
        {
            argsString += " " + args[i];
        }
        p.StartInfo = new ProcessStartInfo(command, argsString);
        p.StartInfo.RedirectStandardOutput = false;
        p.StartInfo.RedirectStandardError = true;
        p.StartInfo.UseShellExecute = false;
        p.StartInfo.CreateNoWindow = !showWindow;
        p.Start();
        p.BeginErrorReadLine();
    
        return p;
    }

    static void Main(string[] args)
    {
        TestClass t = new TestClass();
        Process p = t.startProcessWithOutput("/home/meo/Utilities/neovim-unity", args, true);
        p.WaitForExit();
    }
}
