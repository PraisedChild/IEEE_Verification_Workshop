module R_CORDIC_Unit (
    input signed [31:0]      i_data_1, 
    input signed [31:0]      i_data_2,
    input signed [31:0]      angle,
    input                    en,
    input                    rst,
    input                    clk,
    output signed [31:0]     o_data_1,
    output signed [31:0]     o_data_2,
    output                   done_flag
);
    
    wire [31:0] LUT1;
    wire [3:0]  sel;    

    R_CORDIC rotcor (
        .i_data_1(i_data_1),
        .i_data_2(i_data_2),
        .angle(angle),
        .en(en),
        .rst(rst),
        .clk(clk),
        .LUT(LUT1),
        .o_data_1(o_data_1),
        .o_data_2(o_data_2),
        .done_flag(done_flag),
        .sel(sel)
    );

    LUT lut (
        .sel(sel),
        .en(en),
        .clk(clk),
        .rst(rst),
        .value(LUT1)
    );

endmodule