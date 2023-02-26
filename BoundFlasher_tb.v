module BoundFlasher_tb;
    reg clk;
    reg reset_n;
    reg flick;
    wire [15:0] light;
    
    BoundFlasher UUT
    (
        .clk(clk), .reset_n(reset_n), .flick(flick),
        .light(light)
    );

    // create clock
    always #1 clk = !clk;

    initial begin
        clk <= 0;
        reset_n <= 0;
        flick <= 0;
        #4;

        reset_n <= 1;
        flick <= 1;
        #2;
        flick <= 0;
        #106;

        UUT.counter.out = 4;
        UUT.control_fsm.current_state = UUT.control_fsm.STATE_UP_1_10;
        flick = 1;
        #4;
        flick = 0;
        #24;
        flick = 1;
        #10;
        flick = 0;
        #20;

        UUT.counter.out = 6;
        UUT.control_fsm.current_state = UUT.control_fsm.STATE_DOWN_9_5;
        flick = 1;
        #10;
        flick = 0;
        #5;
        flick = 1;
        #20;
        flick = 0;
        #20;

        $finish;
    end

    initial begin
        $display("  T\tclk\treset_n\tflick\tlight");
        $monitor("%3d\t%h\t%h\t%h\t%b\t%d,%d", 
            $time, clk, reset_n, flick, light, 
            UUT.control_fsm.current_state, UUT.control_fsm.counter_val);
    end

endmodule
