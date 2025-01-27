// takes in the pll clock, the frequency selection data, and data valid signal
// when data valid is high, frequency selection data is read and frequency is maintained until the next data valid signal

module freq_select (
    input wire        RSTN,            // reset
    input wire        clk_100MHz,      // 100 MHz clock input
    input wire [31:0] o_Rx_Four_Bytes, // 32-bit frequency selection data
    input wire        o_Rx_DV,         // data valid signal
    output reg [15:0] freq_divider     // divider value for frequency generation
);

localparam DIV_39K9  = 16'd1253;  // ~39.9 kHz
localparam DIV_40K   = 16'd1250;  // 40 kHz
localparam DIV_40K1  = 16'd1246;  // ~40.1 kHz

always @(posedge clk_100MHz or negedge RSTN) begin
    if (!RSTN) begin
        freq_divider <= DIV_40K;
    end
    else if (o_Rx_DV) begin
        case (o_Rx_Four_Bytes)
            32'd1: freq_divider <= DIV_39K9;
            32'd2: freq_divider <= DIV_40K;
            32'd3: freq_divider <= DIV_40K1;
            default: freq_divider <= DIV_40K; // default case for invalid values
        endcase
    end
end

endmodule