module BoundFlasher
(
    input clk, reset_n, flick,
    output reg [15:0] light
);

wire [3:0] counter_val;
wire upcount;
wire enable;

UpDownCounter counter (
    .clk(clk), .reset_n(reset_n), .upcount(upcount), .enable(enable),
    .out(counter_val)
);

FSM control_fsm (
    .clk(clk), .reset_n(reset_n), .flick(flick), .counter_val(counter_val),
    .enable(enable), .upcount(upcount)
);

always @(counter_val) begin
    case (counter_val)
        4'd0:
            light = 0;
        4'd1:
            light = {1{1'd1}};
        4'd2:
            light = {2{1'd1}};
        4'd3:
            light = {3{1'd1}};
        4'd4:
            light = {4{1'd1}};
        4'd5:
            light = {5{1'd1}};
        4'd6:
            light = {6{1'd1}};
        4'd7:
            light = {7{1'd1}};
        4'd8:
            light = {8{1'd1}};
        4'd9:
            light = {9{1'd1}};
        4'd10:
            light = {10{1'd1}};
        4'd11:
            light = {11{1'd1}};
        4'd12:
            light = {12{1'd1}};
        4'd13:
            light = {13{1'd1}};
        4'd14:
            light = {14{1'd1}};
        4'd15:
            light = {15{1'd1}};
        default:
            light = 0;
    endcase
end

endmodule
