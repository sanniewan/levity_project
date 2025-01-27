module python_interface (
  input CLK_25MHZ,        // Main clock input (e.g., 25 MHz)
  input RSTN,             // Reset input
  input RXD,              // Serial input
  output ALT_CLK,
  output [9:0] CH         // Channel output

);

  reg	clk_100MHz;
  reg o_Rx_DV;
  // reg [7:0] o_Rx_Byte;
  reg [31:0] o_Rx_Four_Bytes;
  reg [14:0] freq_divider;



  clock clkpll(
    .clkin_25MHz(ALT_CLK),
    .clk_100MHz(clk_100MHz)
  );

  four_byte_receiver_rx four_serial_data (
    .i_Clock(CLK_25MHZ), 
    .i_Rx_Serial(RXD), 
    .o_Rx_DV(o_Rx_DV), 
    .o_Rx_Four_Bytes(o_Rx_Four_Bytes)
  );

  freq_select freq_1 (
    .RSTN(RSTN),
    .clk_100MHz(clk_100MHz),
    .o_Rx_Four_Bytes(o_Rx_Four_Bytes),
    .o_Rx_DV(o_Rx_DV),
    .freq_divider(freq_divider)
  );

  reg [31:0] COUNTER = 32'd0;
  assign ALT_CLK  = CLK_25MHZ;

  always @(posedge clk_100MHz or negedge RSTN) begin
    if (!RSTN) begin
        COUNTER <= 32'd0;
        CH[0] <= 1'b0;
    end else begin
        if (COUNTER >= freq_divider) begin
            CH[0] <= ~CH[0];
            COUNTER <= 32'd0;
        end else begin
            CH[0] <= CH[0];
            COUNTER <= COUNTER + 32'd1;
        end
    end
  end

  
endmodule
