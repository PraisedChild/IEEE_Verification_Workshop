module V_CORDIC_Unit (
    input signed [31:0]      i_data_1, 
    input signed [31:0]      i_data_2,
    input                    en,
    input                    rst,
    input                    clk,
    output signed [31:0]     o_data_1,
    output signed [31:0]     o_data_2,
    output signed [31:0]     angle,
    output                   done_flag
);
    
    wire [31:0] LUT;
    wire [3:0]  sel;    

    V_CORDIC veccor (
        .i_data_1(i_data_1),
        .i_data_2(i_data_2),
        .en(en),
        .rst(rst),
        .clk(clk),
        .LUT(LUT),
        .o_data_1(o_data_1),
        .o_data_2(o_data_2),
        .angle(angle),
        .done_flag(done_flag),
        .sel(sel)
    );

    LUT lut (
        .sel(sel),
        .en(en),
        .clk(clk),
        .rst(rst),
        .value(LUT)
    );

endmodule