module ReLU(bias_in_result,ReLU_result);
input signed [35:0] bias_in_result;
output signed [35:0] ReLU_result;

assign ReLU_result = (bias_in_result < 0) ? 36'd0 : bias_in_result;

endmodule
