module UpDownCounter
(
    input clk, reset_n, upcount, enable,
    output reg [5:0] out
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            out <= 0;
        else if (enable) begin
            if (upcount)
                out <= out + 1;
            else
                out <= out - 1;
        end
    end

endmodule
