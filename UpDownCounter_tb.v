module UpDownCounter_tb;
    reg clk;
    reg reset_n;
    reg upcount;
    reg enable;
    wire [4:0] out;
    
    // instantiate UUT
    UpDownCounter UUT (
        .clk(clk),
        .reset_n(reset_n),
        .upcount(upcount),
        .enable(enable),
        .out(out)
    );

    // create clock
    always #1 clk = !clk;

    initial begin
        clk <= 0;
        reset_n <= 0;
        enable <= 0;
        upcount <= 1;
        #4;

        reset_n <= 1;
        enable <= 1;
        #10;
        enable <= 0;
        #4;
        enable <= 1;
        #40;
        upcount <= 0;
        #40;
        reset_n <= 0;
        #2;
        reset_n <= 1;
        #10 $finish;
    end

    initial begin
        $display("  T\tclk\treset_n\tupcount\tenable\tout");
        $monitor("%3d\t%h\t%h\t%h\t%h\t%h", $time, clk, reset_n, upcount, enable, out);
    end

endmodule
