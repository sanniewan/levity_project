module PLLTop_testbench;

  /* Make a reset that pulses once. */
  reg reset = 0;


  // One-bit output
  wire clk_out;
  
  // Frequency value for the clock divider
  reg [31:0] freq_val;

//   input CLK_25MHZ,        // Main clock input (e.g., 25 MHz)
//   output ALT_CLK,
//   input RSTN,             // Reset input
//   output [9:0] CH         // Channel output

  initial begin
     $dumpfile("clockDivMod_test.vcd");
     $dumpvars(0,PLLTop_testbench); // test is this module name
     
     
     # 513 $finish;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #1 clk = !clk;


  clockdiv c1 ( .FREQ_VAL(freq_val), .clk_out(clk_out), .clk_in(clk), .reset(reset));


  initial
     $monitor("At time %t, clk_out = %h (%0d)",
              $time, clk_out, clk_out);
endmodule // test
