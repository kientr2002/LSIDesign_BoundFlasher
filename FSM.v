module FSM
(
    input clk, reset_n,
    input flick,
    input [4:0] counter_val,
    output reg enable, upcount
);

localparam [3:0] STATE_START = 4'd0;
localparam [3:0] STATE_UP_1_5 = 4'd1;
localparam [3:0] STATE_DOWN_4_0 = 4'd2;
localparam [3:0] STATE_UP_1_10 = 4'd3;
localparam [3:0] STATE_DOWN_9_5 = 4'd4;
localparam [3:0] STATE_UP_6_16 = 4'd5;
localparam [3:0] STATE_DOWN_15_1 = 4'd6;
localparam [3:0] STATE_3_RESET_9_0 = 4'd7;
localparam [3:0] STATE_3_RESET_4_0 = 4'd8;
localparam [3:0] STATE_5_RESET_9_5 = 4'd9;
localparam [3:0] STATE_5_RESET_5_5 = 4'd10;

reg [3:0] current_state, next_state;

// change state on clock edge
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        current_state <= STATE_START;
    end
    else begin
        current_state <= next_state;
    end
end

// next state determination
always @(*) begin
    next_state = current_state;

    case (current_state)
        STATE_START:
            if (flick)
                next_state = STATE_UP_1_5;
        STATE_UP_1_5:
            if (counter_val == 5'd5)
                next_state = STATE_DOWN_4_0;
        STATE_DOWN_4_0:
            if (counter_val == 5'd0)
                next_state = STATE_UP_1_10;
        STATE_UP_1_10:
        begin
            if (flick) begin
                if (counter_val == 5'd5)
                    next_state = STATE_3_RESET_4_0;
                else if (counter_val == 5'd10)
                    next_state = STATE_3_RESET_9_0;
            end
            else if (counter_val == 5'd10)
                next_state = STATE_DOWN_9_5;
        end
        STATE_3_RESET_4_0:
            if (counter_val == 5'd0)
                next_state = STATE_UP_1_10;
        STATE_3_RESET_9_0:
            if (counter_val == 5'd0)
                next_state = STATE_UP_1_10;
        STATE_DOWN_9_5:
        begin
            if (counter_val == 5'd5) begin
                if (flick)
                    next_state = STATE_5_RESET_5_5;
                else
                    next_state = STATE_UP_6_16;
            end
        end
        STATE_UP_6_16:
        begin
            if (flick) begin
                if (counter_val == 5'd10)
                    next_state = STATE_5_RESET_9_5;
            end
            else if (counter_val == 5'd16)
                next_state = STATE_DOWN_15_1;
        end
        STATE_5_RESET_9_5:
        begin
            if (counter_val == 5'd5) begin
                if (flick)
                    next_state = STATE_5_RESET_5_5;
                else
                    next_state = STATE_UP_6_16;
            end
        end
        STATE_5_RESET_5_5:
        begin
            if (!flick)
                next_state = STATE_UP_6_16;
        end
        STATE_DOWN_15_1:
            if (counter_val == 5'd1)
                next_state = STATE_START;

        default:
            next_state = STATE_START;
    endcase
end

// output for each state
always @(*) begin
    enable = 1'b0;
    upcount = 1'b0;

    case (next_state)
        STATE_START:
        begin
            if (current_state == STATE_START)
                enable = 1'b0;
            else enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_UP_1_5:
        begin
            enable = 1'b1;
            upcount = 1'b1;
        end
        STATE_DOWN_4_0:
        begin
            enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_UP_1_10:
        begin
            enable = 1'b1;
            upcount = 1'b1;
        end
        STATE_DOWN_9_5:
        begin
            enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_UP_6_16:
        begin
            enable = 1'b1;
            upcount = 1'b1;
        end
        STATE_DOWN_15_1:
        begin
            enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_3_RESET_9_0:
        begin
            enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_3_RESET_4_0:
        begin
            enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_5_RESET_9_5:
        begin
            enable = 1'b1;
            upcount = 1'b0;
        end
        STATE_5_RESET_5_5:
        begin
            enable = 1'b0;
            upcount = 1'b0;
        end
        default:
        begin
            enable = 1'b0;
            upcount = 1'b0;
        end
    endcase
end


endmodule
