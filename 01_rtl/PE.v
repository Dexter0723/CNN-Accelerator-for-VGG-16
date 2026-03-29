module PE(
           data_out_8,data_out_7,data_out_6,data_out_5,data_out_4,data_out_3,data_out_2,data_out_1,data_out_0,
           kernel_8,kernel_7,kernel_6,kernel_5,kernel_4,kernel_3,kernel_2,kernel_1,kernel_0,
           result_8,result_7,result_6,result_5,result_4,result_3,result_2,result_1,result_0
       );

input signed [8:0] data_out_8,data_out_7,data_out_6,data_out_5,data_out_4,data_out_3,data_out_2,data_out_1,data_out_0;
input signed [15:0] kernel_8,kernel_7,kernel_6,kernel_5,kernel_4,kernel_3,kernel_2,kernel_1,kernel_0;
output signed [24:0] result_8,result_7,result_6,result_5,result_4,result_3,result_2,result_1,result_0;

assign result_0 = data_out_0 * kernel_0;
assign result_1 = data_out_1 * kernel_1;
assign result_2 = data_out_2 * kernel_2;
assign result_3 = data_out_3 * kernel_3;
assign result_4 = data_out_4 * kernel_4;
assign result_5 = data_out_5 * kernel_5;
assign result_6 = data_out_6 * kernel_6;
assign result_7 = data_out_7 * kernel_7;
assign result_8 = data_out_8 * kernel_8;

endmodule
