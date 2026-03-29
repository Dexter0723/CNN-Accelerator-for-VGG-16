//CA convolution accumulator
module bias(
           CA_sum_0,CA_sum_1,CA_sum_2,CA_sum_3,
           CA_sum_4,CA_sum_5,CA_sum_6,CA_sum_7,
           CA_sum_8,CA_sum_9,CA_sum_10,CA_sum_11,
           CA_sum_12,CA_sum_13,CA_sum_14,CA_sum_15,
           bias,bias_out_result
       );

input signed [35:0] CA_sum_0,CA_sum_1,CA_sum_2,CA_sum_3,CA_sum_4,CA_sum_5,CA_sum_6,CA_sum_7,CA_sum_8,CA_sum_9,CA_sum_10,CA_sum_11,CA_sum_12,CA_sum_13,CA_sum_14,CA_sum_15; //channel
input signed [15:0] bias;
output signed [35:0] bias_out_result;

assign bias_out_result = CA_sum_0 + CA_sum_1 + CA_sum_2 + CA_sum_3
       + CA_sum_4 + CA_sum_5 + CA_sum_6 + CA_sum_7
       + CA_sum_8 + CA_sum_9 + CA_sum_10 + CA_sum_11
       + CA_sum_12 + CA_sum_13 + CA_sum_14 + CA_sum_15
       + bias;

endmodule
