`timescale 1ns / 1ps

module fir_filter_tb;

    reg clk;
    reg reset;
    reg signed [7:0] x_in;
    wire signed [15:0] y_out;

    // Instantiate FIR Filter
    fir_filter #(4) uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generator: 10ns period
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, fir_filter_tb);

        clk = 0;
        reset = 1;
        x_in = 0;

        #10 reset = 0;

        // Input samples
        #10 x_in = 8'd10;
        #10 x_in = 8'd20;
        #10 x_in = 8'd30;
        #10 x_in = 8'd40;
        #10 x_in = 8'd50;
        #10 x_in = 8'd0;
        #10 x_in = 8'd0;

        #100;
        $finish;
    end

    // Monitor input and output
    always @(posedge clk) begin
        $display("Time: %t | x_in = %d | y_out = %d", $time, x_in, y_out);
    end

endmodule
