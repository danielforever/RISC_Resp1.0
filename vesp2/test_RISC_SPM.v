`include "Clock_Unit.v"
`include "RISC_SPM.v"

module test_RISC_SPM ();
  reg rst;
  wire clk;
  parameter word_size = 16;
  reg [16:0] k;

  Clock_Unit M1 (clk);
  RISC_SPM M2 (clk, rst);

  wire [word_size-1:0] word0, word1, word2, word3, word4;

  assign word0 = M2.M2_SRAM.memory[0];
  assign word1 = M2.M2_SRAM.memory[1];
  assign word2 = M2.M2_SRAM.memory[2];
  assign word3 = M2.M2_SRAM.memory[3];
  assign word4 = M2.M2_SRAM.memory[4];

 initial #2800 $finish;
 
// Initialize Memory

initial begin
  #2 rst = 0; for (k=0;k<=255;k=k+1)M2.M2_SRAM.memory[k] = 0; #10 rst = 1;
end

initial begin
  $dumpfile("RISC_SPM.vcd");
  $dumpvars();

  #5
  M2.M2_SRAM.memory[0] = 'h2000;		// Load 1458 to RA
  M2.M2_SRAM.memory[1] = 1458; //  1458
  M2.M2_SRAM.memory[2] = 'h8000;		// Inc to 1459
  M2.M2_SRAM.memory[3] = 'hD000;		// Shift right 
  M2.M2_SRAM.memory[4] = 'h7000;    // halt
end 
endmodule
