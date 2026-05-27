module fft_top(

    input wire clk,
    input wire rst,
    input wire [7:0] adc_in,

    output wire serial_out

);

wire [7:0] x0, x1, x2, x3;
wire data_ready;

wire signed [8:0] Fr0, Fi0;
wire signed [8:0] Fr1, Fi1;
wire signed [8:0] Fr2, Fi2;
wire signed [8:0] Fr3, Fi3;


adc_store STORE (

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

FFT4_Butterfly FFT (

    .clk(clk),
    .reset(rst),
    .enable(data_ready),

    .xr0(x0), .xi0(8'd0),
    .xr1(x1), .xi1(8'd0),
    .xr2(x2), .xi2(8'd0),
    .xr3(x3), .xi3(8'd0),

    .Fr0(Fr0), .Fi0(Fi0),
    .Fr1(Fr1), .Fi1(Fi1),
    .Fr2(Fr2), .Fi2(Fi2),
    .Fr3(Fr3), .Fi3(Fi3)

);

parallel_to_serial SERIAL (

    .clk(clk),
    .rst(rst),
    .enable(data_ready),

    .p_in1(Fr0),
    .p_in2(Fi0),
    .p_in3(Fr1),
    .p_in4(Fi1),
    .p_in5(Fr2),
    .p_in6(Fi2),
    .p_in7(Fr3),
    .p_in8(Fi3),

    .serial_out(serial_out)

);

endmodule
