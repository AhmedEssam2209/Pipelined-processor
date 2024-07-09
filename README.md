<h1>Pipelined-processor</h1>



<h2>Description</h2>
Designed and implemented a 5-stage pipelined RISC processor using VHDL on modelsim, and an assembler using C++.

The processor in this project has a RISC-like instruction set architecture. There are eight
4-byte general purpose registers; R0, till R7. Another two specific registers, One works as a
program counter (PC). The other works as a stack pointer (SP); and hence; points to the top of
the stack. The initial value of SP is (2^12-1). The memory address space is 4 K of 16-bit
width and is word addressable. (N.B. word = 2 bytes). The data bus between memory and the
processor is 16-bit for instruction memory and 32-bit widths for data memory.


<h2>Languages and Utilities Used</h2>

- <b> VHDL </b>
- <b> C++ (Assembler) </b> 



<h2>Screenshots :</h2>

<p align="center">
Assembler: <br/>
<img src="https://imgur.com/8hkbcDQ.png" height="80%" width="80%" alt=""/>
<br />
<br />
Pipeline (.io file in repo):  <br/>
<img src="https://imgur.com/XwJcOSd.png" height="80%" width="80%" alt=""/>
<br />
<br />
Waveform on modelsim:  <br/>
<img src="https://imgur.com/RPwICuh.png" height="80%" width="80%" alt=""/>
<br />
<br />


</p>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
