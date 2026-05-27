module parallel_to_serial (
    input wire clk,
    input wire rst,
    input wire enable,

    input wire signed [8:0] p_in1, p_in2, p_in3, p_in4,
    input wire signed [8:0] p_in5, p_in6, p_in7, p_in8,

    output reg serial_out
);

    reg [71:0] shift_register;
    reg [6:0] bit_count;

always @(posedge clk) begin
    if (rst) begin
        shift_register <= 0;
        bit_count <= 0;
        serial_out <= 0;
    end else if (enable) begin

        if (bit_count == 0)
            shift_register <= {p_in8, p_in7, p_in6, p_in5,
                               p_in4, p_in3, p_in2, p_in1};

        serial_out <= shift_register[71];
        shift_register <= {shift_register[70:0], 1'b0};  

        if (bit_count == 71)
            bit_count <= 0;
        else
            bit_count <= bit_count + 1;
    end
end

endmodule
