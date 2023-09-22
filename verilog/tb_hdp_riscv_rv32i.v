module tb_hdp_riscv_rv32i;

reg clk,RN;
wire [31:0]WB_OUT,NPC;

hdp_riscv_rv32i rv32(clk,RN,NPC,WB_OUT);


always #3 clk=!clk;

initial begin 
RN  = 1'b1;
clk = 1'b1;

$dumpfile ("hdp_riscv_rv32i.vcd"); //by default vcd
$dumpvars (0, tb_hdp_riscv_rv32i);
  
  #5 RN = 1'b0;
  
  #300 $finish;

end
endmodule
