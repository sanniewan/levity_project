module python_interface (
  input CLK_25MHZ,        // Main clock input (e.g., 25 MHz)
  output ALT_CLK,
  input RSTN,             // Reset input
  output [9:0] CH         // Channel output
);


  wire	clk_100MHz;

  clock clkpll(
    .clkin_25MHz(ALT_CLK),
    .clk_100MHz(clk_100MHz)
  );

  reg [31:0] FREQ_VAL = 32'd500;  // 1250 for 40,000 frequency with 100mHz clk
  reg [31:0] COUNTER = 32'd0;


  assign ALT_CLK  = CLK_25MHZ;
  // assign CH[0]  = clk_100MHz;  // testing for oscilloscope

  always @(posedge clk_100MHz or negedge RSTN) begin
    if (!RSTN) begin
        COUNTER <= 32'd0;
        CH[0] <= 1'b0;
    end else begin
        if (COUNTER >= FREQ_VAL) begin
            CH[0] <= ~CH[0];
            COUNTER <= 32'd0;
        end else begin
            CH[0] <= CH[0];
            COUNTER <= COUNTER + 32'd1;
        end
    end
  end

  
endmodule
