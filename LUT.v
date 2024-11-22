module LUT (
    input [3:0]       sel,
    input             en,
    input             clk,
    input             rst,
    output reg [31:0] value
);
    reg [31:0] mem1 [14:0];
    reg ON;

    always@(posedge clk or posedge rst)begin
        if(rst)begin
            mem1[0]<=32'b00101101000000000000000000000000;
            mem1[1]<=32'b00011010100100001111000011110101;
            mem1[2]<=32'b00001110000010010010011010100101;
            mem1[3]<=32'b00000111001000000010001111010000;
            mem1[4]<=32'b00000011100100110111101010111111;
            mem1[5]<=32'b00000001110010010101110010101101;
            mem1[6]<=32'b00000000111001001001001011100101;
            mem1[7]<=32'b00000000011100100010110100010110;
            mem1[8]<=32'b00000000001110010001110100111111;
            mem1[9]<=32'b00000000000111001100001111011101;
            mem1[10]<=32'b00000000000011100010010010000111;
            mem1[11]<=32'b00000000000001110010001010010000;
            mem1[12]<=32'b00000000000000111001000101111100;
            mem1[13]<=32'b00000000000000011110011001101110;
            mem1[14]<=32'b00000000000000001110010101010111;     
        end
    end

    always@(posedge clk or posedge rst)begin
        if(rst)begin
            ON <= 0;
        end
        else begin
            if(en)begin
                ON <= 1;
            end
        end
    end
    always@(*)begin
        if(ON)begin
            value = mem1[sel];
        end
        else 
            value = 0;
    end
    
endmodule