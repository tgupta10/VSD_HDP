# VSD_HDP
This github repository is the summary of the progress resport by tgupta for VSD HDP tapeout program. 

Shortcuts:

[Day 0: Tool Installation](#day-0)

[Day 1: Learning - RTL Simulation, Synthesis and waveform](#day-1)

[Day 2: Learning - Multiple module and Sub module Synthesis](#day-2)

[Day 3: Learning - Optimization in synthesys for combinational and Sequential logic](#day-3)

[Day 4: Learning - Gate Level simulations](#day-4)

[Day 5](#day-5)

[Day 6: Implementation - RiscV RV32I presynthesis and post Synthesis](#day-6)

[Day 7: Learning - Basic STA and SDC format](#day-7)

[Day 8: Learning - Clock modelling and writing constraints](#day-8)

[Day 9: Implementation - Writing constraints to RiscV RV32I](#day-9)

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
I have chosen to implement RISCV RV32I Instruction set in RTL. 
</details>

<details>
 <summary> Introduction to RISCV RV32I </summary>
This project provides an insight into the working of a few important instructions of the instruction set of a Single cycle Reduced Instruction Set Computer - Five(RISC-V) Instruction Set Architecture suitable for use across wide-spectrum of Applications from low power embedded devices to high performance Cloud based Server processors. The base RISC-V is a 32-bit processor with 31 general-purpose registers, so all the instructions are 32-bit long. Some Applications where the RISC-V processors have begun to make some significant threads are in Artificial intelligence and machine learning, Embedded systems, Ultra Low power processing systems etc.
</details>

<details>
 <summary> RISCV Architecture and Instruction set </summary>

<img width="713" alt="image" src="https://github.com/tgupta10/VSD_HDP/assets/86391769/baed30dd-e658-445e-9142-f68b444efd5c">

</details>

<details>
 <summary> Reference codes and other materials </summary>

The original RTL code and the Testbech is used from following github repository:
https://github.com/vinayrayapati/rv32i

However there are a few modifications done over this code to achieve our goal for example changing the module name

</details>

<details>
 <summary> RTL simulation (presynthesis) </summary>

Steps used to run this simulation: 

```bash
iverilog  <name netlist: hdp_riscv_r32i.v> <name testbench: tb_hdp_riscv_r32i.v>
./a.out
gtkwave hdp_riscv_r32i.vdc
```

 The output waveform showing the instructions performed in a 5-stage pipelined architecture.
 
 Instruction 1:add r6,r2,r1
 
![Instruction1](https://github.com/tgupta10/VSD_HDP/assets/86391769/b1cff01c-3d1d-48b2-a591-85c8a6136f68)


 Instruction 2:sub r7,r1,r2
 
![Instruction2](https://github.com/tgupta10/VSD_HDP/assets/86391769/11dd8729-32ff-45c0-8934-6febd2378fe5)


 Instruction 3:and r8,r1,r3
 
![Instruction3](https://github.com/tgupta10/VSD_HDP/assets/86391769/df4fc79c-95ec-49f5-a34a-a27b29804099)


 Instruction 4:or r9,r2,r5
 
![Instruction4](https://github.com/tgupta10/VSD_HDP/assets/86391769/36ce2acd-8ade-4756-9962-476ca314ba6c)


 Instruction 5:xor r10,r1,r4
 
![Instruction5](https://github.com/tgupta10/VSD_HDP/assets/86391769/ce65280f-75ff-4632-93e9-bc0f2314fd93)

 Instruction 6:slt r11,r2,r4
 
![Instruction6](https://github.com/tgupta10/VSD_HDP/assets/86391769/ae679476-e281-4b6b-8bfb-f4d5b7e0f0dc)


 Instruction 7:addi r12,r4,5
 
![Instruction7](https://github.com/tgupta10/VSD_HDP/assets/86391769/f9c20a24-5ef7-4435-8e14-e2b4049834e6)


 Instruction 8:sw r3,r1,2
 
![Instruction8](https://github.com/tgupta10/VSD_HDP/assets/86391769/21c5e5d7-b544-4525-84c9-2b0fae628619)


 Instruction 9:lw r13,r1,2
 
![Instruction9](https://github.com/tgupta10/VSD_HDP/assets/86391769/89380efe-3de9-4d18-8c67-f603bd462c25)


 Instruction 10:beq r0,r0,15
 
 After branching, performing
 Instruction 11:add r14,r2,r2
 
![Instruction10](https://github.com/tgupta10/VSD_HDP/assets/86391769/a6cb7298-98f3-4b11-a25d-ba1495b2b87a)


 Instruction 12:bne r0,r1,20
 
 After branching, performing
 Instruction 13:addi r12,r4,5
 


 Instruction 14:sll r15,r1,r2(2)
 
 

 Instruction 15:srl r16,r14,r2(2)
 
 
 Full 5-stage instruction pipeline and pc-increment description Waveform
 
![full_5stage](https://github.com/tgupta10/VSD_HDP/assets/86391769/a62c5c06-6947-483e-81eb-d2f1816ee777)


</details> 

<details>
 <summary> Post Synthesis </summary>

Steps used to run post synthesis

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog hdp_riscv_rv32i.v
synth -top hdp_riscv_rv32i	
dfflibmap -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
proc ; opt
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
write_verilog -noattr hdp_riscv_rv32i_synth.v
```

Steps used to run gate level synthesis

```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v hdp_riscv_rv32i_synth.v tb_hdp_riscv_rv32i.v
./a.out
gtkwave hdp_riscv_rv32i.vcd

```

NOTE : POST SYNTHESIS NOT MATCHING CURRENTLY !!! STILL NEED TO FIX !!!

![post_synth_error](https://github.com/tgupta10/VSD_HDP/assets/86391769/b38573f8-9f0a-4f2c-9f28-0d46a76448b1)


</details>

# Day 7 
<details>
 <summary> Objectives </summary>
To Learn basics of STA.
To understand constraints and .sdc format 
To learn basic dc_shell commands.
	
</details>

# Day 8 
<details>
 <summary> Objectives </summary>

To Learn Advance concepts of writing constraints.
To learn writing constraints for sample designs.

</details>

# Day 9 
<details>
 <summary> Objectives </summary>

To write constraints for my design hdp_riscv_rv32i.
We will use open STA for running the timing analysis on the constraints file we have deveoped. 

</details>

<details>
 <summary> Constraints for my design hdp_riscv_rv32i </summary>

UNDER DEVELOPMENT !! 

</details>

<details>
 <summary> script used for STA using open STA tool </summary>

UNDER DEVELOPMENT !! 

</details>
