module R_CORDIC (
    input signed [31:0]      i_data_1, 
    input signed [31:0]      i_data_2,
    input signed [31:0]      angle,
    input                    en,
    input                    rst,
    input                    clk,
    input signed [31:0]      LUT,
    output reg signed [31:0] o_data_1,
    output reg signed [31:0] o_data_2,
    output reg               done_flag,
    output [3:0]             sel
);
    localparam signed COS_ANG = 32'b00000000100110110111010011101111; ///0.6076197726 (total cosines) 00000000100110110111010011101111

    reg [3:0] counter;
    reg signed [31:0] buff_data_1;
    reg signed [31:0] buff_data_2;
    reg signed [31:0] buff_angle;

    wire signed [63:0] product1,product2;
    reg ON;

    always@(posedge clk or posedge rst)begin
        if(rst)begin
            buff_data_1 <=32'h0;
            buff_data_2 <=32'h0;
            done_flag   <= 0;
            buff_angle  <= 32'h0;
            o_data_1    <= 32'h0;
            o_data_2    <= 32'h0;
            counter     <= 0;
            ON          <=0;
        end
        else begin
            if(ON)begin
                if(counter == 15)begin
                    o_data_1 <= product1[31:0];
                    o_data_2 <= product2[31:0];
                    counter  <= 0;
                    done_flag <= 1;
                    buff_angle <=0;
                    ON <= 0;
                end
                else begin
                    if(counter == 0)begin
                        if(angle[31])begin
                            buff_data_1 <= i_data_1 - (i_data_2>>>(counter));
                            buff_data_2 <= i_data_2 + (i_data_1>>>(counter));
                            buff_angle  <= angle + LUT; 
                        end
                        else begin
                            buff_data_1 <= i_data_1 + (i_data_2>>>(counter));
                            buff_data_2 <= i_data_2 - (i_data_1>>>(counter));
                            buff_angle  <= angle - LUT;    
                        end
                    end
                    else begin
                        if(buff_angle[31])begin
                            buff_data_1 <= buff_data_1 - (buff_data_2>>>(counter));
                            buff_data_2 <= buff_data_2 + (buff_data_1>>>(counter));
                            buff_angle  <= buff_angle + LUT;
                        end
                        else begin
                            buff_data_1 <= buff_data_1 + (buff_data_2>>>(counter));
                            buff_data_2 <= buff_data_2 - (buff_data_1>>>(counter));
                            buff_angle  <= buff_angle - LUT;
                        end
                    end
                    counter <= counter + 1;
                end
            end
            if(en)begin
                ON <= 1;
                buff_angle <= angle;
            end
            if(done_flag)begin
                done_flag<=0;
                buff_angle<=0;
                buff_data_1<=0;
                buff_data_2<=0;
            end
        end
    end



    assign sel = counter;
    assign product1 = (COS_ANG*buff_data_1)>>>24;
    assign product2 = (COS_ANG*buff_data_2)>>>24;

endmodule