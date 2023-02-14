rule cmdrules {
    meta:
        description = "detect submission script attempting to use command line tools"

    strings:
        // Shells
        $bash = "/bin/bash"
        $sh = "/bin/sh"
        $zsh = "/usr/bin/zsh"
        $chsh = "/usr/bin/csh"
        $sysexec = "system.exec"
        //$python = "python" // Should cover "python3" as well
        
        // Third Party Network Commands
        $curl = "curl "
        $wget = "wget "
        $ftp = "ftp "
        $netcat = "netcat "
        $ssh = "ssh "
        $scp = "scp "
        $telnet = "telnet "
        $nmap = "nmap "
        
        // Native Linux Binaries
        $uname = "uname "
        $cat = "cat "
        $ping = "ping "
        $ifconfig = "ifconfig "
        $iptables = "iptables "
        $gcc = "gcc "
        $rm = "rm -" // Added the '-' so it would detect aggressive use of "rm"
        $chmod = "chmod "
        $chown = "chown "
        $chroot = "chroot"
        $echo = "echo "
        // $who = "wh o" // Might be too strict
        // $ls = "ls" // Probably too strict for just detecting words

    condition:
        any of them
}

