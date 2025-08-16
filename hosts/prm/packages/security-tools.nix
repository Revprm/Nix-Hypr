{ pkgs, ... }:

{
  security-packages = with pkgs; [
    # Network Analysis
    wireshark
    nmap
    burpsuite
    tcpdump

    # File Analysis
    exiftool
    file
    binwalk
    foremost
    yara

    # Cryptography & Password Tools
    john
    hashcat

    # Steganography
    steghide
    stegseek
    zsteg
    stegsolve

    # Reverse Engineering
    gdb
    ghidra-bin
    cutter

    # Digital Forensics
    volatility3 # This is in your system packages, consider moving here

    # Audio Analysis
    sonic-visualiser
  ];
}
