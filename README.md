# VSD_HDP
This github repository is the summary of the progress resport by tgupta for VSD HDP tapeout program. 

Shortcuts:

[Day 0](#day-0)

[Day 1](#day-1)

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

