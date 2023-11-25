# VSD_HDP
This github repository is the summary of the progress resport by tgupta for VSD HDP tapeout program. 

Shortcuts:

[Day 0: Tool Installation](#day-0)

[Day 1: Learning - RTL Simulation, Synthesis and waveform](#day-1)

[Day 2: Learning - Multiple module and Sub module Synthesis](#day-2)

[Day 3: Learning - Optimization in synthesys for combinational and Sequential logic](#day-3)

[Day 4: Learning - Gate Level simulations](#day-4)

[Day 5](#day-5)

[Day 6: Implementation - FIFO presynthesis and post Synthesis](#day-6)

[Day 7: Learning - Basic STA and SDC format](#day-7)

[Day 8: Learning - Clock modelling and writing constraints](#day-8)

[Day 9: Implementation - Writing constraints to FIFO design](#day-9)

[Day 10: SPICE](#day-10)

[Day 11: SPICE](#day-11)

[Day 12: SPICE](#day-12)

[Day 13: SPICE](#day-13)

[Day 14: SPICE](#day-14)

[Day 15: SPICE](#day-15)

[Day 16 STA results with PVT variations on my FIFO design](#day-16)

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

To analyse combinational logic optimization.

To analyse sequential logic optimization. 

To analyse sequential logic optimization for unused outputs. 

To analyse sequential logic optimization for a counter design. 

</details>

<details>
 <summary> Reference codes </summary>

The RTL codes and their testbenches (opt_*, dff_const*, tb_dff_const*, and counter_opt*) are provided by VSD, also present at 

https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git

</details>
	
<details>
 <summary> Combinational logic optimizations for opt_check.v </summary>

Steps followed to synthesize design of opt_check.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: opt_check.v>
yosys> synth -top <name: opt_check>
yosys> opt_clean -purge
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized opt_check.v design:
	
![1_synth_opt_check](https://github.com/tgupta10/VSD_HDP/assets/86391769/6861b27e-a1d0-4df6-a27f-6ab915379b2e)


</details>
	
<details>
 <summary> Combinational logic optimizations for opt_check2.v </summary>

 Steps followed to check waveform of synthesized design of opt_check2.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: opt_check2.v>
yosys> synth -top <name: opt_check2>
yosys> opt_clean -purge
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
Snapshot for optimized opt_check2.v design:
	
![2_synth_opt_check2](https://github.com/tgupta10/VSD_HDP/assets/86391769/92d689e3-3c90-4259-84a6-036cab14812e)



</details>
	
<details>
 <summary> Combinational logic optimizations for opt_check3.v </summary>
	
 Steps followed to check waveform of synthesized design of opt_check3.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: opt_check3.v>
yosys> synth -top <name: opt_check3>
yosys> opt_clean -purge
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized opt_check3.v design:
	
![3_synth_opt_check3](https://github.com/tgupta10/VSD_HDP/assets/86391769/370111ca-fc00-4196-9caa-ee3d276db6ca)



</details>
	
<details>
 <summary> Combinational logic optimizations for opt_check4.v </summary>
	
 Steps followed to check waveform of synthesized design of opt_check4.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: opt_check4.v>
yosys> synth -top <name: opt_check4>
yosys> opt_clean -purge
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized opt_check4.v design:
	
![4_synth_opt_check4](https://github.com/tgupta10/VSD_HDP/assets/86391769/ad40eafd-9b60-4e0b-944f-34972b4ad8e8)



</details>
		
<details>
 <summary> Combinational logic optimizations for multiple_module_opt.v </summary>
	
Steps followed to check waveform of synthesized design of multiple_module_opt.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: multiple_module_opt.v>
yosys> synth -top <name: multiple_module_opt>
yosys> flatten 
yosys> opt_clean -purge
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized multiple_module_opt.v design:
 
![5_synth_multiple_module_opt](https://github.com/tgupta10/VSD_HDP/assets/86391769/19f34cab-d7c6-4bec-a939-7be8c6fbbbe3)


</details>
	
<details>
 <summary> Combinational logic optimizations for multiple_module_opt2.v </summary>
	
Steps followed to check waveform of synthesized design of multiple_module_opt2.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: multiple_module_opt2.v>
yosys> synth -top <name: multiple_module_opt2>
yosys> flatten 
yosys> opt_clean -purge
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized multiple_module_opt2.v design:
	
![6_synth_multiple_module_opt2](https://github.com/tgupta10/VSD_HDP/assets/86391769/fb8b2c82-beab-439d-afba-416943e3ab38)




</details>
	
<details>
 <summary> Sequential logic optimizations for dff_const1.v </summary>
	
Steps followed to check waveform of dff_const1.v
	
```bash
iverilog <name verilog: dff_const1.v> <name testbench: tb_dff_const1.v>
./a.out
gtkwave tb_dff_const1.vdc
```	

Below is the screenshot of the obtained simulation, a we can see even when reset is zero, Q waits for next rising edge of clock:
	
![7_waveform_dff_const1](https://github.com/tgupta10/VSD_HDP/assets/86391769/fb9ef254-a911-4e27-b6d6-edd8f8fd27ad)


	
Steps followed to check waveform of synthesized design of multiple_module_opt2.v after optimization:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_const1.v>
yosys> synth -top <name: dff_const1>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized dff_const1.v design:
	
![8_synth_dff_const1](https://github.com/tgupta10/VSD_HDP/assets/86391769/38d03b34-7dda-45de-a8aa-9e822318293d)




</details>
	
<details>
 <summary> Sequential logic optimizations for dff_const2.v </summary>
	
Steps followed to check waveform of dff_const1.v
	
```bash
iverilog <name verilog: dff_const2.v> <name testbench: tb_dff_const2.v>
./a.out
gtkwave tb_dff_const2.vdc
```	

Snapshot for optimized dff_const2.v design:
	
![9_waveform_dff_const2](https://github.com/tgupta10/VSD_HDP/assets/86391769/1bb4de4a-1eaf-475d-a7e8-4db568eb1b66)


I used the below commands to view the synthesized design of dff_const2.v with optimizations:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_const2.v>
yosys> synth -top <name: dff_const2>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized dff_const2.v design:
	
![10_synth_dff_const2](https://github.com/tgupta10/VSD_HDP/assets/86391769/3ac15b3c-2bfc-47c0-83a9-4dfa7017c19a)



</details>

	
<details>
 <summary> Sequential logic optimizations for dff_const3.v </summary>
	
Steps followed to check waveform of dff_const3.v
	
```bash
iverilog <name verilog: dff_const3.v> <name testbench: tb_dff_const3.v>
./a.out
gtkwave tb_dff_const3.vdc
```	

Below is the screenshot of the obtained simulation, as we can see Q does not follow Q1 immediately:
	
![11_waveform_dff_const3](https://github.com/tgupta10/VSD_HDP/assets/86391769/264c7a60-ac4b-4c4d-a23b-8f682a2e0399)


I used the below commands to view the synthesized design of dff_const3.v:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_const3.v>
yosys> synth -top <name: dff_const3>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized dff_const3.v design:

![12_synth_dff_const3](https://github.com/tgupta10/VSD_HDP/assets/86391769/0bd4a061-ca6a-4fb7-bb55-bc942ea5616f)



</details>
	
<details>
 <summary> Sequential logic optimizations for dff_const4.v </summary>
	
Steps followed to check waveform of dff_const4.v:
	
```bash
iverilog <name verilog: dff_const4.v> <name testbench: tb_dff_const4.v>
./a.out
gtkwave tb_dff_const4.vdc
```	

Below is the screenshot of the obtained simulation, as we can see Q and Q1 are one regardless of clk and reset:

![13_waveform_dff_const4](https://github.com/tgupta10/VSD_HDP/assets/86391769/bba1c44d-f1d9-489a-89a0-5651fa40beb4)

	
I used the below commands to view the synthesized design of dff_const4.v with optimizations:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_const4.v>
yosys> synth -top <name: dff_const4>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized dff_const4.v design:
	
![14_synth_dff_const4](https://github.com/tgupta10/VSD_HDP/assets/86391769/d5434b75-05e7-4b34-b1ee-41b533580ce6)


</details>
	
<details>
 <summary> Sequential logic optimizations for dff_const5.v </summary>
	
Steps followed to check waveform of dff_const5.v:
	
```bash
iverilog <name verilog: dff_const5.v> <name testbench: tb_dff_const5.v>
./a.out
gtkwave tb_dff_const5.vdc
```	

Below is the screenshot of the obtained simulation, as we can see when reset is zero, Q1 becomes one on the next rising edge of clk, and Q follows Q1 on the next rising edge of clk:

![15_waveform_dff_const5](https://github.com/tgupta10/VSD_HDP/assets/86391769/8b44e444-5d40-4daf-a639-b8a86692d1ca)

	
I used the below commands to view the synthesized design of dff_const5.v with optimizations:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_const5.v>
yosys> synth -top <name: dff_const5>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized dff_const5.v design:

![16_synth_dff_const5](https://github.com/tgupta10/VSD_HDP/assets/86391769/3b468c06-ae54-43d8-861a-3fd1f0912abb)


</details>
	
<details>
 <summary> Sequential logic optimizations for unused outputs: counter_opt.v </summary>
	
I used the below commands to view the synthesized design of counter_opt.v with optimizations:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: counter_opt.v>
yosys> synth -top <name: counter_opt>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized counter_opt.v design:
	
![17_synth_counter_opt](https://github.com/tgupta10/VSD_HDP/assets/86391769/9bc2c483-2aa1-4299-9191-25edd82895a7)

	
</details>
	
<details>
 <summary> Sequential logic optimizations for 3 used outputs: counter_opt2.v </summary>
	
I used the below commands to view the synthesized design of counter_opt2.v with optimizations:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: counter_opt2.v>
yosys> synth -top <name: counter_opt2>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Snapshot for optimized counter_opt2.v design:
	
![18_synth_counter_opt2](https://github.com/tgupta10/VSD_HDP/assets/86391769/635727af-1f78-4a8c-9677-fb2a862fca85)

	
</details>

# Day 4

<details>
 <summary> Objectives </summary>


To perform RTL simulation, synthesis and GLS simulation for ternary_operator_mux.v. Compare the RTL and Gate level simulation results. 

To perform RTL simulation, synthesis and GLS simulation for bad_mux.v. Compare the RTL and Gate level simulation results. 

To perform RTL simulation, synthesis and GLS simulation for blocking_caveat.v. Compare the RTL and Gate level simulation results. 
	
</details>
	
<details>
 <summary> Reference codes </summary>

	The RTL codes (*_mux.v and blocking_caveat.v) are  are provided by VSD, also present at https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git
	
</details>
	
<details>
 <summary> Simulation, synthesis, and GLS: ternary_operator_mux.v </summary>

Steps used to see waveform for ternary_operator_mux.v:
	
```bash
iverilog <name verilog: ternary_operator_mux.v> <name testbench: tb_ternary_operator_mux.v>
./a.out
gtkwave tb_ternary_operator_mux.vdc
```	

Snapshot for simulation run on RTL netlist :

![1_waveform_pre_synth_ternary_operator](https://github.com/tgupta10/VSD_HDP/assets/86391769/171c0e81-a639-488b-99c2-f489ad3e35e5)


Steps followed to run synthesis and write GLS netlist for ternary_operator_mux.v:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: ternary_operator_mux.v>
yosys> synth -top <name: ternary_operator_mux>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> write_verilog -noattr <name of netlist: ternary_operator_mux_net.v>
yosys> show
```
	
Snapshot for synthesized design:

![2_synth_ternary_operator](https://github.com/tgupta10/VSD_HDP/assets/86391769/04b1359f-090e-4fba-b718-52ccd423525b)


Snapshot for GLS netlist:
	
![3_GLS_netlist_ternary_operator](https://github.com/tgupta10/VSD_HDP/assets/86391769/1aea8305-5822-4524-ae53-da3db1cd61b7)


steps followed for GLS simulation:
	
```bash
iverilog <path to verilog model: ../mylib/verilog_model/primitives.v> <path to sky130_fd_sc_hd__tt_025C_1v80.lib: ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib> <name netlist: ternary_operator_mux_net.v> <name testbench: tb_ternary_operator_mux.v>
./a.out
gtkwave tb_ternary_operator_mux.vdc
```	
	
Snapshot of simulation run with GLS netlist, it matches with original simulation of RTL netlist:
	
![4_waveform_GLS_ternary_operator](https://github.com/tgupta10/VSD_HDP/assets/86391769/b4499876-b74f-4008-86d9-2139179de598)


	
</details>

<details>
 <summary> Simulation, synthesis, and GLS: bad_mux.v </summary>

Steps followed to run RTL simulation for bad_mux.v:
	
```bash
iverilog <name verilog: bad_mux.v> <name testbench: tb_bad_mux.v>
./a.out
gtkwave tb_bad_mux.vdc
```	

snapshot for RTL simulation waveform :

![5_waveform_pre_synth_bad_mux](https://github.com/tgupta10/VSD_HDP/assets/86391769/ca6bd07f-c24e-4aec-9374-481309dd5ab3)



Steps followed to run synthesis and write GLS netlist for bad_mux.v:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: bad_mux.v>
yosys> synth -top <name: bad_mux>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> write_verilog -noattr <name of netlist: bad_mux_net.v>
yosys> show
```
	
Snapshot for synthesised design:

![6_synth_bad_mux](https://github.com/tgupta10/VSD_HDP/assets/86391769/92224f7a-6da6-47a0-8650-e35c8cab0224)


	
Screenshot for GLS netlist:

![7_GLS_netlist_bad_mux](https://github.com/tgupta10/VSD_HDP/assets/86391769/d40ddfd9-dc24-47a1-ac5c-0201ac3fce19)

	
Steps followed to run GLS simulation of bad_mux.v:
	
```bash
iverilog <path to verilog model: ../mylib/verilog_model/primitives.v> <path to sky130_fd_sc_hd__tt_025C_1v80.lib: ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib> <name netlist: bad_mux_net.v> <name testbench: tb_bad_mux.v>
./a.out
gtkwave tb_bad_mux.vdc
```	
	
Snapshot of the wavform from GLS simulation. It clrearly mismatches with RTL simulation:
	
![8_waveform_GLS_bad_mux](https://github.com/tgupta10/VSD_HDP/assets/86391769/1dbb0623-1807-4341-af2d-592c56997fde)

	
</details>

<details>
 <summary> Simulation, synthesis, and GLS: blocking_caveat.v </summary>

Steps folowed to run RTL simulation for blocking_caveat.v:
	
```bash
iverilog <name verilog: blocking_caveat.v> <name testbench: tb_blocking_caveat.v>
./a.out
gtkwave tb_blocking_caveat.vdc
```	

Screenshot for RTL simulation showing incorrect behavior:

![8_waveform_GLS_blocking_caveat](https://github.com/tgupta10/VSD_HDP/assets/86391769/fefc73c3-d83d-4342-a15d-9e22ad65ad3f)


Steps followed to run synthesis and write GLS netlist for blocking_caveat.v:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: blocking_caveat.v>
yosys> synth -top <name: blocking_caveat>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> write_verilog -noattr <name of netlist: blocking_caveat_net.v>
yosys> show
```
	
Snapshot for Synthesised design:

![9_waveform_pre_synth_blocking_caveat](https://github.com/tgupta10/VSD_HDP/assets/86391769/cf0ed2cd-0f8c-4562-8ba2-d7daf9ea2aea)

	
Snapshot for GLS netlists:

![11_GLS_netlist_blocking_caveat](https://github.com/tgupta10/VSD_HDP/assets/86391769/7d773524-533a-4a6b-9285-9bf5e580464f)


Steps followed to run GLS simulation blocking_caveat.v:
	
```bash
iverilog <path to verilog model: ../mylib/verilog_model/primitives.v> <path to verilog model: ../mylib/verilog_model/sky130_fd_sc_hd.v> <name netlist: blocking_caveat_net.v> <name testbench: tb_blocking_caveat.v>
./a.out
gtkwave tb_blocking_caveat.vdc
```	
	
Snapshot of the wavform from GLS simulation. It clrearly mismatches with RTL simulation:
	

	
</details>

# Day 5 

<details>
 <summary> Objectives </summary>

Under Process

</details>

# Day 6 
<details>
 <summary> Objectives </summary>
To run and match presynthesis and postsynthesis simulations on my choice of Design. 
I have chosen to implement a FIFO design in RTL. 
</details>

<details>
 <summary> Introduction to FIFO- First in First out </summary>
In this day, almost every digital component works on a clock and it is very common that the sub-systems exchange data for computational and operational needs. An intermediary becomes necessary if:
	
- The data produced and the data consumer operate on different clock frequencies
	- If the data is being produced at a slower speed than the data is being consumed ***(f_write_clk < f_read_clk)*** the data transfer can take place through a single data register followed by asynchronous data synchronization methods (handshake or 2-clock synchronization)
	- If the data is being produced at a higher speed than the data is being consumed ***(f_write_clk > f_read_clk)*** the data transfer needs buffering which can be implemented through an asynchronous FIFO. The depth of the FIFO depends the write and read clock and the maximum data burst length.
- The data producer and the data consumer have a skew between their clocks
	- If the data is being produced at the same speed as the data is being consumed ***(f_write_clk = f_read_clk)*** and there is a skew between the producer and the consumer clock, the data can be transferred through a lock-up latch/register to overcome the skew
- There is a skew between the data production burst and data reception burst
	- If the producer and consumer operate at the same clock but have a large skew between when a burst of data is produced and when the burst of data is consumed. In such scenario, the produced data needs to be buffered and the sequence of transfer needs to be preserved, then a synchronous FIFO can be used. The depth of such FIFO is decided by the maximum burst length


Additional information can be found at [FIFO Architecture, Functions, and Applications](https://www.ti.com/lit/an/scaa042a/scaa042a.pdf)

Additional info on deciding the fifo depth can be found at [Calculation of FIFO Depth](https://hardwaregeeksblog.files.wordpress.com/2016/12/fifodepthcalculationmadeeasy2.pdf)
</details>

<details>
 <summary> Synchrounous FIFO </summary>

The type of FIFOs which have common write and read clock are called synchronous FIFO. Synchronous FIFOs are very common in a processor/controller ICs which work on a common system clock. Since all the sub-systems work on the same system clock they can make use of sync-FIFOs with a possible need for skew handling.

![fifo_sync](https://github.com/tgupta10/VSD_HDP/assets/86391769/0d4800e1-b769-4c3f-a815-643f4b57b4ac)


</details>

<details>
 <summary> Reference codes and other materials </summary>

The original RTL code and the Testbech is used from following github repository:

[https://github.com/sumukhathrey/Verilog_ASIC_Design#contents]

However there are a few modifications done over this code to achieve our goal.

</details>

<details>
 <summary> RTL simulation (presynthesis) </summary>

Steps used to run this simulation: 

```bash
iverilog  <name netlist: FIFO.v> <name testbench: tb_FIFO.v>
./a.out
gtkwave fifo.vcd
```

 The output waveform showing simulation of fifo before synthesis.
 
<img width="1206" alt="waveform_pre_synth" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/748d22f4-98db-43de-9c7d-4f58b3e0ace4">


</details> 

<details>
 <summary> Post Synthesis </summary>

Steps used to run post synthesis

```
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog FIFO.v
yosys> synth -top FIFO
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> opt_clean -purge
yosys> flatten
yosys> write_verilog -noattr fifo_synth.v
```

Steps used to run gate level synthesis

```
iverilog  ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v fifo_synth.v tb_synth_FIFO.v
./a.out
gtkwave fifo_synth.vcd

```

The output waveform showing simulation of fifo after synthesis.

<img width="1210" alt="waveform_post_synth" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/c5f51a5a-2411-41df-9157-5a6aa3b27192">

</details>

# Day 7 
<details>
 <summary> Objectives </summary>
To Learn basics of STA.

To understand constraints and .sdc format 

To learn basic dc_shell commands.
	
</details>

<details>
 <summary> Basics of STA </summary>
	
</details>

<details>
 <summary> Constraints and .sdc format </summary>
	
</details>

<details>
 <summary> basic dc_shell commands </summary>
	
</details>

# Day 8 
<details>
 <summary> Objectives </summary>

To Learn Advance concepts of writing constraints.

To learn writing constraints for sample designs.

</details>

<details>
 <summary> Advance concepts of writing constraints </summary>

</details>

<details>
 <summary> Writing constraints for sample design lab 8  </summary>

</details>

# Day 9 
<details>
 <summary> Objectives </summary>

To write constraints for my design FIFO.v .

We will use open STA for running the timing analysis on the constraints file we have developed. 

</details>

<details>
 <summary> Constraints for my design FIFO </summary>

Following are the constraints we have written to our FIFO design. 

```
create_clock -name myclk -period 10 [get_ports clk] 
set_clock_latency -source 1 [get_clocks myclk]
set_clock_latency 2 [get_clocks myclk]
set_clock_uncertainty 0.6 [get_clocks myclk]
set_clock_uncertainty 0.1 [get_clocks myclk]

set_input_transition -max 0.4 [get_ports rst]
set_input_transition -min 0.2 [get_ports rst]

set_input_transition -max 0.4 [get_ports ren]
set_input_transition -min 0.2 [get_ports ren]

set_input_transition -max 0.4 [get_ports wen]
set_input_transition -min 0.2 [get_ports wen]

set_input_transition -max 0.4 [get_ports din]
set_input_transition -min 0.2 [get_ports din]

set_input_delay -max 3 -clock  myclk [get_ports rst]
set_input_delay -min 1 -clock  myclk [get_ports rst]

set_input_delay -max 3 -clock  myclk [get_ports ren]
set_input_delay -min 1 -clock  myclk [get_ports ren]

set_input_delay -max 3 -clock  myclk [get_ports wen]
set_input_delay -min 1 -clock  myclk [get_ports wen]

set_input_delay -max 3 -clock  myclk [get_ports din]
set_input_delay -min 1 -clock  myclk [get_ports din]

set_output_delay -max 3 -clock myclk [get_ports dout]
set_output_delay -min 1 -clock myclk [get_ports dout]

set_load -max 0.2  [get_ports dout]
set_load -min 0.05 [get_ports dout]

```

</details>

<details>
 <summary> script "run_sta.tcl" used for STA using open STA tool </summary>

Following are the contents for run_sta.tcl

```
read_liberty sky130_fd_sc_hd__tt_025C_1v80.lib

#read_verilog FIFO.v
read_verilog fifo_synth.v

#link_design fifo
link_design fifo_synth

read_sdc fifo_design.sdc

report_checks -fields {nets cap slew input_pins} -digits {5} > timing.rpt

```

</details>

<details>
 <summary> Timing report </summary>

Following is the snapshot for final timing report.

<img width="1202" alt="timing_report" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/fccf29f3-afa7-4b15-98ef-3a0b62b90114">


</details>

# Day 10 
<details>
 <summary> Objectives </summary>
	
TO study MOS charactersitcs like Ids vs Vds. 
	
</details>

<details>
 <summary> Concepts </summary>

</details>

<details>
 <summary> SPICE deck  </summary>

Following are contents of our SPICE deck used in simulation.


```plaintext
.LIB "<name: xxx>.mod" CMOS_MODELS
R<name> <1st node> <second node> <value>
M<name> <drain> <gate> <source> <bulk> <name in tech file> w=<value> L=<value>
V<name> <1st node> <second node> <value>
C<name> <1st node> <second node> <value>
```

```plaintext
.lib cmos_models
.Model <name that should match in netlist> NMOS (TOX = .. VTH0 = .. U0 = .. GAMMA1 = ..)
.Model <name that should match in netlist> PMOS (TOX = .. VTH0 = .. U0 = .. GAMMA1 = ..)
.endl
```

```plaintext
.<mode: dc> <voltage node to sweep: Vin> <start value: 0> <end value: 2.5> <steps: 0.1> <voltage node to sweep: Vdd> <start value: 0> <end value: 2.5> <steps: 2.5>
```


ngspice commands used.

```plaintext
ngspice <spice file name>
plot -<name node>
```

</details>

<details>
 <summary> Simulation: Lab 1  </summary>
<img width="1198" alt="1_ids_vs_vgs" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/d3a9da6e-37b2-4b21-8736-b92525905f79">

</details>


# Day 11 
<details>
 <summary> Objectives </summary>
To deep dive further into MOS charactersctics. 
	
To study velocity saturation in shot channel MOS devices. 
	
</details>

<details>
 <summary> Concepts </summary>

</details>

<details>
 <summary> Simulation: Lab 2a  </summary>

Following are the ngspice sommands used to see results:

```plaintext
ngspice <name: day2_nfet_idvds_L015_W039.spice>
plot -<name: vdd#branch>
```
<img width="864" alt="1_lab2a" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/b38e0490-1e84-4324-aa19-a9fd32b495a6">


</details>

<details>
 <summary> Simulation: Lab 2b  </summary>

Following are the ngspice sommands used to see results:
	
```plaintext
ngspice <name: day2_nfet_idvgs_L015_W039.spice>
plot -<name: vdd#branch>
```

<img width="795" alt="1_lab2b" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/a168ed1d-2bb8-4d76-bbdd-853301096e84">


</details>

# Day 12 
<details>
 <summary> Objectives </summary>
To study VTC curve in CMOS. 
	
To see transient response of time varying input. 
	
</details>

<details>
 <summary> Concepts </summary>

</details>

<details>
 <summary> Simulation : Lab 3a  </summary>

ngspice commands used:

 ```plaintext
ngspice <name: day3_inv_vtc_Wp084_Wn036.spice>
plot <name: out> vs <name: in>
```

<img width="822" alt="1_lab3a" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/1a666e1b-d44d-4b7c-b415-eced5264f35d">


</details>

<details>
 <summary> Simulation : Lab 3b  </summary>

 ngspice commands used:

<img width="826" alt="2_lab3b" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/f05e957b-bb27-4d96-86ec-baca470a86a8">


</details>

# Day 13 
<details>
 <summary> Objectives </summary>

To study Noise Margin in a CMOS device.

</details>

<details>
 <summary> Concepts </summary>

</details>

<details>
 <summary> Simulation: Lab 4  </summary>

ngspice command used to plot the results: 

```plaintext
ngspice <name: day4_inv_noisemargin_wp1_wn036.spice>
plot <name: out> vs <name: in>
```

<img width="803" alt="1_lab4" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/ea6d292f-8fa8-4017-80db-53c86d23df10">


</details>

# Day 14 
<details>
 <summary> Objectives </summary>
	
Here we are going to learn CMOS charactersitcs : Supply Variation , Device Variation like process variation and gate oxide variation and its effects 
	
</details>

<details>
 <summary> Concepts </summary>

</details>

<details>
 <summary> Simulation: Lab 5a  </summary>

ngspice command used to plot the results: 

```plaintext
ngspice <name: day5_inv_supplyvariation_Wp1_Wn036.spice>
```

<img width="1279" alt="1_lab5a" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/dc63a7b4-72c1-4b02-98a0-a60f7a354269">


</details>

<details>
 <summary> Simulation: Lab 5b  </summary>
	
ngspice command used to plot the results: 

```plaintext
ngspice <name: day5_inv_devicevariation_wp7_wn042.spice>
plot <name: out> vs <name: in>
```

<img width="798" alt="2_lab5b" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/90646c57-698d-4be2-a4af-a9b25682b64d">


</details>

# Day 16 
<details>
 <summary> Objectives </summary>

To perform post-synthesys STA on my design using different ss (slow slow),ff (fast fast),tt (typical typical) PVT corners. 

To reported the WNS (Worst Negative Slack), TNS (Total Negative Slack = sum of the negative slack paths), and WHS (Worst Hold Slack) values. 

The skywater tt, ss and ff corners are found in https://github.com/Geetima2021/vsdpcvrd.git
 
</details>

<details>
 <summary> Constraints </summary>

 ```plaintext


```

</details>

<details>
 <summary> Sta scripts I have used  </summary>

Uploaded in "STA" directory.

```plaintext


```


</details>

<details>
 <summary> PVT variation curve for my FIFO design  </summary>

 <img width="270" alt="Table_WNS_WHS_TNS" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/a9d01006-70e3-48cc-9675-1bf28e486d30">
<img width="701" alt="PVT_variation_graph" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/71538823-53f0-49cc-8251-b05434c8ffc1">


</details>
