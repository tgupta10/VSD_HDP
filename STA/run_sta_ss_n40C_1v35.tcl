read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v35.lib

#read_verilog FIFO.v
read_verilog fifo_synth.v

#link_design fifo
link_design fifo_synth

read_sdc fifo_design.sdc

report_checks -fields {nets cap slew input_pins} -digits {3} -path_delay min_max > ss_n40C_1v35_timing.rpt
report_wns >> ss_n40C_1v35_timing.rpt
report_tns >> ss_n40C_1v35_timing.rpt
