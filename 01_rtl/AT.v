module AT(result_8,result_7,result_6,result_5,result_4,result_3,result_2,result_1,result_0,AT_sum);
input signed [24:0] result_8,result_7,result_6,result_5,result_4,result_3,result_2,result_1,result_0;
output signed [28:0] AT_sum;

assign AT_sum = (result_0 + result_1) + (result_2 + result_3) + (result_4 + result_5) + (result_6 + result_7) + result_8;

endmodule
