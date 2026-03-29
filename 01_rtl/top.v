module top(
           clk,reset,
           data_in_0,data_in_1,data_in_2,data_in_3,

           //PE_group 0
           kernel_0_0_8,kernel_0_0_7,kernel_0_0_6,kernel_0_0_5,kernel_0_0_4,kernel_0_0_3,kernel_0_0_2,kernel_0_0_1,kernel_0_0_0,
           kernel_0_1_8,kernel_0_1_7,kernel_0_1_6,kernel_0_1_5,kernel_0_1_4,kernel_0_1_3,kernel_0_1_2,kernel_0_1_1,kernel_0_1_0,
           kernel_0_2_8,kernel_0_2_7,kernel_0_2_6,kernel_0_2_5,kernel_0_2_4,kernel_0_2_3,kernel_0_2_2,kernel_0_2_1,kernel_0_2_0,
           kernel_0_3_8,kernel_0_3_7,kernel_0_3_6,kernel_0_3_5,kernel_0_3_4,kernel_0_3_3,kernel_0_3_2,kernel_0_3_1,kernel_0_3_0,

           //PE_group 1
           kernel_1_0_8,kernel_1_0_7,kernel_1_0_6,kernel_1_0_5,kernel_1_0_4,kernel_1_0_3,kernel_1_0_2,kernel_1_0_1,kernel_1_0_0,
           kernel_1_1_8,kernel_1_1_7,kernel_1_1_6,kernel_1_1_5,kernel_1_1_4,kernel_1_1_3,kernel_1_1_2,kernel_1_1_1,kernel_1_1_0,
           kernel_1_2_8,kernel_1_2_7,kernel_1_2_6,kernel_1_2_5,kernel_1_2_4,kernel_1_2_3,kernel_1_2_2,kernel_1_2_1,kernel_1_2_0,
           kernel_1_3_8,kernel_1_3_7,kernel_1_3_6,kernel_1_3_5,kernel_1_3_4,kernel_1_3_3,kernel_1_3_2,kernel_1_3_1,kernel_1_3_0,

           //PE_group 2
           kernel_2_0_8,kernel_2_0_7,kernel_2_0_6,kernel_2_0_5,kernel_2_0_4,kernel_2_0_3,kernel_2_0_2,kernel_2_0_1,kernel_2_0_0,
           kernel_2_1_8,kernel_2_1_7,kernel_2_1_6,kernel_2_1_5,kernel_2_1_4,kernel_2_1_3,kernel_2_1_2,kernel_2_1_1,kernel_2_1_0,
           kernel_2_2_8,kernel_2_2_7,kernel_2_2_6,kernel_2_2_5,kernel_2_2_4,kernel_2_2_3,kernel_2_2_2,kernel_2_2_1,kernel_2_2_0,
           kernel_2_3_8,kernel_2_3_7,kernel_2_3_6,kernel_2_3_5,kernel_2_3_4,kernel_2_3_3,kernel_2_3_2,kernel_2_3_1,kernel_2_3_0,

           //PE_group 3
           kernel_3_0_8,kernel_3_0_7,kernel_3_0_6,kernel_3_0_5,kernel_3_0_4,kernel_3_0_3,kernel_3_0_2,kernel_3_0_1,kernel_3_0_0,
           kernel_3_1_8,kernel_3_1_7,kernel_3_1_6,kernel_3_1_5,kernel_3_1_4,kernel_3_1_3,kernel_3_1_2,kernel_3_1_1,kernel_3_1_0,
           kernel_3_2_8,kernel_3_2_7,kernel_3_2_6,kernel_3_2_5,kernel_3_2_4,kernel_3_2_3,kernel_3_2_2,kernel_3_2_1,kernel_3_2_0,
           kernel_3_3_8,kernel_3_3_7,kernel_3_3_6,kernel_3_3_5,kernel_3_3_4,kernel_3_3_3,kernel_3_3_2,kernel_3_3_1,kernel_3_3_0,

           CA_sum_0_0,CA_sum_0_1,CA_sum_0_2,CA_sum_0_3,CA_sum_0_4,CA_sum_0_5,CA_sum_0_6,CA_sum_0_7,
           CA_sum_0_8,CA_sum_0_9,CA_sum_0_10,CA_sum_0_11,CA_sum_0_12,CA_sum_0_13,CA_sum_0_14,CA_sum_0_15,

           CA_sum_1_0,CA_sum_1_1,CA_sum_1_2,CA_sum_1_3,CA_sum_1_4,CA_sum_1_5,CA_sum_1_6,CA_sum_1_7,
           CA_sum_1_8,CA_sum_1_9,CA_sum_1_10,CA_sum_1_11,CA_sum_1_12,CA_sum_1_13,CA_sum_1_14,CA_sum_1_15,

           CA_sum_2_0,CA_sum_2_1,CA_sum_2_2,CA_sum_2_3,CA_sum_2_4,CA_sum_2_5,CA_sum_2_6,CA_sum_2_7,
           CA_sum_2_8,CA_sum_2_9,CA_sum_2_10,CA_sum_2_11,CA_sum_2_12,CA_sum_2_13,CA_sum_2_14,CA_sum_2_15,

           CA_sum_3_0,CA_sum_3_1,CA_sum_3_2,CA_sum_3_3,CA_sum_3_4,CA_sum_3_5,CA_sum_3_6,CA_sum_3_7,
           CA_sum_3_8,CA_sum_3_9,CA_sum_3_10,CA_sum_3_11,CA_sum_3_12,CA_sum_3_13,CA_sum_3_14,CA_sum_3_15,

           bias_0,bias_1,bias_2,bias_3,
           bias_out_result_0,bias_out_result_1,bias_out_result_2,bias_out_result_3,

           AT_sum_0,AT_sum_1,AT_sum_2,AT_sum_3,

           bias_in_result_0,bias_in_result_1,bias_in_result_2,bias_in_result_3,
           ReLU_result_0,ReLU_result_1,ReLU_result_2,ReLU_result_3,
           valid_singal_0,valid_singal_1,valid_singal_2,valid_singal_3
       );

input clk,reset;
input signed [8:0] data_in_0,data_in_1,data_in_2,data_in_3;

//PE_group 0
input signed [15:0] kernel_0_0_8,kernel_0_0_7,kernel_0_0_6,kernel_0_0_5,kernel_0_0_4,kernel_0_0_3,kernel_0_0_2,kernel_0_0_1,kernel_0_0_0;
input signed [15:0] kernel_0_1_8,kernel_0_1_7,kernel_0_1_6,kernel_0_1_5,kernel_0_1_4,kernel_0_1_3,kernel_0_1_2,kernel_0_1_1,kernel_0_1_0;
input signed [15:0] kernel_0_2_8,kernel_0_2_7,kernel_0_2_6,kernel_0_2_5,kernel_0_2_4,kernel_0_2_3,kernel_0_2_2,kernel_0_2_1,kernel_0_2_0;
input signed [15:0] kernel_0_3_8,kernel_0_3_7,kernel_0_3_6,kernel_0_3_5,kernel_0_3_4,kernel_0_3_3,kernel_0_3_2,kernel_0_3_1,kernel_0_3_0;

//PE_group 1
input signed [15:0] kernel_1_0_8,kernel_1_0_7,kernel_1_0_6,kernel_1_0_5,kernel_1_0_4,kernel_1_0_3,kernel_1_0_2,kernel_1_0_1,kernel_1_0_0;
input signed [15:0] kernel_1_1_8,kernel_1_1_7,kernel_1_1_6,kernel_1_1_5,kernel_1_1_4,kernel_1_1_3,kernel_1_1_2,kernel_1_1_1,kernel_1_1_0;
input signed [15:0] kernel_1_2_8,kernel_1_2_7,kernel_1_2_6,kernel_1_2_5,kernel_1_2_4,kernel_1_2_3,kernel_1_2_2,kernel_1_2_1,kernel_1_2_0;
input signed [15:0] kernel_1_3_8,kernel_1_3_7,kernel_1_3_6,kernel_1_3_5,kernel_1_3_4,kernel_1_3_3,kernel_1_3_2,kernel_1_3_1,kernel_1_3_0;

//PE_group 2
input signed [15:0] kernel_2_0_8,kernel_2_0_7,kernel_2_0_6,kernel_2_0_5,kernel_2_0_4,kernel_2_0_3,kernel_2_0_2,kernel_2_0_1,kernel_2_0_0;
input signed [15:0] kernel_2_1_8,kernel_2_1_7,kernel_2_1_6,kernel_2_1_5,kernel_2_1_4,kernel_2_1_3,kernel_2_1_2,kernel_2_1_1,kernel_2_1_0;
input signed [15:0] kernel_2_2_8,kernel_2_2_7,kernel_2_2_6,kernel_2_2_5,kernel_2_2_4,kernel_2_2_3,kernel_2_2_2,kernel_2_2_1,kernel_2_2_0;
input signed [15:0] kernel_2_3_8,kernel_2_3_7,kernel_2_3_6,kernel_2_3_5,kernel_2_3_4,kernel_2_3_3,kernel_2_3_2,kernel_2_3_1,kernel_2_3_0;

//PE_group 3
input signed [15:0] kernel_3_0_8,kernel_3_0_7,kernel_3_0_6,kernel_3_0_5,kernel_3_0_4,kernel_3_0_3,kernel_3_0_2,kernel_3_0_1,kernel_3_0_0;
input signed [15:0] kernel_3_1_8,kernel_3_1_7,kernel_3_1_6,kernel_3_1_5,kernel_3_1_4,kernel_3_1_3,kernel_3_1_2,kernel_3_1_1,kernel_3_1_0;
input signed [15:0] kernel_3_2_8,kernel_3_2_7,kernel_3_2_6,kernel_3_2_5,kernel_3_2_4,kernel_3_2_3,kernel_3_2_2,kernel_3_2_1,kernel_3_2_0;
input signed [15:0] kernel_3_3_8,kernel_3_3_7,kernel_3_3_6,kernel_3_3_5,kernel_3_3_4,kernel_3_3_3,kernel_3_3_2,kernel_3_3_1,kernel_3_3_0;

input signed [35:0] CA_sum_0_0,CA_sum_0_1,CA_sum_0_2,CA_sum_0_3,CA_sum_0_4,CA_sum_0_5,CA_sum_0_6,CA_sum_0_7;
input signed [35:0] CA_sum_0_8,CA_sum_0_9,CA_sum_0_10,CA_sum_0_11,CA_sum_0_12,CA_sum_0_13,CA_sum_0_14,CA_sum_0_15;

input signed [35:0] CA_sum_1_0,CA_sum_1_1,CA_sum_1_2,CA_sum_1_3,CA_sum_1_4,CA_sum_1_5,CA_sum_1_6,CA_sum_1_7;
input signed [35:0] CA_sum_1_8,CA_sum_1_9,CA_sum_1_10,CA_sum_1_11,CA_sum_1_12,CA_sum_1_13,CA_sum_1_14,CA_sum_1_15;

input signed [35:0] CA_sum_2_0,CA_sum_2_1,CA_sum_2_2,CA_sum_2_3,CA_sum_2_4,CA_sum_2_5,CA_sum_2_6,CA_sum_2_7;
input signed [35:0] CA_sum_2_8,CA_sum_2_9,CA_sum_2_10,CA_sum_2_11,CA_sum_2_12,CA_sum_2_13,CA_sum_2_14,CA_sum_2_15;

input signed [35:0] CA_sum_3_0,CA_sum_3_1,CA_sum_3_2,CA_sum_3_3,CA_sum_3_4,CA_sum_3_5,CA_sum_3_6,CA_sum_3_7;
input signed [35:0] CA_sum_3_8,CA_sum_3_9,CA_sum_3_10,CA_sum_3_11,CA_sum_3_12,CA_sum_3_13,CA_sum_3_14,CA_sum_3_15;

input signed [15:0] bias_0,bias_1,bias_2,bias_3;
input signed [35:0] bias_in_result_0,bias_in_result_1,bias_in_result_2,bias_in_result_3;

output signed [35:0] bias_out_result_0,bias_out_result_1,bias_out_result_2,bias_out_result_3;
output signed [35:0] AT_sum_0,AT_sum_1,AT_sum_2,AT_sum_3;
output signed [35:0] ReLU_result_0,ReLU_result_1,ReLU_result_2,ReLU_result_3;
output valid_singal_0,valid_singal_1,valid_singal_2,valid_singal_3;

wire [8:0] data_out_0_8,data_out_0_7,data_out_0_6,data_out_0_5,data_out_0_4,data_out_0_3,data_out_0_2,data_out_0_1,data_out_0_0;
wire [8:0] data_out_1_8,data_out_1_7,data_out_1_6,data_out_1_5,data_out_1_4,data_out_1_3,data_out_1_2,data_out_1_1,data_out_1_0;
wire [8:0] data_out_2_8,data_out_2_7,data_out_2_6,data_out_2_5,data_out_2_4,data_out_2_3,data_out_2_2,data_out_2_1,data_out_2_0;
wire [8:0] data_out_3_8,data_out_3_7,data_out_3_6,data_out_3_5,data_out_3_4,data_out_3_3,data_out_3_2,data_out_3_1,data_out_3_0;

//wire [35:0] bias_result_0,bias_result_1,bias_result_2,bias_result_3;

LB LB_inst_0(
       .clk(clk),
       .reset(reset),
       .data_in(data_in_0),
       .data_out_8(data_out_0_8),
       .data_out_7(data_out_0_7),
       .data_out_6(data_out_0_6),
       .data_out_5(data_out_0_5),
       .data_out_4(data_out_0_4),
       .data_out_3(data_out_0_3),
       .data_out_2(data_out_0_2),
       .data_out_1(data_out_0_1),
       .data_out_0(data_out_0_0),
       .valid_singal(valid_singal_0)
   );

LB LB_inst_1(
       .clk(clk),
       .reset(reset),
       .data_in(data_in_1),
       .data_out_8(data_out_1_8),
       .data_out_7(data_out_1_7),
       .data_out_6(data_out_1_6),
       .data_out_5(data_out_1_5),
       .data_out_4(data_out_1_4),
       .data_out_3(data_out_1_3),
       .data_out_2(data_out_1_2),
       .data_out_1(data_out_1_1),
       .data_out_0(data_out_1_0),
       .valid_singal(valid_singal_1)
   );

LB LB_inst_2(
       .clk(clk),
       .reset(reset),
       .data_in(data_in_2),
       .data_out_8(data_out_2_8),
       .data_out_7(data_out_2_7),
       .data_out_6(data_out_2_6),
       .data_out_5(data_out_2_5),
       .data_out_4(data_out_2_4),
       .data_out_3(data_out_2_3),
       .data_out_2(data_out_2_2),
       .data_out_1(data_out_2_1),
       .data_out_0(data_out_2_0),
       .valid_singal(valid_singal_2)
   );

LB LB_inst_3(
       .clk(clk),
       .reset(reset),
       .data_in(data_in_3),
       .data_out_8(data_out_3_8),
       .data_out_7(data_out_3_7),
       .data_out_6(data_out_3_6),
       .data_out_5(data_out_3_5),
       .data_out_4(data_out_3_4),
       .data_out_3(data_out_3_3),
       .data_out_2(data_out_3_2),
       .data_out_1(data_out_3_1),
       .data_out_0(data_out_3_0),
       .valid_singal(valid_singal_3)
   );

PE_group PE_group_inst_0(
             .data_out_0_8(data_out_0_8),.data_out_0_7(data_out_0_7),.data_out_0_6(data_out_0_6),
             .data_out_0_5(data_out_0_5),.data_out_0_4(data_out_0_4),.data_out_0_3(data_out_0_3),
             .data_out_0_2(data_out_0_2),.data_out_0_1(data_out_0_1),.data_out_0_0(data_out_0_0),

             .data_out_1_8(data_out_1_8),.data_out_1_7(data_out_1_7),.data_out_1_6(data_out_1_6),
             .data_out_1_5(data_out_1_5),.data_out_1_4(data_out_1_4),.data_out_1_3(data_out_1_3),
             .data_out_1_2(data_out_1_2),.data_out_1_1(data_out_1_1),.data_out_1_0(data_out_1_0),

             .data_out_2_8(data_out_2_8),.data_out_2_7(data_out_2_7),.data_out_2_6(data_out_2_6),
             .data_out_2_5(data_out_2_5),.data_out_2_4(data_out_2_4),.data_out_2_3(data_out_2_3),
             .data_out_2_2(data_out_2_2),.data_out_2_1(data_out_2_1),.data_out_2_0(data_out_2_0),

             .data_out_3_8(data_out_3_8),.data_out_3_7(data_out_3_7),.data_out_3_6(data_out_3_6),
             .data_out_3_5(data_out_3_5),.data_out_3_4(data_out_3_4),.data_out_3_3(data_out_3_3),
             .data_out_3_2(data_out_3_2),.data_out_3_1(data_out_3_1),.data_out_3_0(data_out_3_0),

             .kernel_0_8(kernel_0_0_8),.kernel_0_7(kernel_0_0_7),.kernel_0_6(kernel_0_0_6),
             .kernel_0_5(kernel_0_0_5),.kernel_0_4(kernel_0_0_4),.kernel_0_3(kernel_0_0_3),
             .kernel_0_2(kernel_0_0_2),.kernel_0_1(kernel_0_0_1),.kernel_0_0(kernel_0_0_0),

             .kernel_1_8(kernel_0_1_8),.kernel_1_7(kernel_0_1_7),.kernel_1_6(kernel_0_1_6),
             .kernel_1_5(kernel_0_1_5),.kernel_1_4(kernel_0_1_4),.kernel_1_3(kernel_0_1_3),
             .kernel_1_2(kernel_0_1_2),.kernel_1_1(kernel_0_1_1),.kernel_1_0(kernel_0_1_0),

             .kernel_2_8(kernel_0_2_8),.kernel_2_7(kernel_0_2_7),.kernel_2_6(kernel_0_2_6),
             .kernel_2_5(kernel_0_2_5),.kernel_2_4(kernel_0_2_4),.kernel_2_3(kernel_0_2_3),
             .kernel_2_2(kernel_0_2_2),.kernel_2_1(kernel_0_2_1),.kernel_2_0(kernel_0_2_0),

             .kernel_3_8(kernel_0_3_8),.kernel_3_7(kernel_0_3_7),.kernel_3_6(kernel_0_3_6),
             .kernel_3_5(kernel_0_3_5),.kernel_3_4(kernel_0_3_4),.kernel_3_3(kernel_0_3_3),
             .kernel_3_2(kernel_0_3_2),.kernel_3_1(kernel_0_3_1),.kernel_3_0(kernel_0_3_0),
             .AT_sum(AT_sum_0)
         );

bias bias_inst_0(
         .CA_sum_0(CA_sum_0_0),.CA_sum_1(CA_sum_0_1),.CA_sum_2(CA_sum_0_2),.CA_sum_3(CA_sum_0_3),
         .CA_sum_4(CA_sum_0_4),.CA_sum_5(CA_sum_0_5),.CA_sum_6(CA_sum_0_6),.CA_sum_7(CA_sum_0_7),
         .CA_sum_8(CA_sum_0_8),.CA_sum_9(CA_sum_0_9),.CA_sum_10(CA_sum_0_10),.CA_sum_11(CA_sum_0_11),
         .CA_sum_12(CA_sum_0_12),.CA_sum_13(CA_sum_0_13),.CA_sum_14(CA_sum_0_14),.CA_sum_15(CA_sum_0_15),
         .bias(bias_0),
         .bias_out_result(bias_out_result_0)
     );

ReLU ReLU_inst_0(
         .bias_in_result(bias_out_result_0),
         .ReLU_result(ReLU_result_0)
     );

PE_group PE_group_inst_1(
             .data_out_0_8(data_out_0_8),.data_out_0_7(data_out_0_7),.data_out_0_6(data_out_0_6),
             .data_out_0_5(data_out_0_5),.data_out_0_4(data_out_0_4),.data_out_0_3(data_out_0_3),
             .data_out_0_2(data_out_0_2),.data_out_0_1(data_out_0_1),.data_out_0_0(data_out_0_0),

             .data_out_1_8(data_out_1_8),.data_out_1_7(data_out_1_7),.data_out_1_6(data_out_1_6),
             .data_out_1_5(data_out_1_5),.data_out_1_4(data_out_1_4),.data_out_1_3(data_out_1_3),
             .data_out_1_2(data_out_1_2),.data_out_1_1(data_out_1_1),.data_out_1_0(data_out_1_0),

             .data_out_2_8(data_out_2_8),.data_out_2_7(data_out_2_7),.data_out_2_6(data_out_2_6),
             .data_out_2_5(data_out_2_5),.data_out_2_4(data_out_2_4),.data_out_2_3(data_out_2_3),
             .data_out_2_2(data_out_2_2),.data_out_2_1(data_out_2_1),.data_out_2_0(data_out_2_0),

             .data_out_3_8(data_out_3_8),.data_out_3_7(data_out_3_7),.data_out_3_6(data_out_3_6),
             .data_out_3_5(data_out_3_5),.data_out_3_4(data_out_3_4),.data_out_3_3(data_out_3_3),
             .data_out_3_2(data_out_3_2),.data_out_3_1(data_out_3_1),.data_out_3_0(data_out_3_0),

             .kernel_0_8(kernel_1_0_8),.kernel_0_7(kernel_1_0_7),.kernel_0_6(kernel_1_0_6),
             .kernel_0_5(kernel_1_0_5),.kernel_0_4(kernel_1_0_4),.kernel_0_3(kernel_1_0_3),
             .kernel_0_2(kernel_1_0_2),.kernel_0_1(kernel_1_0_1),.kernel_0_0(kernel_1_0_0),

             .kernel_1_8(kernel_1_1_8),.kernel_1_7(kernel_1_1_7),.kernel_1_6(kernel_1_1_6),
             .kernel_1_5(kernel_1_1_5),.kernel_1_4(kernel_1_1_4),.kernel_1_3(kernel_1_1_3),
             .kernel_1_2(kernel_1_1_2),.kernel_1_1(kernel_1_1_1),.kernel_1_0(kernel_1_1_0),

             .kernel_2_8(kernel_1_2_8),.kernel_2_7(kernel_1_2_7),.kernel_2_6(kernel_1_2_6),
             .kernel_2_5(kernel_1_2_5),.kernel_2_4(kernel_1_2_4),.kernel_2_3(kernel_1_2_3),
             .kernel_2_2(kernel_1_2_2),.kernel_2_1(kernel_1_2_1),.kernel_2_0(kernel_1_2_0),

             .kernel_3_8(kernel_1_3_8),.kernel_3_7(kernel_1_3_7),.kernel_3_6(kernel_1_3_6),
             .kernel_3_5(kernel_1_3_5),.kernel_3_4(kernel_1_3_4),.kernel_3_3(kernel_1_3_3),
             .kernel_3_2(kernel_1_3_2),.kernel_3_1(kernel_1_3_1),.kernel_3_0(kernel_1_3_0),
             .AT_sum(AT_sum_1)
         );

bias bias_inst_1(
         .CA_sum_0(CA_sum_1_0),.CA_sum_1(CA_sum_1_1),.CA_sum_2(CA_sum_1_2),.CA_sum_3(CA_sum_1_3),
         .CA_sum_4(CA_sum_1_4),.CA_sum_5(CA_sum_1_5),.CA_sum_6(CA_sum_1_6),.CA_sum_7(CA_sum_1_7),
         .CA_sum_8(CA_sum_1_8),.CA_sum_9(CA_sum_1_9),.CA_sum_10(CA_sum_1_10),.CA_sum_11(CA_sum_1_11),
         .CA_sum_12(CA_sum_1_12),.CA_sum_13(CA_sum_1_13),.CA_sum_14(CA_sum_1_14),.CA_sum_15(CA_sum_1_15),
         .bias(bias_1),
         .bias_out_result(bias_out_result_1)
     );

ReLU ReLU_inst_1(
         .bias_in_result(bias_out_result_1),
         .ReLU_result(ReLU_result_1)
     );

PE_group PE_group_inst_2(
             .data_out_0_8(data_out_0_8),.data_out_0_7(data_out_0_7),.data_out_0_6(data_out_0_6),
             .data_out_0_5(data_out_0_5),.data_out_0_4(data_out_0_4),.data_out_0_3(data_out_0_3),
             .data_out_0_2(data_out_0_2),.data_out_0_1(data_out_0_1),.data_out_0_0(data_out_0_0),

             .data_out_1_8(data_out_1_8),.data_out_1_7(data_out_1_7),.data_out_1_6(data_out_1_6),
             .data_out_1_5(data_out_1_5),.data_out_1_4(data_out_1_4),.data_out_1_3(data_out_1_3),
             .data_out_1_2(data_out_1_2),.data_out_1_1(data_out_1_1),.data_out_1_0(data_out_1_0),

             .data_out_2_8(data_out_2_8),.data_out_2_7(data_out_2_7),.data_out_2_6(data_out_2_6),
             .data_out_2_5(data_out_2_5),.data_out_2_4(data_out_2_4),.data_out_2_3(data_out_2_3),
             .data_out_2_2(data_out_2_2),.data_out_2_1(data_out_2_1),.data_out_2_0(data_out_2_0),

             .data_out_3_8(data_out_3_8),.data_out_3_7(data_out_3_7),.data_out_3_6(data_out_3_6),
             .data_out_3_5(data_out_3_5),.data_out_3_4(data_out_3_4),.data_out_3_3(data_out_3_3),
             .data_out_3_2(data_out_3_2),.data_out_3_1(data_out_3_1),.data_out_3_0(data_out_3_0),

             .kernel_0_8(kernel_2_0_8),.kernel_0_7(kernel_2_0_7),.kernel_0_6(kernel_2_0_6),
             .kernel_0_5(kernel_2_0_5),.kernel_0_4(kernel_2_0_4),.kernel_0_3(kernel_2_0_3),
             .kernel_0_2(kernel_2_0_2),.kernel_0_1(kernel_2_0_1),.kernel_0_0(kernel_2_0_0),

             .kernel_1_8(kernel_2_1_8),.kernel_1_7(kernel_2_1_7),.kernel_1_6(kernel_2_1_6),
             .kernel_1_5(kernel_2_1_5),.kernel_1_4(kernel_2_1_4),.kernel_1_3(kernel_2_1_3),
             .kernel_1_2(kernel_2_1_2),.kernel_1_1(kernel_2_1_1),.kernel_1_0(kernel_2_1_0),

             .kernel_2_8(kernel_2_2_8),.kernel_2_7(kernel_2_2_7),.kernel_2_6(kernel_2_2_6),
             .kernel_2_5(kernel_2_2_5),.kernel_2_4(kernel_2_2_4),.kernel_2_3(kernel_2_2_3),
             .kernel_2_2(kernel_2_2_2),.kernel_2_1(kernel_2_2_1),.kernel_2_0(kernel_2_2_0),

             .kernel_3_8(kernel_2_3_8),.kernel_3_7(kernel_2_3_7),.kernel_3_6(kernel_2_3_6),
             .kernel_3_5(kernel_2_3_5),.kernel_3_4(kernel_2_3_4),.kernel_3_3(kernel_2_3_3),
             .kernel_3_2(kernel_2_3_2),.kernel_3_1(kernel_2_3_1),.kernel_3_0(kernel_2_3_0),
             .AT_sum(AT_sum_2)
         );

bias bias_inst_2(
         .CA_sum_0(CA_sum_2_0),.CA_sum_1(CA_sum_2_1),.CA_sum_2(CA_sum_2_2),.CA_sum_3(CA_sum_2_3),
         .CA_sum_4(CA_sum_2_4),.CA_sum_5(CA_sum_2_5),.CA_sum_6(CA_sum_2_6),.CA_sum_7(CA_sum_2_7),
         .CA_sum_8(CA_sum_2_8),.CA_sum_9(CA_sum_2_9),.CA_sum_10(CA_sum_2_10),.CA_sum_11(CA_sum_2_11),
         .CA_sum_12(CA_sum_2_12),.CA_sum_13(CA_sum_2_13),.CA_sum_14(CA_sum_2_14),.CA_sum_15(CA_sum_2_15),
         .bias(bias_2),
         .bias_out_result(bias_out_result_2)
     );

ReLU ReLU_inst_2(
         .bias_in_result(bias_out_result_2),
         .ReLU_result(ReLU_result_2)
     );

PE_group PE_group_inst_3(
             .data_out_0_8(data_out_0_8),.data_out_0_7(data_out_0_7),.data_out_0_6(data_out_0_6),
             .data_out_0_5(data_out_0_5),.data_out_0_4(data_out_0_4),.data_out_0_3(data_out_0_3),
             .data_out_0_2(data_out_0_2),.data_out_0_1(data_out_0_1),.data_out_0_0(data_out_0_0),

             .data_out_1_8(data_out_1_8),.data_out_1_7(data_out_1_7),.data_out_1_6(data_out_1_6),
             .data_out_1_5(data_out_1_5),.data_out_1_4(data_out_1_4),.data_out_1_3(data_out_1_3),
             .data_out_1_2(data_out_1_2),.data_out_1_1(data_out_1_1),.data_out_1_0(data_out_1_0),

             .data_out_2_8(data_out_2_8),.data_out_2_7(data_out_2_7),.data_out_2_6(data_out_2_6),
             .data_out_2_5(data_out_2_5),.data_out_2_4(data_out_2_4),.data_out_2_3(data_out_2_3),
             .data_out_2_2(data_out_2_2),.data_out_2_1(data_out_2_1),.data_out_2_0(data_out_2_0),

             .data_out_3_8(data_out_3_8),.data_out_3_7(data_out_3_7),.data_out_3_6(data_out_3_6),
             .data_out_3_5(data_out_3_5),.data_out_3_4(data_out_3_4),.data_out_3_3(data_out_3_3),
             .data_out_3_2(data_out_3_2),.data_out_3_1(data_out_3_1),.data_out_3_0(data_out_3_0),

             .kernel_0_8(kernel_3_0_8),.kernel_0_7(kernel_3_0_7),.kernel_0_6(kernel_3_0_6),
             .kernel_0_5(kernel_3_0_5),.kernel_0_4(kernel_3_0_4),.kernel_0_3(kernel_3_0_3),
             .kernel_0_2(kernel_3_0_2),.kernel_0_1(kernel_3_0_1),.kernel_0_0(kernel_3_0_0),

             .kernel_1_8(kernel_3_1_8),.kernel_1_7(kernel_3_1_7),.kernel_1_6(kernel_3_1_6),
             .kernel_1_5(kernel_3_1_5),.kernel_1_4(kernel_3_1_4),.kernel_1_3(kernel_3_1_3),
             .kernel_1_2(kernel_3_1_2),.kernel_1_1(kernel_3_1_1),.kernel_1_0(kernel_3_1_0),

             .kernel_2_8(kernel_3_2_8),.kernel_2_7(kernel_3_2_7),.kernel_2_6(kernel_3_2_6),
             .kernel_2_5(kernel_3_2_5),.kernel_2_4(kernel_3_2_4),.kernel_2_3(kernel_3_2_3),
             .kernel_2_2(kernel_3_2_2),.kernel_2_1(kernel_3_2_1),.kernel_2_0(kernel_3_2_0),

             .kernel_3_8(kernel_3_3_8),.kernel_3_7(kernel_3_3_7),.kernel_3_6(kernel_3_3_6),
             .kernel_3_5(kernel_3_3_5),.kernel_3_4(kernel_3_3_4),.kernel_3_3(kernel_3_3_3),
             .kernel_3_2(kernel_3_3_2),.kernel_3_1(kernel_3_3_1),.kernel_3_0(kernel_3_3_0),
             .AT_sum(AT_sum_3)
         );

bias bias_inst_3(
         .CA_sum_0(CA_sum_3_0),.CA_sum_1(CA_sum_3_1),.CA_sum_2(CA_sum_3_2),.CA_sum_3(CA_sum_3_3),
         .CA_sum_4(CA_sum_3_4),.CA_sum_5(CA_sum_3_5),.CA_sum_6(CA_sum_3_6),.CA_sum_7(CA_sum_3_7),
         .CA_sum_8(CA_sum_3_8),.CA_sum_9(CA_sum_3_9),.CA_sum_10(CA_sum_3_10),.CA_sum_11(CA_sum_3_11),
         .CA_sum_12(CA_sum_3_12),.CA_sum_13(CA_sum_3_13),.CA_sum_14(CA_sum_3_14),.CA_sum_15(CA_sum_3_15),
         .bias(bias_3),
         .bias_out_result(bias_out_result_3)
     );

ReLU ReLU_inst_3(
         .bias_in_result(bias_out_result_3),
         .ReLU_result(ReLU_result_3)
     );

endmodule
