module Frequency_Scaling(
    input clk_50M,
    output reg adc_clk_out
);

reg [2:0] counter;

always @(posedge clk_50M) begin
    if (counter == 7) begin
        adc_clk_out <= ~adc_clk_out;
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end
end

endmodule