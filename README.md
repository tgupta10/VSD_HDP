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

To analyse combinational logic optimization.

To analyse sequential logic optimization. 

To analyse sequential logic optimization for unused outputs. 

</details>

<details>
 <summary> Reference codes </summary>

The RTL codes and their testbenches (opt_*, dff_const*, tb_dff_const*, and counter_opt*) are provided by VSD, also present at 

https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git

</details>
	
<details>
 <summary> Combinational logic optimizations: opt_check.v </summary>

Steps followed to check waveform of synthesized design of opt_check.v after optimization:
	
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
 <summary> Combinational logic optimizations: opt_check2.v </summary>

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
 <summary> Combinational logic optimizations: opt_check3.v </summary>
	
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
 <summary> Combinational logic optimizations: opt_check4.v </summary>
	
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
 <summary> Combinational logic optimizations: multiple_module_opt.v </summary>
	
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
 <summary> Combinational logic optimizations: multiple_module_opt2.v </summary>
	
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
 <summary> Sequential logic optimizations: dff_const1.v </summary>
	
I used the below commands to simulate the design of dff_const1.v:
	
```bash
iverilog <name verilog: dff_const1.v> <name testbench: tb_dff_const1.v>
./a.out
gtkwave tb_dff_const1.vdc
```	

Below is the screenshot of the obtained simulation, a we can see even when reset is zero, Q waits for next rising edge of clock:
	
![7_waveform_dff_const1](https://github.com/tgupta10/VSD_HDP/assets/86391769/fb9ef254-a911-4e27-b6d6-edd8f8fd27ad)


	
I used the below commands to view the synthesized design of dff_const1.v with optimizations:
	
```bash
yosys> read_liberty -lib <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> read_verilog <name of verilog file: dff_const1.v>
yosys> synth -top <name: dff_const1>
yosys> dfflibmap -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> abc -liberty <path to sky130_fd_sc_hd__tt_025C_1v80.lib>
yosys> show
```
	
Below is the screenshot of the obtained optimized design:
	
<img width="506" alt="dff_const1_synth" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/1809d6c2-f10e-404c-bd4a-6d8de7157bfb">



</details>
	
<details>
 <summary> Sequential logic optimizations: dff_const2.v </summary>
	
I used the below commands to simulate the design of dff_const2.v:
	
```bash
iverilog <name verilog: dff_const2.v> <name testbench: tb_dff_const2.v>
./a.out
gtkwave tb_dff_const2.vdc
```	

Below is the screenshot of the obtained simulation, as we can see Q is one regardless of the value of reset and clock:
	
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
	
Below is the screenshot of the obtained optimized design:
	
<img width="438" alt="dff_const2_synth" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/37d60203-d433-4e23-92fd-92b9d2d20334">


</details>

	
<details>
 <summary> Sequential logic optimizations: dff_const3.v </summary>
	
I used the below commands to simulate the design of dff_const3.v:
	
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
	
Below is the screenshot of the obtained design, the 2 flipflops are retained and optimization could not remove any of them:

<img width="651" alt="dff_const3synth" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/0e5f3ab6-d7e7-410d-a007-e0da72123889">


</details>
	
<details>
 <summary> Sequential logic optimizations: dff_const4.v </summary>
	
I used the below commands to simulate the design of dff_const4.v:
	
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
	
Below is the screenshot of the obtained optimized design, and no hardware was used as expected:
	
<img width="424" alt="dff_const4_synth" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/b229eeee-ea9e-4058-ba1b-2688f440aadb">

</details>
	
<details>
 <summary> Sequential logic optimizations: dff_const5.v </summary>
	
I used the below commands to simulate the design of dff_const5.v:
	
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
	
Below is the screenshot of the obtained optimized design, and the 2 flipflops are retained:
	
<img width="629" alt="dff_const5_synth" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/b4a8e84a-f1ad-4e2f-9120-199bd7424114">

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
	
Below is the screenshot of the obtained optimized design, and the only used output (count[0]) is present and 1 flipflop is used:
	
<img width="684" alt="counter_opt" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/10549f0f-c8d0-4bc8-8069-e14d80770a53">
	
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
	
Below is the screenshot of the obtained optimized design, and 3 flipflops are used in addition to the counting logic of all bits:
	
<img width="681" alt="counter_opt2" src="https://github.com/mariamrakka/vsd-hdp/assets/49097440/0d8a2613-cae2-4ab6-a8c1-a9bece64dce1">
	
</details>

# Day 4

<details>
 <summary> Objectives </summary>

</details>

# Day 5 

<details>
 <summary> Objectives </summary>

</details>
