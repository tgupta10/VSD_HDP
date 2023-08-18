# VSD_HDP
This github repository is the summary of the progress resport by tgupta for VSD HDP tapeout program. 

Shortcuts:

[Day 0](#day-0)

[Day 1](#day-1)

[Day 2](#day-2)

[Day 3](#day-3)

[Day 4](#day-4)

[Day 5](#day-5)

# Day 0

<details>
 <summary> Objectives </summary>
To Install Ubuntu on Oracle VM machine 

To Install Yosys, iverilog, gtkwave tools.

</details>	
	
 <details>
 <summary> Yosys </summary>


 Yosys Installation
 
 Steps followed:
```bash
git clone https://github.com/YosysHQ/yosys.git
cd yosys-master 
sudo apt install make 
sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
make 
sudo make install
```
Screenshot after successful installation:

![1_Yosys_install](https://github.com/tgupta10/VSD_HDP/assets/86391769/e069562d-34ba-42c4-9dd9-cbd4d069d518)


Scrrenshot after successful launch:

![2_Yosys_launch](https://github.com/tgupta10/VSD_HDP/assets/86391769/196afcce-1dc3-489d-9287-4b72d1bbea7d)


</details>

 <details>
 <summary> iverilog </summary>


iverilog Installation

 Steps followed:
  ```bash
sudo apt-get install iverilog
 ```
 Screenshot after successful installation:

![3_iverilog_install](https://github.com/tgupta10/VSD_HDP/assets/86391769/d415622c-716d-4c95-873e-87db8c3f7b5a)


 Screenshot after successful launch:
 
![4_iverilog_launch](https://github.com/tgupta10/VSD_HDP/assets/86391769/ab34d6a4-29a8-4925-bf92-47f0700393b3)


</details>
 <details>
 <summary> gtkwave </summary>


 gtkwave installation

 Steps followed:
  ```bash
sudo apt-get install gtkwave
 ```
 Screenshot after successful installation:

![5_gtkwave_install](https://github.com/tgupta10/VSD_HDP/assets/86391769/847cc2d3-8175-43f8-af9b-4b552697b348)



Screenshot after successful launch:

![5_gtkwave_launch](https://github.com/tgupta10/VSD_HDP/assets/86391769/47a227f6-50da-45ee-9d04-403bcf5592ca)


</details>



# Day 1

<details>
 <summary> Objectives </summary>
To simulate RTL of a 2x1 mux. RTL and testbech is provided by VSD. Tool used is iverilog.

To view the waveform of the simulated 2x1 mux. Tool used is gtkwave.

To synthesize the 2x1 mux RTL and then generate synthesized RTL netlist. Tool used is Yosys.

</details>

<details>
 <summary> 2x1 mux reference codes </summary>
The RTL (good_mux.v), its testbench (tb_good_mux.v) and .lib files for 2x1 mux are provided by VSD, also present at https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git

</details>

<details>
 <summary> simulation and waveform </summary>
 
 Steps followed to simulate and view the waveforms for 2x1 mux:
	
 ```bash
 iverilog <name verilog: good_mux.v> <name testbench: tb_good_mux.v>
 ./a.out
 gtkwave tb_good_mux.vcd
 ```
	
 Screenshot for waveform in gtkview:
	
![1_good_mux_waveform](https://github.com/tgupta10/VSD_HDP/assets/86391769/6eb9dfb8-27e7-4e09-b44c-fa6c057d2bef)

 </details>

 </details>
<details>
 <summary> Synthesis </summary>
		
Steps followed for Synthesis of 2x1 mux:
		
```bash		
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: multiple_modules.v>
yosys> synth -top <name: sub_module1>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: sub_module1>
```
	
Screen shot synthesized 2x1 mux:
		
![3_synthesised_design](https://github.com/tgupta10/VSD_HDP/assets/86391769/3ee15cc1-bee9-4800-9097-c2cdf9e8ecde)

Steps followed to generate synthesized verilog netlist:
 ```bash
 yosys> write_verilog <file_name_netlist.v>
 yosys> write_verilog -noattr <file_name_netlist.v>
 ```
 
 Screenshot of the synthesized netlist:
 
![4_synthesised_netlist](https://github.com/tgupta10/VSD_HDP/assets/86391769/03741a86-6d61-4bbd-a358-8335f8e92607)

 
		
</details>

# Day 2

<details>
 <summary> Objectives </summary>
To synthesize and analyise heirarchical and flatten netlist for module "multiple_modules".

To synthesize sub module "sub_module1" from module "multiple_modules". 

To analyse different coding styles if DFF by simulating and synthesizing.

To analyse special cases of mux2 and mux8 designs by optimizing their synthesis.
</details>
<details>
 <summary> Reference codes </summary>
The RTL for multiple module (multiple_modules.v), the D-flipflop with asynchronous reset (dff_asyncres.v), the D-flipflop with asynchronous set (dff_async_set.v), the D-flipflop with synchronous reset (dff_syncres.v), their respective testbenches (tb_*), mult_2.v and mult_8.v are provided by VSD, also present at:
	
https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git
</details>
<details>
 <summary> Hier vs flatten Synthesis for module multiple_modules </summary>

Steps followed for Synthesis of module multiple_modules:
 
```bash		
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: multiple_modules.v>
yosys> synth -top <name: multiple_modules>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: multiple_modules>
yosys> write_verilog -noattr <name: multiple_modules_hier.v>
```

Screenshot for hierarchical synthesis of multiple_module:
![1_synthesis_multiple_modules](https://github.com/tgupta10/VSD_HDP/assets/86391769/bb8778f6-4448-42dd-b5e0-111b79a95ab2)
Screenshot of synthesized RTL netlist after hierarchical synthesis of multiple_module:
![2_synthesized_netlist_multiple_modules_hier](https://github.com/tgupta10/VSD_HDP/assets/86391769/3f9cab6f-4609-4f6a-8f25-e9713e713396)

Additional steps used in flattened synthesis of multiple_module:
		
```bash
yosys> flatten
yosys> write_verilog -noattr <name: multiple_modules_flat.v>
```

Screenshot for flattened synthesis of multiple_module:
![3_synthesis_multiple_modules_flat](https://github.com/tgupta10/VSD_HDP/assets/86391769/b1b8995a-e7a2-4f43-9bb5-78da69c3589c)
Screenshot of synthesized RTL netlist after flattened synthesis of multiple_module:
![4_synthesized_netlist_multiple_modules_flat](https://github.com/tgupta10/VSD_HDP/assets/86391769/caae8187-3d27-4abd-8515-930833d877b3)

</details>
<details>
 <summary> sub module synthesis for sub_module1 </summary>

Steps used for sub module synthesis of sub_module1

```bash		
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: multiple_modules.v>
yosys> synth -top <name: sub_module1>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: sub_module1>
```

Screenshot for sub module synthesis of sub_module1: 
![5_synthesis_sub_module1](https://github.com/tgupta10/VSD_HDP/assets/86391769/61fa0b0e-c66a-4e8b-a117-6fe01e68c1c2)

</details>
<details>
 <summary> Simulation & Synthesis: DFF asynchronous reset </summary>

Steps used to view dff_asyncres waveform:

```bash	
iverilog <name verilog: dff_asyncres.v> <name testbench: tb_dff_asyncres.v>
./a.out
gtkwave <name vcd file: tb_dff_asyncres.vcd>
```	
Screenshot of waveform for dff_async_reset:
![6_dff_async_reset_wave](https://github.com/tgupta10/VSD_HDP/assets/86391769/84cfb665-2755-4e7a-b7b6-792d157da383)

```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_asyncres.v>
yosys> synth -top <name: dff_asyncres>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: dff_asyncres>
```

Screenshot of synthesis for dff_async_reset:
![7_dff_async_reset_synth](https://github.com/tgupta10/VSD_HDP/assets/86391769/6a3f95d3-1b75-426a-9772-f7107628099f)

</details>
<details>
 <summary> Simulation & Synthesis: DFF asynchronous set </summary>

```bash	
iverilog <name verilog: dff_async_set.v> <name testbench: tb_dff_async_set.v>
./a.out
gtkwave <name vcd file: tb_dff_async_set.vcd>
```

Screenshot of waveform for dff_async_set:
![8_dff_async_set_wave](https://github.com/tgupta10/VSD_HDP/assets/86391769/3b1c450a-bc14-45d3-b088-28481ab8a095)

```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_async_set.v>
yosys> synth -top <name: dff_async_set>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: dff_async_set>
```

Screenshot of synthesis for dff_async_set:
![9_dff_async_set_synth](https://github.com/tgupta10/VSD_HDP/assets/86391769/8fed6cbb-6cc6-459c-a2c0-1ce663f4ebc9)

</details>
<details>
 <summary> Simulation & Synthesis: DFF synchronous reset </summary>

```bash	
iverilog <name verilog: dff_syncres.v> <name testbench: tb_dff_syncres.v>
./a.out
gtkwave <name vcd file: tb_dff_syncres.vcd>
```

 Screenshot of waveform for dff_sync_reset:
![10_dff_sync_reset_wave](https://github.com/tgupta10/VSD_HDP/assets/86391769/9ba0b44d-3de7-4ff1-8448-79bdde92144a)

```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_syncres.v>
yosys> synth -top <name: dff_syncres>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: dff_syncres>
```

Screenshot of synthesis for dff_sync_reset:
![11_dff_sync_reset_synth](https://github.com/tgupta10/VSD_HDP/assets/86391769/fccdf6c4-c34c-4417-9e7e-690e859119c6)

</details>
<details>
 <summary> Synthesis: mult_2 </summary>

```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: mult_2.v>
yosys> synth -top <name: mul2>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: mul2>
yosys> write_verilog -noattr <name: mul2_net.v>
```
![12_mul_@_synth](https://github.com/tgupta10/VSD_HDP/assets/86391769/34ea923b-764e-4609-9cf5-99d709b5e244)


</details>
<details>
 <summary> Synthesis: mult_8 </summary>

```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: mult_8.v>
yosys> synth -top <name: mult8>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show <name: mult8>
yosys> write_verilog -noattr <name: mult8_net.v>
```

![13_mul_8_synth](https://github.com/tgupta10/VSD_HDP/assets/86391769/c717b20b-9c08-4d00-8d04-bd1d971dd6ea)


</details>

# Day 3

<details>
 <summary> Objectives </summary>

</details>

# Day 4

<details>
 <summary> Objectives </summary>

</details>

# Day 5 

<details>
 <summary> Objectives </summary>

</details>
