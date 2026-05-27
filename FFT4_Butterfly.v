module FFT4_Butterfly (
    input wire clk,
    input wire reset,
    input wire enable,

    input wire signed [7:0] xr0, xi0,
    input wire signed [7:0] xr1, xi1,
    input wire signed [7:0] xr2, xi2,
    input wire signed [7:0] xr3, xi3,

//final freq output 
    output reg signed [8:0] Fr0, Fi0,
    output reg signed [8:0] Fr1, Fi1,
    output reg signed [8:0] Fr2, Fi2,
    output reg signed [8:0] Fr3, Fi3
);

reg signed [8:0] Ar, Ai, Br, Bi, Cr, Ci, Dr, Di;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Fr0 <= 0; Fi0 <= 0;
        Fr1 <= 0; Fi1 <= 0;
        Fr2 <= 0; Fi2 <= 0;
        Fr3 <= 0; Fi3 <= 0;
    end 
    else if (enable) begin
        // Stage 1 butterfly 
        Ar <= xr0 + xr2;
        Ai <= xi0 + xi2;

        Br <= xr0 - xr2;
        Bi <= xi0 - xi2;

        Cr <= xr1 + xr3;
        Ci <= xi1 + xi3;

        Dr <= xr1 - xr3;
        Di <= xi1 - xi3;

        // Stage 2 butterfly final output(frequency bins)
        Fr0 <= Ar + Cr;
        Fi0 <= Ai + Ci;

        Fr1 <= Br + Di;
        Fi1 <= Bi - Dr;

        Fr2 <= Ar - Cr;
        Fi2 <= Ai - Ci;

        Fr3 <= Br - Di;
        Fi3 <= Bi + Dr;
    end
end

endmodule