`timescale 1ns/1ps

module tb_fft4;

reg clk;
reg rst;
reg [7:0] adc_in;

// Store outputs
wire [7:0] x0, x1, x2, x3;
wire data_ready;

// FFT outputs
wire signed [8:0] Fr0, Fi0, Fr1, Fi1, Fr2, Fi2, Fr3, Fi3;

// Clock
always #5 clk = ~clk;

// Instantiate adc_store
adc_store store (
    .clk(clk),
    .rst(rst),
    .adc_in(adc_in),
    .p_out1r(x0),
    .p_out2r(x1),
    .p_out3r(x2),
    .p_out4r(x3),
    .p_out1i(),
    .p_out2i(),
    .p_out3i(),
    .p_out4i(),
    .data_ready(data_ready)
);

// Instantiate FFT
FFT4_Butterfly fft (
    .clk(clk),
    .reset(rst),
    .enable(data_ready),

    .xr0(x0), .xi0(0),
    .xr1(x1), .xi1(0),
    .xr2(x2), .xi2(0),
    .xr3(x3), .xi3(0),

    .Fr0(Fr0), .Fi0(Fi0),
    .Fr1(Fr1), .Fi1(Fi1),
    .Fr2(Fr2), .Fi2(Fi2),
    .Fr3(Fr3), .Fi3(Fi3)
);

initial begin
    clk = 0;
    rst = 1;

    #10 rst = 0;

    // Input samples
    adc_in = 10; #10;
    adc_in = 10; #10;
    adc_in = 10; #10;
    adc_in = 10; #10;

    #100;

    $display("F0 = %d", Fr0);
    $display("F1 = %d + j%d", Fr1, Fi1);
    $display("F2 = %d", Fr2);
    $display("F3 = %d + j%d", Fr3, Fi3);

    #50 $finish;
end

endmodule