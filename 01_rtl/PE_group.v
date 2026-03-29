module PE_group(
           data_out_0_8,data_out_0_7,data_out_0_6,data_out_0_5,data_out_0_4,data_out_0_3,data_out_0_2,data_out_0_1,data_out_0_0,
           data_out_1_8,data_out_1_7,data_out_1_6,data_out_1_5,data_out_1_4,data_out_1_3,data_out_1_2,data_out_1_1,data_out_1_0,
           data_out_2_8,data_out_2_7,data_out_2_6,data_out_2_5,data_out_2_4,data_out_2_3,data_out_2_2,data_out_2_1,data_out_2_0,
           data_out_3_8,data_out_3_7,data_out_3_6,data_out_3_5,data_out_3_4,data_out_3_3,data_out_3_2,data_out_3_1,data_out_3_0,

           kernel_0_8,kernel_0_7,kernel_0_6,kernel_0_5,kernel_0_4,kernel_0_3,kernel_0_2,kernel_0_1,kernel_0_0,
           kernel_1_8,kernel_1_7,kernel_1_6,kernel_1_5,kernel_1_4,kernel_1_3,kernel_1_2,kernel_1_1,kernel_1_0,
           kernel_2_8,kernel_2_7,kernel_2_6,kernel_2_5,kernel_2_4,kernel_2_3,kernel_2_2,kernel_2_1,kernel_2_0,
           kernel_3_8,kernel_3_7,kernel_3_6,kernel_3_5,kernel_3_4,kernel_3_3,kernel_3_2,kernel_3_1,kernel_3_0,

           AT_sum
       );

input signed [8:0] data_out_0_8,data_out_0_7,data_out_0_6,data_out_0_5,data_out_0_4,data_out_0_3,data_out_0_2,data_out_0_1,data_out_0_0;
input signed [8:0] data_out_1_8,data_out_1_7,data_out_1_6,data_out_1_5,data_out_1_4,data_out_1_3,data_out_1_2,data_out_1_1,data_out_1_0;
input signed [8:0] data_out_2_8,data_out_2_7,data_out_2_6,data_out_2_5,data_out_2_4,data_out_2_3,data_out_2_2,data_out_2_1,data_out_2_0;
input signed [8:0] data_out_3_8,data_out_3_7,data_out_3_6,data_out_3_5,data_out_3_4,data_out_3_3,data_out_3_2,data_out_3_1,data_out_3_0;

input signed [15:0] kernel_0_8,kernel_0_7,kernel_0_6,kernel_0_5,kernel_0_4,kernel_0_3,kernel_0_2,kernel_0_1,kernel_0_0;
input signed [15:0] kernel_1_8,kernel_1_7,kernel_1_6,kernel_1_5,kernel_1_4,kernel_1_3,kernel_1_2,kernel_1_1,kernel_1_0;
input signed [15:0] kernel_2_8,kernel_2_7,kernel_2_6,kernel_2_5,kernel_2_4,kernel_2_3,kernel_2_2,kernel_2_1,kernel_2_0;
input signed [15:0] kernel_3_8,kernel_3_7,kernel_3_6,kernel_3_5,kernel_3_4,kernel_3_3,kernel_3_2,kernel_3_1,kernel_3_0;
output signed [35:0] AT_sum;

wire signed [24:0] result_0_8,result_0_7,result_0_6,result_0_5,result_0_4,result_0_3,result_0_2,result_0_1,result_0_0;
wire signed [24:0] result_1_8,result_1_7,result_1_6,result_1_5,result_1_4,result_1_3,result_1_2,result_1_1,result_1_0;
wire signed [24:0] result_2_8,result_2_7,result_2_6,result_2_5,result_2_4,result_2_3,result_2_2,result_2_1,result_2_0;
wire signed [24:0] result_3_8,result_3_7,result_3_6,result_3_5,result_3_4,result_3_3,result_3_2,result_3_1,result_3_0;

wire signed [28:0] AT_sum_0,AT_sum_1,AT_sum_2,AT_sum_3;

PE PE_inst_0(
       .data_out_8(data_out_0_8),
       .data_out_7(data_out_0_7),
       .data_out_6(data_out_0_6),
       .data_out_5(data_out_0_5),
       .data_out_4(data_out_0_4),
       .data_out_3(data_out_0_3),
       .data_out_2(data_out_0_2),
       .data_out_1(data_out_0_1),
       .data_out_0(data_out_0_0),

       .kernel_8(kernel_0_8),
       .kernel_7(kernel_0_7),
       .kernel_6(kernel_0_6),
       .kernel_5(kernel_0_5),
       .kernel_4(kernel_0_4),
       .kernel_3(kernel_0_3),
       .kernel_2(kernel_0_2),
       .kernel_1(kernel_0_1),
       .kernel_0(kernel_0_0),

       .result_8(result_0_8),
       .result_7(result_0_7),
       .result_6(result_0_6),
       .result_5(result_0_5),
       .result_4(result_0_4),
       .result_3(result_0_3),
       .result_2(result_0_2),
       .result_1(result_0_1),
       .result_0(result_0_0)
   );

AT AT_inst_0(
       .result_8(result_0_8),
       .result_7(result_0_7),
       .result_6(result_0_6),
       .result_5(result_0_5),
       .result_4(result_0_4),
       .result_3(result_0_3),
       .result_2(result_0_2),
       .result_1(result_0_1),
       .result_0(result_0_0),
       .AT_sum(AT_sum_0)
   );

PE PE_inst_1(
       .data_out_8(data_out_1_8),
       .data_out_7(data_out_1_7),
       .data_out_6(data_out_1_6),
       .data_out_5(data_out_1_5),
       .data_out_4(data_out_1_4),
       .data_out_3(data_out_1_3),
       .data_out_2(data_out_1_2),
       .data_out_1(data_out_1_1),
       .data_out_0(data_out_1_0),

       .kernel_8(kernel_1_8),
       .kernel_7(kernel_1_7),
       .kernel_6(kernel_1_6),
       .kernel_5(kernel_1_5),
       .kernel_4(kernel_1_4),
       .kernel_3(kernel_1_3),
       .kernel_2(kernel_1_2),
       .kernel_1(kernel_1_1),
       .kernel_0(kernel_1_0),

       .result_8(result_1_8),
       .result_7(result_1_7),
       .result_6(result_1_6),
       .result_5(result_1_5),
       .result_4(result_1_4),
       .result_3(result_1_3),
       .result_2(result_1_2),
       .result_1(result_1_1),
       .result_0(result_1_0)
   );

AT AT_inst_1(
       .result_8(result_1_8),
       .result_7(result_1_7),
       .result_6(result_1_6),
       .result_5(result_1_5),
       .result_4(result_1_4),
       .result_3(result_1_3),
       .result_2(result_1_2),
       .result_1(result_1_1),
       .result_0(result_1_0),
       .AT_sum(AT_sum_1)
   );

PE PE_inst_2(
       .data_out_8(data_out_2_8),
       .data_out_7(data_out_2_7),
       .data_out_6(data_out_2_6),
       .data_out_5(data_out_2_5),
       .data_out_4(data_out_2_4),
       .data_out_3(data_out_2_3),
       .data_out_2(data_out_2_2),
       .data_out_1(data_out_2_1),
       .data_out_0(data_out_2_0),

       .kernel_8(kernel_2_8),
       .kernel_7(kernel_2_7),
       .kernel_6(kernel_2_6),
       .kernel_5(kernel_2_5),
       .kernel_4(kernel_2_4),
       .kernel_3(kernel_2_3),
       .kernel_2(kernel_2_2),
       .kernel_1(kernel_2_1),
       .kernel_0(kernel_2_0),

       .result_8(result_2_8),
       .result_7(result_2_7),
       .result_6(result_2_6),
       .result_5(result_2_5),
       .result_4(result_2_4),
       .result_3(result_2_3),
       .result_2(result_2_2),
       .result_1(result_2_1),
       .result_0(result_2_0)

   );

AT AT_inst_2(
       .result_8(result_2_8),
       .result_7(result_2_7),
       .result_6(result_2_6),
       .result_5(result_2_5),
       .result_4(result_2_4),
       .result_3(result_2_3),
       .result_2(result_2_2),
       .result_1(result_2_1),
       .result_0(result_2_0),
       .AT_sum(AT_sum_2)
   );

PE PE_inst_3(
       .data_out_8(data_out_3_8),
       .data_out_7(data_out_3_7),
       .data_out_6(data_out_3_6),
       .data_out_5(data_out_3_5),
       .data_out_4(data_out_3_4),
       .data_out_3(data_out_3_3),
       .data_out_2(data_out_3_2),
       .data_out_1(data_out_3_1),
       .data_out_0(data_out_3_0),

       .kernel_8(kernel_3_8),
       .kernel_7(kernel_3_7),
       .kernel_6(kernel_3_6),
       .kernel_5(kernel_3_5),
       .kernel_4(kernel_3_4),
       .kernel_3(kernel_3_3),
       .kernel_2(kernel_3_2),
       .kernel_1(kernel_3_1),
       .kernel_0(kernel_3_0),

       .result_8(result_3_8),
       .result_7(result_3_7),
       .result_6(result_3_6),
       .result_5(result_3_5),
       .result_4(result_3_4),
       .result_3(result_3_3),
       .result_2(result_3_2),
       .result_1(result_3_1),
       .result_0(result_3_0)

   );

AT AT_inst_3(
       .result_8(result_3_8),
       .result_7(result_3_7),
       .result_6(result_3_6),
       .result_5(result_3_5),
       .result_4(result_3_4),
       .result_3(result_3_3),
       .result_2(result_3_2),
       .result_1(result_3_1),
       .result_0(result_3_0),
       .AT_sum(AT_sum_3)
   );

assign AT_sum = AT_sum_0 + AT_sum_1 + AT_sum_2 + AT_sum_3;

endmodule
