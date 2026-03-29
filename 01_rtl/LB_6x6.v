`define width 8
`define length 8
module Line_Buffer(clk,reset,data_in,data_out_8,data_out_7,data_out_6,data_out_5,data_out_4,data_out_3,data_out_2,data_out_1,data_out_0,invaild_flag);
input clk,reset;
input signed [8:0] data_in;
output signed [8:0] data_out_8,data_out_7,data_out_6,data_out_5,data_out_4,data_out_3,data_out_2,data_out_1,data_out_0;
output invaild_flag;

reg signed [8:0] LB0 [0:`width-1];
reg signed [8:0] LB1 [0:`width-1];
reg signed [8:0] LB2 [1:0];
wire signed [8:0] last_value;

wire fill_flag,edge_flag;
reg [20:0]counter;
reg [8:0]edge_counter;
reg [15:0]pixel;
integer i;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        for(i = 0;i < `width;i = i + 1) begin
            LB0[i] <= 9'b0;
            LB1[i] <= 9'b0;
        end
        for(i = 0;i <= 1;i = i + 1) begin
            LB2[i] <= 9'b0;
        end
        counter <= 9'b0;
        edge_counter <= 9'b0;
        pixel <= 16'd0;
    end
    else begin
        counter <= counter + 1'b1;
        edge_counter <= (((edge_counter < `width - 1)) ? edge_counter + 1'b1 : 9'd0);
        pixel <= invaild_flag ? pixel : pixel + 1'b1;
        for(i = `width - 2;i >= 0;i = i - 1) begin
            LB0[i] <= LB0[i + 1];       //LB0 0 <- 1 <- 2 <- ... <- 223 、 224 <- 225
            LB1[i] <= LB1[i + 1];       //LB1 0 <- 1 <- 2 <- ... <- 223 、 224 <- 225
        end
        LB0[`width - 1] <= LB1[0];      //LB0[225] <- LB1[0]
        LB1[`width - 1] <= LB2[0];      //LB1[225] <- LB2[0]
        LB2[0] <= LB2[1];
        LB2[1] <= last_value;
    end
end

assign fill_flag = (counter >= (2 * `width + 2));
assign edge_flag = (edge_counter == 9'd0) || (edge_counter == `width - 1);
assign invaild_flag = !fill_flag || edge_flag;

assign last_value = data_in;
assign data_out_0 = LB0[0];    //r0 r1 r2
assign data_out_1 = LB0[1];
assign data_out_2 = LB0[2];
assign data_out_3 = LB1[0];    //r3 r4 r5
assign data_out_4 = LB1[1];
assign data_out_5 = LB1[2];
assign data_out_6 = LB2[0];    //r6 r7 r8
assign data_out_7 = LB2[1];
assign data_out_8 = data_in;

endmodule



