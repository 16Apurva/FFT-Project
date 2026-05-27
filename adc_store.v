module adc_store(
    input wire clk,
    input wire rst,
    input wire [7:0] adc_in,

    output reg [7:0] p_out1r,
    output reg [7:0] p_out2r,
    output reg [7:0] p_out3r,
    output reg [7:0] p_out4r,

    output reg [7:0] p_out1i,
    output reg [7:0] p_out2i,
    output reg [7:0] p_out3i,
    output reg [7:0] p_out4i,

    output reg data_ready
);

reg [1:0] count_samples;

always @(posedge clk) begin
    if (rst) begin
        p_out1r <= 0; p_out2r <= 0;
        p_out3r <= 0; p_out4r <= 0;
        p_out1i <= 0; p_out2i <= 0;
        p_out3i <= 0; p_out4i <= 0;
        count_samples <= 0;
        data_ready <= 0;
    end else begin
        case (count_samples)
            2'd0: p_out1r <= adc_in;
            2'd1: p_out2r <= adc_in;
            2'd2: p_out3r <= adc_in;
            2'd3: p_out4r <= adc_in;
        endcase

        count_samples <= count_samples + 1;

        p_out1i <= 0;
        p_out2i <= 0;
        p_out3i <= 0;
        p_out4i <= 0;

        if (count_samples == 2'd3)
            data_ready <= 1;
        else
            data_ready <= 0;
    end
end

endmodule