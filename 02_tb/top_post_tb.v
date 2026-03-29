`timescale 1ns / 1ps
`define period                  10
`define width                   226
`define length                  226
`define img_size                224 * 224 * 3+54   //480*360 高*寬 3 RGB 54 header
`define padding_img_size        226 * 226        //加上zero_padding的大小
`define layer1_kernel_path      "'/you own path'/conv1_kernel_hex.txt"
`define layer2_kernel_path      "'/you own path'/conv2_kernel_hex.txt"
`define layer1_bias_path        "'/you own path'/conv1_bias_hex.txt"
`define layer2_bias_path        "'/you own path'/conv2_bias_hex.txt"

`define path_img_in             "'/you own path'/cat224.bmp"
`define path_Layer_1_folder     "'/you own path'/post_cat_after/Post_Layer_1/"
`define path_Layer_2_folder     "'/you own path'/post_cat_after/Post_Layer_2/"
`define path_sdf                "'/you own path'/04_gate_level/top.sdf"

`define img_corret_bytes        150582
`define img_corret_pixel        50176
`define Layer_1_round_times     16
`define Layer_2_round_times     16
`define display_flag            0
`define Layer_1_enable          1
`define Layer_2_enable          1
module top_post_sim();
reg clk,reset;
reg signed [8:0] data_in_0,data_in_1,data_in_2,data_in_3;

//PE_group 0
reg signed [15:0] kernel_0_0_8,kernel_0_0_7,kernel_0_0_6,kernel_0_0_5,kernel_0_0_4,kernel_0_0_3,kernel_0_0_2,kernel_0_0_1,kernel_0_0_0;
reg signed [15:0] kernel_0_1_8,kernel_0_1_7,kernel_0_1_6,kernel_0_1_5,kernel_0_1_4,kernel_0_1_3,kernel_0_1_2,kernel_0_1_1,kernel_0_1_0;
reg signed [15:0] kernel_0_2_8,kernel_0_2_7,kernel_0_2_6,kernel_0_2_5,kernel_0_2_4,kernel_0_2_3,kernel_0_2_2,kernel_0_2_1,kernel_0_2_0;
reg signed [15:0] kernel_0_3_8,kernel_0_3_7,kernel_0_3_6,kernel_0_3_5,kernel_0_3_4,kernel_0_3_3,kernel_0_3_2,kernel_0_3_1,kernel_0_3_0;

//PE_group 1
reg signed [15:0] kernel_1_0_8,kernel_1_0_7,kernel_1_0_6,kernel_1_0_5,kernel_1_0_4,kernel_1_0_3,kernel_1_0_2,kernel_1_0_1,kernel_1_0_0;
reg signed [15:0] kernel_1_1_8,kernel_1_1_7,kernel_1_1_6,kernel_1_1_5,kernel_1_1_4,kernel_1_1_3,kernel_1_1_2,kernel_1_1_1,kernel_1_1_0;
reg signed [15:0] kernel_1_2_8,kernel_1_2_7,kernel_1_2_6,kernel_1_2_5,kernel_1_2_4,kernel_1_2_3,kernel_1_2_2,kernel_1_2_1,kernel_1_2_0;
reg signed [15:0] kernel_1_3_8,kernel_1_3_7,kernel_1_3_6,kernel_1_3_5,kernel_1_3_4,kernel_1_3_3,kernel_1_3_2,kernel_1_3_1,kernel_1_3_0;

//PE_group 2
reg signed [15:0] kernel_2_0_8,kernel_2_0_7,kernel_2_0_6,kernel_2_0_5,kernel_2_0_4,kernel_2_0_3,kernel_2_0_2,kernel_2_0_1,kernel_2_0_0;
reg signed [15:0] kernel_2_1_8,kernel_2_1_7,kernel_2_1_6,kernel_2_1_5,kernel_2_1_4,kernel_2_1_3,kernel_2_1_2,kernel_2_1_1,kernel_2_1_0;
reg signed [15:0] kernel_2_2_8,kernel_2_2_7,kernel_2_2_6,kernel_2_2_5,kernel_2_2_4,kernel_2_2_3,kernel_2_2_2,kernel_2_2_1,kernel_2_2_0;
reg signed [15:0] kernel_2_3_8,kernel_2_3_7,kernel_2_3_6,kernel_2_3_5,kernel_2_3_4,kernel_2_3_3,kernel_2_3_2,kernel_2_3_1,kernel_2_3_0;

//PE_group 3
reg signed [15:0] kernel_3_0_8,kernel_3_0_7,kernel_3_0_6,kernel_3_0_5,kernel_3_0_4,kernel_3_0_3,kernel_3_0_2,kernel_3_0_1,kernel_3_0_0;
reg signed [15:0] kernel_3_1_8,kernel_3_1_7,kernel_3_1_6,kernel_3_1_5,kernel_3_1_4,kernel_3_1_3,kernel_3_1_2,kernel_3_1_1,kernel_3_1_0;
reg signed [15:0] kernel_3_2_8,kernel_3_2_7,kernel_3_2_6,kernel_3_2_5,kernel_3_2_4,kernel_3_2_3,kernel_3_2_2,kernel_3_2_1,kernel_3_2_0;
reg signed [15:0] kernel_3_3_8,kernel_3_3_7,kernel_3_3_6,kernel_3_3_5,kernel_3_3_4,kernel_3_3_3,kernel_3_3_2,kernel_3_3_1,kernel_3_3_0;

reg signed [35:0] CA_sum_0_ [15:0];
reg signed [35:0] CA_sum_1_ [15:0];
reg signed [35:0] CA_sum_2_ [15:0];
reg signed [35:0] CA_sum_3_ [15:0];

reg signed [15:0] bias_0,bias_1,bias_2,bias_3;
reg signed [35:0] bias_in_result_0,bias_in_result_1,bias_in_result_2,bias_in_result_3;

wire signed [35:0] AT_sum_0,AT_sum_1,AT_sum_2,AT_sum_3;
wire signed [35:0] bias_out_result_0,bias_out_result_1,bias_out_result_2,bias_out_result_3;
wire signed [35:0] ReLU_result_0,ReLU_result_1,ReLU_result_2,ReLU_result_3;
wire valid_singal_0,valid_singal_1,valid_singal_2,valid_singal_3;

reg signed [8:0] padding_img           [0:`padding_img_size-1][2:0];
reg [7:0] img_data              [0:`img_size-1];
reg signed [8:0] Layer_1_padding_img   [0:`padding_img_size-1][63:0];    //Layer_1_output_img_with_zero_padding

reg signed [15:0] kernel_1_mem [1727:0];
reg signed [15:0] kernel_2_mem [36863:0];
reg signed [15:0] bias_1_mem   [63:0];
reg signed [15:0] bias_2_mem   [63:0];
//reg [15:0] Layer_1_kernel,Layer_2_kernel,Layer_1_bias,Layer_2_bias;

reg [7:0] ten_digit,units_digit;
reg [8*100:1] Layer_1_out_file_name,Layer_2_out_file_name;
reg signed [8:0] R;
reg signed [8:0] G;
reg signed [8:0] B;

reg [7:0] layer_1_out_3;

//wire [35:0] bias_result_0,bias_result_1,bias_result_2,bias_result_3;

integer img_in;
integer idx,i,file_num,header;
integer img_w,img_h,offset,h,w;
integer row,col;
integer row_0,row_1,row_2,row_3;
integer col_0,col_1,col_2,col_3;
integer Layer_1_img[63:0],Layer_2_img[63:0];
integer round,Layer_2_kernel_round;
integer CA_num;
integer Layer_1_pixel_0,Layer_1_pixel_1,Layer_1_pixel_2,Layer_1_pixel_3;
integer Layer_1_img_0_bytes,Layer_1_img_1_bytes,Layer_1_img_2_bytes,Layer_1_img_3_bytes;
integer Layer_2_pixel_0,Layer_2_pixel_1,Layer_2_pixel_2,Layer_2_pixel_3;
integer Layer_2_img_0_bytes,Layer_2_img_1_bytes,Layer_2_img_2_bytes,Layer_2_img_3_bytes;

reg [19:0] Layer_1_pixel_mem        [63:0];
reg [19:0] Layer_1_img_bytes_mem    [63:0];
reg [19:0] Layer_2_pixel_mem        [63:0];
reg [19:0] Layer_2_img_bytes_mem    [63:0];
reg signed [35:0] Layer_2_CA_0      [15:0][50175:0];
reg signed [35:0] Layer_2_CA_1      [15:0][50175:0];
reg signed [35:0] Layer_2_CA_2      [15:0][50175:0];
reg signed [35:0] Layer_2_CA_3      [15:0][50175:0];

reg [7:0] pixel_out_0;
reg [7:0] pixel_out_1;
reg [7:0] pixel_out_2;
reg [7:0] pixel_out_3;

top top_inst(
        .clk(clk),.reset(reset),
        .data_in_0(data_in_0),.data_in_1(data_in_1),.data_in_2(data_in_2),.data_in_3(data_in_3),

        .kernel_0_0_8(kernel_0_0_8),.kernel_0_0_7(kernel_0_0_7),.kernel_0_0_6(kernel_0_0_6),
        .kernel_0_0_5(kernel_0_0_5),.kernel_0_0_4(kernel_0_0_4),.kernel_0_0_3(kernel_0_0_3),
        .kernel_0_0_2(kernel_0_0_2),.kernel_0_0_1(kernel_0_0_1),.kernel_0_0_0(kernel_0_0_0),

        .kernel_0_1_8(kernel_0_1_8),.kernel_0_1_7(kernel_0_1_7),.kernel_0_1_6(kernel_0_1_6),
        .kernel_0_1_5(kernel_0_1_5),.kernel_0_1_4(kernel_0_1_4),.kernel_0_1_3(kernel_0_1_3),
        .kernel_0_1_2(kernel_0_1_2),.kernel_0_1_1(kernel_0_1_1),.kernel_0_1_0(kernel_0_1_0),

        .kernel_0_2_8(kernel_0_2_8),.kernel_0_2_7(kernel_0_2_7),.kernel_0_2_6(kernel_0_2_6),
        .kernel_0_2_5(kernel_0_2_5),.kernel_0_2_4(kernel_0_2_4),.kernel_0_2_3(kernel_0_2_3),
        .kernel_0_2_2(kernel_0_2_2),.kernel_0_2_1(kernel_0_2_1),.kernel_0_2_0(kernel_0_2_0),

        .kernel_0_3_8(kernel_0_3_8),.kernel_0_3_7(kernel_0_3_7),.kernel_0_3_6(kernel_0_3_6),
        .kernel_0_3_5(kernel_0_3_5),.kernel_0_3_4(kernel_0_3_4),.kernel_0_3_3(kernel_0_3_3),
        .kernel_0_3_2(kernel_0_3_2),.kernel_0_3_1(kernel_0_3_1),.kernel_0_3_0(kernel_0_3_0),

        .kernel_1_0_8(kernel_1_0_8),.kernel_1_0_7(kernel_1_0_7),.kernel_1_0_6(kernel_1_0_6),
        .kernel_1_0_5(kernel_1_0_5),.kernel_1_0_4(kernel_1_0_4),.kernel_1_0_3(kernel_1_0_3),
        .kernel_1_0_2(kernel_1_0_2),.kernel_1_0_1(kernel_1_0_1),.kernel_1_0_0(kernel_1_0_0),

        .kernel_1_1_8(kernel_1_1_8),.kernel_1_1_7(kernel_1_1_7),.kernel_1_1_6(kernel_1_1_6),
        .kernel_1_1_5(kernel_1_1_5),.kernel_1_1_4(kernel_1_1_4),.kernel_1_1_3(kernel_1_1_3),
        .kernel_1_1_2(kernel_1_1_2),.kernel_1_1_1(kernel_1_1_1),.kernel_1_1_0(kernel_1_1_0),

        .kernel_1_2_8(kernel_1_2_8),.kernel_1_2_7(kernel_1_2_7),.kernel_1_2_6(kernel_1_2_6),
        .kernel_1_2_5(kernel_1_2_5),.kernel_1_2_4(kernel_1_2_4),.kernel_1_2_3(kernel_1_2_3),
        .kernel_1_2_2(kernel_1_2_2),.kernel_1_2_1(kernel_1_2_1),.kernel_1_2_0(kernel_1_2_0),

        .kernel_1_3_8(kernel_1_3_8),.kernel_1_3_7(kernel_1_3_7),.kernel_1_3_6(kernel_1_3_6),
        .kernel_1_3_5(kernel_1_3_5),.kernel_1_3_4(kernel_1_3_4),.kernel_1_3_3(kernel_1_3_3),
        .kernel_1_3_2(kernel_1_3_2),.kernel_1_3_1(kernel_1_3_1),.kernel_1_3_0(kernel_1_3_0),

        .kernel_2_0_8(kernel_2_0_8),.kernel_2_0_7(kernel_2_0_7),.kernel_2_0_6(kernel_2_0_6),
        .kernel_2_0_5(kernel_2_0_5),.kernel_2_0_4(kernel_2_0_4),.kernel_2_0_3(kernel_2_0_3),
        .kernel_2_0_2(kernel_2_0_2),.kernel_2_0_1(kernel_2_0_1),.kernel_2_0_0(kernel_2_0_0),

        .kernel_2_1_8(kernel_2_1_8),.kernel_2_1_7(kernel_2_1_7),.kernel_2_1_6(kernel_2_1_6),
        .kernel_2_1_5(kernel_2_1_5),.kernel_2_1_4(kernel_2_1_4),.kernel_2_1_3(kernel_2_1_3),
        .kernel_2_1_2(kernel_2_1_2),.kernel_2_1_1(kernel_2_1_1),.kernel_2_1_0(kernel_2_1_0),

        .kernel_2_2_8(kernel_2_2_8),.kernel_2_2_7(kernel_2_2_7),.kernel_2_2_6(kernel_2_2_6),
        .kernel_2_2_5(kernel_2_2_5),.kernel_2_2_4(kernel_2_2_4),.kernel_2_2_3(kernel_2_2_3),
        .kernel_2_2_2(kernel_2_2_2),.kernel_2_2_1(kernel_2_2_1),.kernel_2_2_0(kernel_2_2_0),

        .kernel_2_3_8(kernel_2_3_8),.kernel_2_3_7(kernel_2_3_7),.kernel_2_3_6(kernel_2_3_6),
        .kernel_2_3_5(kernel_2_3_5),.kernel_2_3_4(kernel_2_3_4),.kernel_2_3_3(kernel_2_3_3),
        .kernel_2_3_2(kernel_2_3_2),.kernel_2_3_1(kernel_2_3_1),.kernel_2_3_0(kernel_2_3_0),

        .kernel_3_0_8(kernel_3_0_8),.kernel_3_0_7(kernel_3_0_7),.kernel_3_0_6(kernel_3_0_6),
        .kernel_3_0_5(kernel_3_0_5),.kernel_3_0_4(kernel_3_0_4),.kernel_3_0_3(kernel_3_0_3),
        .kernel_3_0_2(kernel_3_0_2),.kernel_3_0_1(kernel_3_0_1),.kernel_3_0_0(kernel_3_0_0),

        .kernel_3_1_8(kernel_3_1_8),.kernel_3_1_7(kernel_3_1_7),.kernel_3_1_6(kernel_3_1_6),
        .kernel_3_1_5(kernel_3_1_5),.kernel_3_1_4(kernel_3_1_4),.kernel_3_1_3(kernel_3_1_3),
        .kernel_3_1_2(kernel_3_1_2),.kernel_3_1_1(kernel_3_1_1),.kernel_3_1_0(kernel_3_1_0),

        .kernel_3_2_8(kernel_3_2_8),.kernel_3_2_7(kernel_3_2_7),.kernel_3_2_6(kernel_3_2_6),
        .kernel_3_2_5(kernel_3_2_5),.kernel_3_2_4(kernel_3_2_4),.kernel_3_2_3(kernel_3_2_3),
        .kernel_3_2_2(kernel_3_2_2),.kernel_3_2_1(kernel_3_2_1),.kernel_3_2_0(kernel_3_2_0),

        .kernel_3_3_8(kernel_3_3_8),.kernel_3_3_7(kernel_3_3_7),.kernel_3_3_6(kernel_3_3_6),
        .kernel_3_3_5(kernel_3_3_5),.kernel_3_3_4(kernel_3_3_4),.kernel_3_3_3(kernel_3_3_3),
        .kernel_3_3_2(kernel_3_3_2),.kernel_3_3_1(kernel_3_3_1),.kernel_3_3_0(kernel_3_3_0),

        .CA_sum_0_0(CA_sum_0_[0]),.CA_sum_0_1(CA_sum_0_[1]),.CA_sum_0_2(CA_sum_0_[2]),.CA_sum_0_3(CA_sum_0_[3]),
        .CA_sum_0_4(CA_sum_0_[4]),.CA_sum_0_5(CA_sum_0_[5]),.CA_sum_0_6(CA_sum_0_[6]),.CA_sum_0_7(CA_sum_0_[7]),
        .CA_sum_0_8(CA_sum_0_[8]),.CA_sum_0_9(CA_sum_0_[9]),.CA_sum_0_10(CA_sum_0_[10]),.CA_sum_0_11(CA_sum_0_[11]),
        .CA_sum_0_12(CA_sum_0_[12]),.CA_sum_0_13(CA_sum_0_[13]),.CA_sum_0_14(CA_sum_0_[14]),.CA_sum_0_15(CA_sum_0_[15]),

        .CA_sum_1_0(CA_sum_1_[0]),.CA_sum_1_1(CA_sum_1_[1]),.CA_sum_1_2(CA_sum_1_[2]),.CA_sum_1_3(CA_sum_1_[3]),
        .CA_sum_1_4(CA_sum_1_[4]),.CA_sum_1_5(CA_sum_1_[5]),.CA_sum_1_6(CA_sum_1_[6]),.CA_sum_1_7(CA_sum_1_[7]),
        .CA_sum_1_8(CA_sum_1_[8]),.CA_sum_1_9(CA_sum_1_[9]),.CA_sum_1_10(CA_sum_1_[10]),.CA_sum_1_11(CA_sum_1_[11]),
        .CA_sum_1_12(CA_sum_1_[12]),.CA_sum_1_13(CA_sum_1_[13]),.CA_sum_1_14(CA_sum_1_[14]),.CA_sum_1_15(CA_sum_1_[15]),

        .CA_sum_2_0(CA_sum_2_[0]),.CA_sum_2_1(CA_sum_2_[1]),.CA_sum_2_2(CA_sum_2_[2]),.CA_sum_2_3(CA_sum_2_[3]),
        .CA_sum_2_4(CA_sum_2_[4]),.CA_sum_2_5(CA_sum_2_[5]),.CA_sum_2_6(CA_sum_2_[6]),.CA_sum_2_7(CA_sum_2_[7]),
        .CA_sum_2_8(CA_sum_2_[8]),.CA_sum_2_9(CA_sum_2_[9]),.CA_sum_2_10(CA_sum_2_[10]),.CA_sum_2_11(CA_sum_2_[11]),
        .CA_sum_2_12(CA_sum_2_[12]),.CA_sum_2_13(CA_sum_2_[13]),.CA_sum_2_14(CA_sum_2_[14]),.CA_sum_2_15(CA_sum_2_[15]),

        .CA_sum_3_0(CA_sum_3_[0]),.CA_sum_3_1(CA_sum_3_[1]),.CA_sum_3_2(CA_sum_3_[2]),.CA_sum_3_3(CA_sum_3_[3]),
        .CA_sum_3_4(CA_sum_3_[4]),.CA_sum_3_5(CA_sum_3_[5]),.CA_sum_3_6(CA_sum_3_[6]),.CA_sum_3_7(CA_sum_3_[7]),
        .CA_sum_3_8(CA_sum_3_[8]),.CA_sum_3_9(CA_sum_3_[9]),.CA_sum_3_10(CA_sum_3_[10]),.CA_sum_3_11(CA_sum_3_[11]),
        .CA_sum_3_12(CA_sum_3_[12]),.CA_sum_3_13(CA_sum_3_[13]),.CA_sum_3_14(CA_sum_3_[14]),.CA_sum_3_15(CA_sum_3_[15]),

        .bias_0(bias_0),.bias_1(bias_1),.bias_2(bias_2),.bias_3(bias_3),
        .bias_out_result_0(bias_out_result_0),.bias_out_result_1(bias_out_result_1),.bias_out_result_2(bias_out_result_2),.bias_out_result_3(bias_out_result_3),

        .AT_sum_0(AT_sum_0),.AT_sum_1(AT_sum_1),.AT_sum_2(AT_sum_2),.AT_sum_3(AT_sum_3),
        .bias_in_result_0(bias_in_result_0),.bias_in_result_1(bias_in_result_1),.bias_in_result_2(bias_in_result_2),.bias_in_result_3(bias_in_result_3),
        .ReLU_result_0(ReLU_result_0),.ReLU_result_1(ReLU_result_1),.ReLU_result_2(ReLU_result_2),.ReLU_result_3(ReLU_result_3),
        .valid_singal_0(valid_singal_0),.valid_singal_1(valid_singal_1),.valid_singal_2(valid_singal_2),.valid_singal_3(valid_singal_3)
    );

initial begin
    $sdf_annotate (`path_sdf, top_inst);
end

always begin
    #(`period/2.0)
     clk <= ~clk;
end

initial begin
    clk = 1'b0;
    reset = 1'b0;
    for(i = 0;i < 16;i = i +1) begin
        CA_sum_0_[i] = 36'b0;   //channel
        CA_sum_1_[i] = 36'b0;
        CA_sum_2_[i] = 36'b0;
        CA_sum_3_[i] = 36'b0;
    end
    for(i = 0;i < 64;i = i +1) begin
        Layer_1_pixel_mem[i] = 20'b0;
        Layer_1_img_bytes_mem[i] = 20'b0;
        Layer_2_pixel_mem[i] = 20'b0;
        Layer_2_img_bytes_mem[i] = 20'b0;
    end
    for(round = 0;round < 64;round = round + 1) begin
        for(i = 0;i < `padding_img_size;i = i + 1) begin
            Layer_1_padding_img[i][round] = 9'b0;
        end
    end
    Layer_1_pixel_0 = 0;
    Layer_1_pixel_1 = 0;
    Layer_1_pixel_2 = 0;
    Layer_1_pixel_3 = 0;
    Layer_1_img_0_bytes = 0;
    Layer_1_img_1_bytes = 0;
    Layer_1_img_2_bytes = 0;
    Layer_1_img_3_bytes = 0;
    Layer_2_pixel_0 = 0;
    Layer_2_pixel_1 = 0;
    Layer_2_pixel_2 = 0;
    Layer_2_pixel_3 = 0;
    Layer_2_img_0_bytes = 0;
    Layer_2_img_1_bytes = 0;
    Layer_2_img_2_bytes = 0;
    Layer_2_img_3_bytes = 0;
    reset = 1'b0;
    #(`period)
     reset = 1'b1;
    #(`period)
     #(`period)
     reset = 1'b0;
end

initial begin
    //read file
    $readmemh(`layer1_kernel_path, kernel_1_mem);
    $readmemh(`layer2_kernel_path, kernel_2_mem);
    $readmemh(`layer1_bias_path, bias_1_mem);
    $readmemh(`layer2_bias_path, bias_2_mem);
end

//------------------------------------------------------------------------------------------------------------------------------
//This initial block read the pixel,generate Layer_1 and Layer_2 zero padding ouput total 64 + 64 picture
//------------------------------------------------------------------------------------------------------------------------------
initial begin
    //Open file
    img_in  = $fopen(`path_img_in, "rb");

    //Read file
    $fread(img_data, img_in);

    //Read header information of input file
    img_w   = {img_data[21],img_data[20],img_data[19],img_data[18]};
    img_h   = {img_data[25],img_data[24],img_data[23],img_data[22]};
    offset  = {img_data[13],img_data[12],img_data[11],img_data[10]};

    //Generate multitude file and open it
    //(4 * `round_times)
    for(file_num = 0;file_num < 64;file_num = file_num + 1) begin
        //number count
        ten_digit = (file_num + 1) / 10 + "0";
        units_digit = (file_num + 1) % 10 + "0";

        //generate
        Layer_1_out_file_name = {`path_Layer_1_folder,"Layer1_out_img_",ten_digit,units_digit,".bmp"};
        Layer_2_out_file_name = {`path_Layer_2_folder,"Layer2_out_img_",ten_digit,units_digit,".bmp"};

        //open
        Layer_1_img[file_num] = $fopen(Layer_1_out_file_name, "wb");
        Layer_2_img[file_num] = $fopen(Layer_2_out_file_name, "wb");
    end

    //Write header of output bmp file
    //(4 * `round_times)
    for(file_num = 0;file_num < 64;file_num = file_num + 1) begin
        for(header = 0;header < 54;header = header + 1) begin
            $fwrite(Layer_1_img[file_num], "%c", img_data[header]);
            $fwrite(Layer_2_img[file_num], "%c", img_data[header]);
        end
    end

    //Zero padding generate
    for(idx = 0;idx < 3;idx = idx + 1) begin
        for(i = 0;i < `padding_img_size;i = i + 1) begin
            padding_img[i][idx] = 9'b0;
        end
    end

    //Zero padding + read pixel
    for(h = 0; h < img_h; h = h + 1) begin
        for(w = 0; w < img_w; w = w + 1) begin
            padding_img[h * 226 + w + 227][2] = {1'd0,img_data[(h * 224 + w) * 3 + offset + 2]};
            padding_img[h * 226 + w + 227][1] = {1'd0,img_data[(h * 224 + w) * 3 + offset + 1]};
            padding_img[h * 226 + w + 227][0] = {1'd0,img_data[(h * 224 + w) * 3 + offset + 0]};
        end
    end

    $fclose(img_in);
end
//------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------
//This initial block write the pixel,Layer_1 Layer_2
//------------------------------------------------------------------------------------------------------------------------------
initial begin
    #(3 * `period);
    //Layer_1
    //loading after padding file to your module
    //1 kernel and 1 bias are imported to 1 picture
    if(`Layer_1_enable) begin
        $display("--------------------------- | Layer_1 Start Simulation | ---------------------------\n");
        for(round = 0;round < `Layer_1_round_times;round = round + 1) begin
            /*reset = 1'b1;
            #(`period);
            reset = 1'b0;*/
            @(negedge clk);
            reset = 1'b1;
            #(2 * `period);
            reset = 1'b0;
            @(negedge clk);
            $display("--------------------------- | Layer_1 %02d / %02d Start Simulation | ---------------------------\n",round + 1,`Layer_1_round_times);
            //kernel import         k8 k7 k6
            //                      k5 k4 k3
            //                      k2 k1 k0
            $display("Layer_1  |  round %02d Kernel start import",round + 1);
            //PE_group_0_kernel
            kernel_0_0_8 = kernel_1_mem[0 + 108 * round];        //第一層第一個channel的左上角 28為第二層第一個channel的左上角
            kernel_0_0_7 = kernel_1_mem[1 + 108 * round];        //pircure_0_R * kernel_0
            kernel_0_0_6 = kernel_1_mem[2 + 108 * round];
            kernel_0_0_5 = kernel_1_mem[3 + 108 * round];
            kernel_0_0_4 = kernel_1_mem[4 + 108 * round];
            kernel_0_0_3 = kernel_1_mem[5 + 108 * round];
            kernel_0_0_2 = kernel_1_mem[6 + 108 * round];
            kernel_0_0_1 = kernel_1_mem[7 + 108 * round];
            kernel_0_0_0 = kernel_1_mem[8 + 108 * round];

            kernel_0_1_8 = kernel_1_mem[9 + 108 * round];        //pircure_0_G * kernel_0
            kernel_0_1_7 = kernel_1_mem[10 + 108 * round];
            kernel_0_1_6 = kernel_1_mem[11 + 108 * round];
            kernel_0_1_5 = kernel_1_mem[12 + 108 * round];
            kernel_0_1_4 = kernel_1_mem[13 + 108 * round];
            kernel_0_1_3 = kernel_1_mem[14 + 108 * round];
            kernel_0_1_2 = kernel_1_mem[15 + 108 * round];
            kernel_0_1_1 = kernel_1_mem[16 + 108 * round];
            kernel_0_1_0 = kernel_1_mem[17 + 108 * round];

            kernel_0_2_8 = kernel_1_mem[18 + 108 * round];        //pircure_0_B * kernel_0
            kernel_0_2_7 = kernel_1_mem[19 + 108 * round];
            kernel_0_2_6 = kernel_1_mem[20 + 108 * round];
            kernel_0_2_5 = kernel_1_mem[21 + 108 * round];
            kernel_0_2_4 = kernel_1_mem[22 + 108 * round];
            kernel_0_2_3 = kernel_1_mem[23 + 108 * round];
            kernel_0_2_2 = kernel_1_mem[24 + 108 * round];
            kernel_0_2_1 = kernel_1_mem[25 + 108 * round];
            kernel_0_2_0 = kernel_1_mem[26 + 108 * round];

            kernel_0_3_8 = 9'b0;
            kernel_0_3_7 = 9'b0;
            kernel_0_3_6 = 9'b0;
            kernel_0_3_5 = 9'b0;
            kernel_0_3_4 = 9'b0;
            kernel_0_3_3 = 9'b0;
            kernel_0_3_2 = 9'b0;
            kernel_0_3_1 = 9'b0;
            kernel_0_3_0 = 9'b0;

            //PE_group_1_kernel
            kernel_1_0_8 = kernel_1_mem[27 + 108 * round];       //pircure_1_R * kernel_1
            kernel_1_0_7 = kernel_1_mem[28 + 108 * round];
            kernel_1_0_6 = kernel_1_mem[29 + 108 * round];
            kernel_1_0_5 = kernel_1_mem[30 + 108 * round];
            kernel_1_0_4 = kernel_1_mem[31 + 108 * round];
            kernel_1_0_3 = kernel_1_mem[32 + 108 * round];
            kernel_1_0_2 = kernel_1_mem[33 + 108 * round];
            kernel_1_0_1 = kernel_1_mem[34 + 108 * round];
            kernel_1_0_0 = kernel_1_mem[35 + 108 * round];

            kernel_1_1_8 = kernel_1_mem[36 + 108 * round];       //pircure_1_G * kernel_1
            kernel_1_1_7 = kernel_1_mem[37 + 108 * round];
            kernel_1_1_6 = kernel_1_mem[38 + 108 * round];
            kernel_1_1_5 = kernel_1_mem[39 + 108 * round];
            kernel_1_1_4 = kernel_1_mem[40 + 108 * round];
            kernel_1_1_3 = kernel_1_mem[41 + 108 * round];
            kernel_1_1_2 = kernel_1_mem[42 + 108 * round];
            kernel_1_1_1 = kernel_1_mem[43 + 108 * round];
            kernel_1_1_0 = kernel_1_mem[44 + 108 * round];

            kernel_1_2_8 = kernel_1_mem[45 + 108 * round];       //pircure_1_B * kernel_1
            kernel_1_2_7 = kernel_1_mem[46 + 108 * round];
            kernel_1_2_6 = kernel_1_mem[47 + 108 * round];
            kernel_1_2_5 = kernel_1_mem[48 + 108 * round];
            kernel_1_2_4 = kernel_1_mem[49 + 108 * round];
            kernel_1_2_3 = kernel_1_mem[50 + 108 * round];
            kernel_1_2_2 = kernel_1_mem[51 + 108 * round];
            kernel_1_2_1 = kernel_1_mem[52 + 108 * round];
            kernel_1_2_0 = kernel_1_mem[53 + 108 * round];

            kernel_1_3_8 = 9'b0;
            kernel_1_3_7 = 9'b0;
            kernel_1_3_6 = 9'b0;
            kernel_1_3_5 = 9'b0;
            kernel_1_3_4 = 9'b0;
            kernel_1_3_3 = 9'b0;
            kernel_1_3_2 = 9'b0;
            kernel_1_3_1 = 9'b0;
            kernel_1_3_0 = 9'b0;

            //PE_group_2_kernel
            kernel_2_0_8 = kernel_1_mem[54 + 108 * round];       //pircure_2_R * kernel_2
            kernel_2_0_7 = kernel_1_mem[55 + 108 * round];
            kernel_2_0_6 = kernel_1_mem[56 + 108 * round];
            kernel_2_0_5 = kernel_1_mem[57 + 108 * round];
            kernel_2_0_4 = kernel_1_mem[58 + 108 * round];
            kernel_2_0_3 = kernel_1_mem[59 + 108 * round];
            kernel_2_0_2 = kernel_1_mem[60 + 108 * round];
            kernel_2_0_1 = kernel_1_mem[61 + 108 * round];
            kernel_2_0_0 = kernel_1_mem[62 + 108 * round];

            kernel_2_1_8 = kernel_1_mem[63 + 108 * round];       //pircure_2_G * kernel_2
            kernel_2_1_7 = kernel_1_mem[64 + 108 * round];
            kernel_2_1_6 = kernel_1_mem[65 + 108 * round];
            kernel_2_1_5 = kernel_1_mem[66 + 108 * round];
            kernel_2_1_4 = kernel_1_mem[67 + 108 * round];
            kernel_2_1_3 = kernel_1_mem[68 + 108 * round];
            kernel_2_1_2 = kernel_1_mem[69 + 108 * round];
            kernel_2_1_1 = kernel_1_mem[70 + 108 * round];
            kernel_2_1_0 = kernel_1_mem[71 + 108 * round];

            kernel_2_2_8 = kernel_1_mem[72 + 108 * round];        //pircure_2_G * kernel_2
            kernel_2_2_7 = kernel_1_mem[73 + 108 * round];
            kernel_2_2_6 = kernel_1_mem[74 + 108 * round];
            kernel_2_2_5 = kernel_1_mem[75 + 108 * round];
            kernel_2_2_4 = kernel_1_mem[76 + 108 * round];
            kernel_2_2_3 = kernel_1_mem[77 + 108 * round];
            kernel_2_2_2 = kernel_1_mem[78 + 108 * round];
            kernel_2_2_1 = kernel_1_mem[79 + 108 * round];
            kernel_2_2_0 = kernel_1_mem[80 + 108 * round];

            kernel_2_3_8 = 9'b0;
            kernel_2_3_7 = 9'b0;
            kernel_2_3_6 = 9'b0;
            kernel_2_3_5 = 9'b0;
            kernel_2_3_4 = 9'b0;
            kernel_2_3_3 = 9'b0;
            kernel_2_3_2 = 9'b0;
            kernel_2_3_1 = 9'b0;
            kernel_2_3_0 = 9'b0;

            //PE_group_3_kernel
            kernel_3_0_8 = kernel_1_mem[81 + 108 * round];       //pircure_3_R * kernel_3
            kernel_3_0_7 = kernel_1_mem[82 + 108 * round];
            kernel_3_0_6 = kernel_1_mem[83 + 108 * round];
            kernel_3_0_5 = kernel_1_mem[84 + 108 * round];
            kernel_3_0_4 = kernel_1_mem[85 + 108 * round];
            kernel_3_0_3 = kernel_1_mem[86 + 108 * round];
            kernel_3_0_2 = kernel_1_mem[87 + 108 * round];
            kernel_3_0_1 = kernel_1_mem[88 + 108 * round];
            kernel_3_0_0 = kernel_1_mem[89 + 108 * round];

            kernel_3_1_8 = kernel_1_mem[90 + 108 * round];        //pircure_3_G * kernel_3
            kernel_3_1_7 = kernel_1_mem[91 + 108 * round];
            kernel_3_1_6 = kernel_1_mem[92 + 108 * round];
            kernel_3_1_5 = kernel_1_mem[93 + 108 * round];
            kernel_3_1_4 = kernel_1_mem[94 + 108 * round];
            kernel_3_1_3 = kernel_1_mem[95 + 108 * round];
            kernel_3_1_2 = kernel_1_mem[96 + 108 * round];
            kernel_3_1_1 = kernel_1_mem[97 + 108 * round];
            kernel_3_1_0 = kernel_1_mem[98 + 108 * round];

            kernel_3_2_8 = kernel_1_mem[99 + 108 * round];        //pircure_3_B * kernel_3
            kernel_3_2_7 = kernel_1_mem[100 + 108 * round];
            kernel_3_2_6 = kernel_1_mem[101 + 108 * round];
            kernel_3_2_5 = kernel_1_mem[102 + 108 * round];
            kernel_3_2_4 = kernel_1_mem[103 + 108 * round];
            kernel_3_2_3 = kernel_1_mem[104 + 108 * round];
            kernel_3_2_2 = kernel_1_mem[105 + 108 * round];
            kernel_3_2_1 = kernel_1_mem[106 + 108 * round];
            kernel_3_2_0 = kernel_1_mem[107 + 108 * round];

            kernel_3_3_8 = 9'b0;
            kernel_3_3_7 = 9'b0;
            kernel_3_3_6 = 9'b0;
            kernel_3_3_5 = 9'b0;
            kernel_3_3_4 = 9'b0;
            kernel_3_3_3 = 9'b0;
            kernel_3_3_2 = 9'b0;
            kernel_3_3_1 = 9'b0;
            kernel_3_3_0 = 9'b0;
            if(`display_flag) begin
                $display("Layer_1  |  round = %0d Kernel_0_0_8 = %04h  import complete",round,kernel_0_0_8);
                $display("Layer_1  |  round = %0d Kernel_0_0_7 = %04h  import complete",round,kernel_0_0_7);
                $display("Layer_1  |  round = %0d Kernel_0_0_6 = %04h  import complete",round,kernel_0_0_6);
                $display("Layer_1  |  round = %0d Kernel_0_0_5 = %04h  import complete",round,kernel_0_0_5);
                $display("Layer_1  |  round = %0d Kernel_0_0_4 = %04h  import complete",round,kernel_0_0_4);
                $display("Layer_1  |  round = %0d Kernel_0_0_3 = %04h  import complete",round,kernel_0_0_3);
                $display("Layer_1  |  round = %0d Kernel_0_0_2 = %04h  import complete",round,kernel_0_0_2);
                $display("Layer_1  |  round = %0d Kernel_0_0_1 = %04h  import complete",round,kernel_0_0_1);
                $display("Layer_1  |  round = %0d Kernel_0_0_0 = %04h  import complete",round,kernel_0_0_0);

                $display("Layer_1  |  round = %0d Kernel_0_1_8 = %04h  import complete",round,kernel_0_1_8);
                $display("Layer_1  |  round = %0d Kernel_0_1_7 = %04h  import complete",round,kernel_0_1_7);
                $display("Layer_1  |  round = %0d Kernel_0_1_6 = %04h  import complete",round,kernel_0_1_6);
                $display("Layer_1  |  round = %0d Kernel_0_1_5 = %04h  import complete",round,kernel_0_1_5);
                $display("Layer_1  |  round = %0d Kernel_0_1_4 = %04h  import complete",round,kernel_0_1_4);
                $display("Layer_1  |  round = %0d Kernel_0_1_3 = %04h  import complete",round,kernel_0_1_3);
                $display("Layer_1  |  round = %0d Kernel_0_1_2 = %04h  import complete",round,kernel_0_1_2);
                $display("Layer_1  |  round = %0d Kernel_0_1_1 = %04h  import complete",round,kernel_0_1_1);
                $display("Layer_1  |  round = %0d Kernel_0_1_0 = %04h  import complete",round,kernel_0_1_0);

                $display("Layer_1  |  round = %0d Kernel_0_2_8 = %04h  import complete",round,kernel_0_2_8);
                $display("Layer_1  |  round = %0d Kernel_0_2_7 = %04h  import complete",round,kernel_0_2_7);
                $display("Layer_1  |  round = %0d Kernel_0_2_6 = %04h  import complete",round,kernel_0_2_6);
                $display("Layer_1  |  round = %0d Kernel_0_2_5 = %04h  import complete",round,kernel_0_2_5);
                $display("Layer_1  |  round = %0d Kernel_0_2_4 = %04h  import complete",round,kernel_0_2_4);
                $display("Layer_1  |  round = %0d Kernel_0_2_3 = %04h  import complete",round,kernel_0_2_3);
                $display("Layer_1  |  round = %0d Kernel_0_2_2 = %04h  import complete",round,kernel_0_2_2);
                $display("Layer_1  |  round = %0d Kernel_0_2_1 = %04h  import complete",round,kernel_0_2_1);
                $display("Layer_1  |  round = %0d Kernel_0_2_0 = %04h  import complete",round,kernel_0_2_0);

                $display("Layer_1  |  round = %0d Kernel_0_3_8 = %04h  import complete",round,kernel_0_3_8);
                $display("Layer_1  |  round = %0d Kernel_0_3_7 = %04h  import complete",round,kernel_0_3_7);
                $display("Layer_1  |  round = %0d Kernel_0_3_6 = %04h  import complete",round,kernel_0_3_6);
                $display("Layer_1  |  round = %0d Kernel_0_3_5 = %04h  import complete",round,kernel_0_3_5);
                $display("Layer_1  |  round = %0d Kernel_0_3_4 = %04h  import complete",round,kernel_0_3_4);
                $display("Layer_1  |  round = %0d Kernel_0_3_3 = %04h  import complete",round,kernel_0_3_3);
                $display("Layer_1  |  round = %0d Kernel_0_3_2 = %04h  import complete",round,kernel_0_3_2);
                $display("Layer_1  |  round = %0d Kernel_0_3_1 = %04h  import complete",round,kernel_0_3_1);
                $display("Layer_1  |  round = %0d Kernel_0_3_0 = %04h  import complete",round,kernel_0_3_0);

                $display("Layer_1  |  round = %0d Kernel_1_0_8 = %04h  import complete",round,kernel_1_0_8);
                $display("Layer_1  |  round = %0d Kernel_1_0_7 = %04h  import complete",round,kernel_1_0_7);
                $display("Layer_1  |  round = %0d Kernel_1_0_6 = %04h  import complete",round,kernel_1_0_6);
                $display("Layer_1  |  round = %0d Kernel_1_0_5 = %04h  import complete",round,kernel_1_0_5);
                $display("Layer_1  |  round = %0d Kernel_1_0_4 = %04h  import complete",round,kernel_1_0_4);
                $display("Layer_1  |  round = %0d Kernel_1_0_3 = %04h  import complete",round,kernel_1_0_3);
                $display("Layer_1  |  round = %0d Kernel_1_0_2 = %04h  import complete",round,kernel_1_0_2);
                $display("Layer_1  |  round = %0d Kernel_1_0_1 = %04h  import complete",round,kernel_1_0_1);
                $display("Layer_1  |  round = %0d Kernel_1_0_0 = %04h  import complete",round,kernel_1_0_0);

                $display("Layer_1  |  round = %0d Kernel_1_1_8 = %04h  import complete",round,kernel_1_1_8);
                $display("Layer_1  |  round = %0d Kernel_1_1_7 = %04h  import complete",round,kernel_1_1_7);
                $display("Layer_1  |  round = %0d Kernel_1_1_6 = %04h  import complete",round,kernel_1_1_6);
                $display("Layer_1  |  round = %0d Kernel_1_1_5 = %04h  import complete",round,kernel_1_1_5);
                $display("Layer_1  |  round = %0d Kernel_1_1_4 = %04h  import complete",round,kernel_1_1_4);
                $display("Layer_1  |  round = %0d Kernel_1_1_3 = %04h  import complete",round,kernel_1_1_3);
                $display("Layer_1  |  round = %0d Kernel_1_1_2 = %04h  import complete",round,kernel_1_1_2);
                $display("Layer_1  |  round = %0d Kernel_1_1_1 = %04h  import complete",round,kernel_1_1_1);
                $display("Layer_1  |  round = %0d Kernel_1_1_0 = %04h  import complete",round,kernel_1_1_0);

                $display("Layer_1  |  round = %0d Kernel_1_2_8 = %04h  import complete",round,kernel_1_2_8);
                $display("Layer_1  |  round = %0d Kernel_1_2_7 = %04h  import complete",round,kernel_1_2_7);
                $display("Layer_1  |  round = %0d Kernel_1_2_6 = %04h  import complete",round,kernel_1_2_6);
                $display("Layer_1  |  round = %0d Kernel_1_2_5 = %04h  import complete",round,kernel_1_2_5);
                $display("Layer_1  |  round = %0d Kernel_1_2_4 = %04h  import complete",round,kernel_1_2_4);
                $display("Layer_1  |  round = %0d Kernel_1_2_3 = %04h  import complete",round,kernel_1_2_3);
                $display("Layer_1  |  round = %0d Kernel_1_2_2 = %04h  import complete",round,kernel_1_2_2);
                $display("Layer_1  |  round = %0d Kernel_1_2_1 = %04h  import complete",round,kernel_1_2_1);
                $display("Layer_1  |  round = %0d Kernel_1_2_0 = %04h  import complete",round,kernel_1_2_0);

                $display("Layer_1  |  round = %0d Kernel_1_3_8 = %04h  import complete",round,kernel_1_3_8);
                $display("Layer_1  |  round = %0d Kernel_1_3_7 = %04h  import complete",round,kernel_1_3_7);
                $display("Layer_1  |  round = %0d Kernel_1_3_6 = %04h  import complete",round,kernel_1_3_6);
                $display("Layer_1  |  round = %0d Kernel_1_3_5 = %04h  import complete",round,kernel_1_3_5);
                $display("Layer_1  |  round = %0d Kernel_1_3_4 = %04h  import complete",round,kernel_1_3_4);
                $display("Layer_1  |  round = %0d Kernel_1_3_3 = %04h  import complete",round,kernel_1_3_3);
                $display("Layer_1  |  round = %0d Kernel_1_3_2 = %04h  import complete",round,kernel_1_3_2);
                $display("Layer_1  |  round = %0d Kernel_1_3_1 = %04h  import complete",round,kernel_1_3_1);
                $display("Layer_1  |  round = %0d Kernel_1_3_0 = %04h  import complete",round,kernel_1_3_0);

                $display("Layer_1  |  round = %0d Kernel_2_0_8 = %04h  import complete",round,kernel_2_0_8);
                $display("Layer_1  |  round = %0d Kernel_2_0_7 = %04h  import complete",round,kernel_2_0_7);
                $display("Layer_1  |  round = %0d Kernel_2_0_6 = %04h  import complete",round,kernel_2_0_6);
                $display("Layer_1  |  round = %0d Kernel_2_0_5 = %04h  import complete",round,kernel_2_0_5);
                $display("Layer_1  |  round = %0d Kernel_2_0_4 = %04h  import complete",round,kernel_2_0_4);
                $display("Layer_1  |  round = %0d Kernel_2_0_3 = %04h  import complete",round,kernel_2_0_3);
                $display("Layer_1  |  round = %0d Kernel_2_0_2 = %04h  import complete",round,kernel_2_0_2);
                $display("Layer_1  |  round = %0d Kernel_2_0_1 = %04h  import complete",round,kernel_2_0_1);
                $display("Layer_1  |  round = %0d Kernel_2_0_0 = %04h  import complete",round,kernel_2_0_0);

                $display("Layer_1  |  round = %0d Kernel_2_1_8 = %04h  import complete",round,kernel_2_1_8);
                $display("Layer_1  |  round = %0d Kernel_2_1_7 = %04h  import complete",round,kernel_2_1_7);
                $display("Layer_1  |  round = %0d Kernel_2_1_6 = %04h  import complete",round,kernel_2_1_6);
                $display("Layer_1  |  round = %0d Kernel_2_1_5 = %04h  import complete",round,kernel_2_1_5);
                $display("Layer_1  |  round = %0d Kernel_2_1_4 = %04h  import complete",round,kernel_2_1_4);
                $display("Layer_1  |  round = %0d Kernel_2_1_3 = %04h  import complete",round,kernel_2_1_3);
                $display("Layer_1  |  round = %0d Kernel_2_1_2 = %04h  import complete",round,kernel_2_1_2);
                $display("Layer_1  |  round = %0d Kernel_2_1_1 = %04h  import complete",round,kernel_2_1_1);
                $display("Layer_1  |  round = %0d Kernel_2_1_0 = %04h  import complete",round,kernel_2_1_0);

                $display("Layer_1  |  round = %0d Kernel_2_2_8 = %04h  import complete",round,kernel_2_2_8);
                $display("Layer_1  |  round = %0d Kernel_2_2_7 = %04h  import complete",round,kernel_2_2_7);
                $display("Layer_1  |  round = %0d Kernel_2_2_6 = %04h  import complete",round,kernel_2_2_6);
                $display("Layer_1  |  round = %0d Kernel_2_2_5 = %04h  import complete",round,kernel_2_2_5);
                $display("Layer_1  |  round = %0d Kernel_2_2_4 = %04h  import complete",round,kernel_2_2_4);
                $display("Layer_1  |  round = %0d Kernel_2_2_3 = %04h  import complete",round,kernel_2_2_3);
                $display("Layer_1  |  round = %0d Kernel_2_2_2 = %04h  import complete",round,kernel_2_2_2);
                $display("Layer_1  |  round = %0d Kernel_2_2_1 = %04h  import complete",round,kernel_2_2_1);
                $display("Layer_1  |  round = %0d Kernel_2_2_0 = %04h  import complete",round,kernel_2_2_0);

                $display("Layer_1  |  round = %0d Kernel_2_3_8 = %04h  import complete",round,kernel_2_3_8);
                $display("Layer_1  |  round = %0d Kernel_2_3_7 = %04h  import complete",round,kernel_2_3_7);
                $display("Layer_1  |  round = %0d Kernel_2_3_6 = %04h  import complete",round,kernel_2_3_6);
                $display("Layer_1  |  round = %0d Kernel_2_3_5 = %04h  import complete",round,kernel_2_3_5);
                $display("Layer_1  |  round = %0d Kernel_2_3_4 = %04h  import complete",round,kernel_2_3_4);
                $display("Layer_1  |  round = %0d Kernel_2_3_3 = %04h  import complete",round,kernel_2_3_3);
                $display("Layer_1  |  round = %0d Kernel_2_3_2 = %04h  import complete",round,kernel_2_3_2);
                $display("Layer_1  |  round = %0d Kernel_2_3_1 = %04h  import complete",round,kernel_2_3_1);
                $display("Layer_1  |  round = %0d Kernel_2_3_0 = %04h  import complete",round,kernel_2_3_0);

                $display("Layer_1  |  round = %0d Kernel_3_0_8 = %04h  import complete",round,kernel_3_0_8);
                $display("Layer_1  |  round = %0d Kernel_3_0_7 = %04h  import complete",round,kernel_3_0_7);
                $display("Layer_1  |  round = %0d Kernel_3_0_6 = %04h  import complete",round,kernel_3_0_6);
                $display("Layer_1  |  round = %0d Kernel_3_0_5 = %04h  import complete",round,kernel_3_0_5);
                $display("Layer_1  |  round = %0d Kernel_3_0_4 = %04h  import complete",round,kernel_3_0_4);
                $display("Layer_1  |  round = %0d Kernel_3_0_3 = %04h  import complete",round,kernel_3_0_3);
                $display("Layer_1  |  round = %0d Kernel_3_0_2 = %04h  import complete",round,kernel_3_0_2);
                $display("Layer_1  |  round = %0d Kernel_3_0_1 = %04h  import complete",round,kernel_3_0_1);
                $display("Layer_1  |  round = %0d Kernel_3_0_0 = %04h  import complete",round,kernel_3_0_0);

                $display("Layer_1  |  round = %0d Kernel_3_1_8 = %04h  import complete",round,kernel_3_1_8);
                $display("Layer_1  |  round = %0d Kernel_3_1_7 = %04h  import complete",round,kernel_3_1_7);
                $display("Layer_1  |  round = %0d Kernel_3_1_6 = %04h  import complete",round,kernel_3_1_6);
                $display("Layer_1  |  round = %0d Kernel_3_1_5 = %04h  import complete",round,kernel_3_1_5);
                $display("Layer_1  |  round = %0d Kernel_3_1_4 = %04h  import complete",round,kernel_3_1_4);
                $display("Layer_1  |  round = %0d Kernel_3_1_3 = %04h  import complete",round,kernel_3_1_3);
                $display("Layer_1  |  round = %0d Kernel_3_1_2 = %04h  import complete",round,kernel_3_1_2);
                $display("Layer_1  |  round = %0d Kernel_3_1_1 = %04h  import complete",round,kernel_3_1_1);
                $display("Layer_1  |  round = %0d Kernel_3_1_0 = %04h  import complete",round,kernel_3_1_0);

                $display("Layer_1  |  round = %0d Kernel_3_2_8 = %04h  import complete",round,kernel_3_2_8);
                $display("Layer_1  |  round = %0d Kernel_3_2_7 = %04h  import complete",round,kernel_3_2_7);
                $display("Layer_1  |  round = %0d Kernel_3_2_6 = %04h  import complete",round,kernel_3_2_6);
                $display("Layer_1  |  round = %0d Kernel_3_2_5 = %04h  import complete",round,kernel_3_2_5);
                $display("Layer_1  |  round = %0d Kernel_3_2_4 = %04h  import complete",round,kernel_3_2_4);
                $display("Layer_1  |  round = %0d Kernel_3_2_3 = %04h  import complete",round,kernel_3_2_3);
                $display("Layer_1  |  round = %0d Kernel_3_3_2 = %04h  import complete",round,kernel_3_2_2);
                $display("Layer_1  |  round = %0d Kernel_3_2_1 = %04h  import complete",round,kernel_3_2_1);
                $display("Layer_1  |  round = %0d Kernel_3_2_0 = %04h  import complete",round,kernel_3_2_0);

                $display("Layer_1  |  round = %0d Kernel_3_3_8 = %04h  import complete",round,kernel_3_3_8);
                $display("Layer_1  |  round = %0d Kernel_3_3_7 = %04h  import complete",round,kernel_3_3_7);
                $display("Layer_1  |  round = %0d Kernel_3_3_6 = %04h  import complete",round,kernel_3_3_6);
                $display("Layer_1  |  round = %0d Kernel_3_3_5 = %04h  import complete",round,kernel_3_3_5);
                $display("Layer_1  |  round = %0d Kernel_3_3_4 = %04h  import complete",round,kernel_3_3_4);
                $display("Layer_1  |  round = %0d Kernel_3_3_3 = %04h  import complete",round,kernel_3_3_3);
                $display("Layer_1  |  round = %0d Kernel_3_3_2 = %04h  import complete",round,kernel_3_3_2);
                $display("Layer_1  |  round = %0d Kernel_3_3_1 = %04h  import complete",round,kernel_3_3_1);
                $display("Layer_1  |  round = %0d Kernel_3_3_0 = %04h  import complete",round,kernel_3_3_0);
            end
            $display("Layer_1  |  round %02d Kernel import complete\n",round + 1);

            //bias import
            bias_0 = bias_1_mem[0 + 4 * round];
            bias_1 = bias_1_mem[1 + 4 * round];
            bias_2 = bias_1_mem[2 + 4 * round];
            bias_3 = bias_1_mem[3 + 4 * round];
            $display("Layer_1  |  round %02d bias start import",round + 1);
            $display("Layer_1  |  round %02d bias_0 = %04h import complete ",round + 1,bias_0);
            $display("Layer_1  |  round %02d bias_1 = %04h import complete ",round + 1,bias_1);
            $display("Layer_1  |  round %02d bias_2 = %04h import complete ",round + 1,bias_2);
            $display("Layer_1  |  round %02d bias_3 = %04h import complete ",round + 1,bias_3);
            $display("Layer_1  |  round %02d bias import complete\n",round + 1);

            Layer_1_pixel_0 = 0;
            Layer_1_pixel_1 = 0;
            Layer_1_pixel_2 = 0;
            Layer_1_pixel_3 = 0;
            Layer_1_img_0_bytes = 0;
            Layer_1_img_1_bytes = 0;
            Layer_1_img_2_bytes = 0;
            Layer_1_img_3_bytes = 0;
            row_0 = 0;
            row_1 = 0;
            row_2 = 0;
            row_3 = 0;
            col_0 = 0;
            col_1 = 0;
            col_2 = 0;
            col_3 = 0;

            $display("Layer_1  |  round %02d Start to write pixel",round + 1);
            for(idx = 0; idx < `padding_img_size; idx = idx+1) begin
                //data_in import
                data_in_0 <= {1'b0,padding_img[idx][2]};
                data_in_1 <= {1'b0,padding_img[idx][1]};
                data_in_2 <= {1'b0,padding_img[idx][0]};
                data_in_3 <= 9'b0;

                @(posedge clk);
                #1;

                //CA_sum     CA_sum_0 = AT_sum = AT_sum_0 + AT_sum_1 + AT_sum_2 + AT_sum_3
                CA_sum_0_[0] = AT_sum_0;
                CA_sum_1_[0] = AT_sum_1;
                CA_sum_2_[0] = AT_sum_2;
                CA_sum_3_[0] = AT_sum_3;

                pixel_out_0 = ReLU_result_0[13:6];
                pixel_out_1 = ReLU_result_1[12:5];
                pixel_out_2 = ReLU_result_2[12:5];
                pixel_out_3 = ReLU_result_3[13:6];

                //-------------------------------------------------------------
                //Write output data to output file here
                //---------------------------------------------------------------
                if(valid_singal_0) begin
                    //確保每個像素在檔案中都佔據 24-bit (3 Bytes)，強制讓輸出的圖片變成「看起來像灰階的彩色圖」。
                    //fwrite會有循序寫入特性，不需要idx來指定位置
                    $fwrite(Layer_1_img[0 + 4 * round],"%c%c%c",pixel_out_0,pixel_out_0,pixel_out_0);
                    Layer_1_img_0_bytes = Layer_1_img_0_bytes + 3;
                    Layer_1_padding_img [(row_0 + 1) * 226 + (col_0 + 1)][0 + 4 * round] = pixel_out_0;
                    col_0 = col_0 + 1;
                    if(col_0 == 224) begin
                        col_0 = 0;
                        row_0 = row_0 + 1;
                    end
                    if((Layer_1_pixel_0 != 0) & (Layer_1_pixel_0 % 5000) == 0) begin
                        $display("Layer_1  |  round %02d Img_%02d,Img_%02d,Img_%02d,Img_%02d has been writen %02d000/50176 pixel",round + 1,(1 + 4 * round),(2 + 4 * round),(3 + 4 * round),(4 + 4 * round),(Layer_1_pixel_0 / 5000) * 5);
                    end
                    Layer_1_pixel_0 = Layer_1_pixel_0 + 1;
                end

                if(valid_singal_1) begin
                    $fwrite(Layer_1_img[1 + 4 * round],"%c%c%c",pixel_out_1,pixel_out_1,pixel_out_1);
                    Layer_1_img_1_bytes = Layer_1_img_1_bytes + 3;
                    Layer_1_padding_img [(row_1 + 1) * 226 + (col_1 + 1)][1 + 4 * round] = pixel_out_1;
                    col_1 = col_1 + 1;
                    if(col_1 == 224) begin
                        col_1 = 0;
                        row_1 = row_1 + 1;
                    end
                    Layer_1_pixel_1 = Layer_1_pixel_1 + 1;
                end

                if(valid_singal_2) begin
                    $fwrite(Layer_1_img[2 + 4 * round],"%c%c%c",pixel_out_2,pixel_out_2,pixel_out_2);
                    Layer_1_img_2_bytes = Layer_1_img_2_bytes + 3;
                    Layer_1_padding_img [(row_2 + 1) * 226 + (col_2 + 1)][2 + 4 * round] = pixel_out_2;
                    col_2 = col_2 + 1;
                    if(col_2 == 224) begin
                        col_2 = 0;
                        row_2 = row_2 + 1;
                    end
                    Layer_1_pixel_2 = Layer_1_pixel_2 + 1;
                end

                if(valid_singal_3) begin
                    $fwrite(Layer_1_img[3 + 4 * round],"%c%c%c",pixel_out_3,pixel_out_3,pixel_out_3);
                    Layer_1_img_3_bytes = Layer_1_img_3_bytes + 3;
                    Layer_1_padding_img [(row_3 + 1) * 226 + (col_3 + 1)][3 + 4 * round] = pixel_out_3;
                    col_3 = col_3 + 1;
                    if(col_3 == 224) begin
                        col_3 = 0;
                        row_3 = row_3 + 1;
                    end
                    Layer_1_pixel_3 = Layer_1_pixel_3 + 1;
                end
            end
            $display("Layer_1  |  round %02d Write pixel complete",round + 1);

            Layer_1_img_bytes_mem[0 + 4 * round] = Layer_1_img_0_bytes + 54;
            Layer_1_img_bytes_mem[1 + 4 * round] = Layer_1_img_1_bytes + 54;
            Layer_1_img_bytes_mem[2 + 4 * round] = Layer_1_img_2_bytes + 54;
            Layer_1_img_bytes_mem[3 + 4 * round] = Layer_1_img_3_bytes + 54;

            Layer_1_pixel_mem[0 + 4 * round] = Layer_1_pixel_0;
            Layer_1_pixel_mem[1 + 4 * round] = Layer_1_pixel_1;
            Layer_1_pixel_mem[2 + 4 * round] = Layer_1_pixel_2;
            Layer_1_pixel_mem[3 + 4 * round] = Layer_1_pixel_3;

            $display("\n--------------------------- | Layer_1 %02d / %02d  End  Simulation | ---------------------------\n",round + 1,`Layer_1_round_times);
        end
        $display("--------------------------- |  Layer_1 End Simulation  | ---------------------------");

    end

    //Layer_2
    if(`Layer_2_enable) begin
        $display("\n--------------------------- | Layer_2 Start Simulation | ---------------------------\n");
        for(round = 0;round < `Layer_2_round_times;round = round + 1) begin
            $display("--------------------------- | Layer_2 %02d / %02d Start Simulation | ---------------------------\n",round + 1,`Layer_2_round_times);
            @(negedge clk);
            reset = 1'b1;
            #(2 * `period);
            reset = 1'b0;
            @(negedge clk);
            //bias import
            bias_0 = bias_2_mem[0 + 4 * round];
            bias_1 = bias_2_mem[1 + 4 * round];
            bias_2 = bias_2_mem[2 + 4 * round];
            bias_3 = bias_2_mem[3 + 4 * round];
            $display("Layer_2  |  round %02d bias start import",round + 1);
            $display("Layer_2  |  round %02d bias_0 = %04h import complete ",round + 1,bias_0);
            $display("Layer_2  |  round %02d bias_1 = %04h import complete ",round + 1,bias_1);
            $display("Layer_2  |  round %02d bias_2 = %04h import complete ",round + 1,bias_2);
            $display("Layer_2  |  round %02d bias_3 = %04h import complete ",round + 1,bias_3);
            $display("Layer_2  |  round %02d bias import complete\n",round + 1);

            for(i = 0;i < 16;i = i +1) begin
                CA_sum_0_[i] = 36'b0;   //channel
                CA_sum_1_[i] = 36'b0;
                CA_sum_2_[i] = 36'b0;
                CA_sum_3_[i] = 36'b0;
            end

            //kernel import         k8 k7 k6
            //                      k5 k4 k3
            //                      k2 k1 k0
            for(Layer_2_kernel_round = 0;Layer_2_kernel_round < 16;Layer_2_kernel_round = Layer_2_kernel_round + 1) begin
                @(negedge clk);
                reset = 1'b1;
                #(2 * `period);
                reset = 1'b0;
                @(negedge clk);
                $display("\nLayer_2  |  round %02d Layer_2_kernel_round %02d Kernel start import",round + 1,Layer_2_kernel_round);
                //PE_group_0_kernel
                kernel_0_0_8 = kernel_2_mem[0 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];        //第一層第一個channel的左上角 28為第二層第一個channel的左上角
                kernel_0_0_7 = kernel_2_mem[1 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_6 = kernel_2_mem[2 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_5 = kernel_2_mem[3 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_4 = kernel_2_mem[4 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_3 = kernel_2_mem[5 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_2 = kernel_2_mem[6 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_1 = kernel_2_mem[7 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_0_0 = kernel_2_mem[8 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];

                kernel_0_1_8 = kernel_2_mem[9 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_7 = kernel_2_mem[10 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_6 = kernel_2_mem[11 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_5 = kernel_2_mem[12 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_4 = kernel_2_mem[13 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_3 = kernel_2_mem[14 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_2 = kernel_2_mem[15 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_1 = kernel_2_mem[16 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_1_0 = kernel_2_mem[17 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];

                kernel_0_2_8 = kernel_2_mem[18 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_7 = kernel_2_mem[19 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_6 = kernel_2_mem[20 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_5 = kernel_2_mem[21 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_4 = kernel_2_mem[22 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_3 = kernel_2_mem[23 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_2 = kernel_2_mem[24 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_1 = kernel_2_mem[25 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_2_0 = kernel_2_mem[26 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];

                kernel_0_3_8 = kernel_2_mem[27 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_7 = kernel_2_mem[28 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_6 = kernel_2_mem[29 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_5 = kernel_2_mem[30 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_4 = kernel_2_mem[31 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_3 = kernel_2_mem[32 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_2 = kernel_2_mem[33 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_1 = kernel_2_mem[34 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];
                kernel_0_3_0 = kernel_2_mem[35 + 36 * Layer_2_kernel_round + 576 * (4 * round + 0)];

                //PE_group_1_kernel
                kernel_1_0_8 = kernel_2_mem[0 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_7 = kernel_2_mem[1 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_6 = kernel_2_mem[2 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_5 = kernel_2_mem[3 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_4 = kernel_2_mem[4 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_3 = kernel_2_mem[5 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_2 = kernel_2_mem[6 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_1 = kernel_2_mem[7 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_0_0 = kernel_2_mem[8 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];

                kernel_1_1_8 = kernel_2_mem[9 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_7 = kernel_2_mem[10 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_6 = kernel_2_mem[11 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_5 = kernel_2_mem[12 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_4 = kernel_2_mem[13 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_3 = kernel_2_mem[14 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_2 = kernel_2_mem[15 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_1 = kernel_2_mem[16 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_1_0 = kernel_2_mem[17 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];

                kernel_1_2_8 = kernel_2_mem[18 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_7 = kernel_2_mem[19 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_6 = kernel_2_mem[20 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_5 = kernel_2_mem[21 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_4 = kernel_2_mem[22 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_3 = kernel_2_mem[23 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_2 = kernel_2_mem[24 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_1 = kernel_2_mem[25 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_2_0 = kernel_2_mem[26 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];

                kernel_1_3_8 = kernel_2_mem[27 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_7 = kernel_2_mem[28 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_6 = kernel_2_mem[29 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_5 = kernel_2_mem[30 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_4 = kernel_2_mem[31 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_3 = kernel_2_mem[32 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_2 = kernel_2_mem[33 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_1 = kernel_2_mem[34 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];
                kernel_1_3_0 = kernel_2_mem[35 + 36 * Layer_2_kernel_round + 576 * (4 * round + 1)];

                //PE_group_2_kernel
                kernel_2_0_8 = kernel_2_mem[0 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];        //第一層第一個channel的左上角 28為第二層第一個channel的左上角
                kernel_2_0_7 = kernel_2_mem[1 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_6 = kernel_2_mem[2 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_5 = kernel_2_mem[3 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_4 = kernel_2_mem[4 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_3 = kernel_2_mem[5 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_2 = kernel_2_mem[6 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_1 = kernel_2_mem[7 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_0_0 = kernel_2_mem[8 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];

                kernel_2_1_8 = kernel_2_mem[9 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_7 = kernel_2_mem[10 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_6 = kernel_2_mem[11 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_5 = kernel_2_mem[12 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_4 = kernel_2_mem[13 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_3 = kernel_2_mem[14 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_2 = kernel_2_mem[15 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_1 = kernel_2_mem[16 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_1_0 = kernel_2_mem[17 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];

                kernel_2_2_8 = kernel_2_mem[18 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_7 = kernel_2_mem[19 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_6 = kernel_2_mem[20 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_5 = kernel_2_mem[21 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_4 = kernel_2_mem[22 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_3 = kernel_2_mem[23 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_2 = kernel_2_mem[24 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_1 = kernel_2_mem[25 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_2_0 = kernel_2_mem[26 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];

                kernel_2_3_8 = kernel_2_mem[27 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_7 = kernel_2_mem[28 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_6 = kernel_2_mem[29 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_5 = kernel_2_mem[30 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_4 = kernel_2_mem[31 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_3 = kernel_2_mem[32 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_2 = kernel_2_mem[33 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_1 = kernel_2_mem[34 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];
                kernel_2_3_0 = kernel_2_mem[35 + 36 * Layer_2_kernel_round + 576 * (4 * round + 2)];

                //PE_group_3_kernel
                kernel_3_0_8 = kernel_2_mem[0 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];        //第一層第一個channel的左上角 28為第二層第一個channel的左上角
                kernel_3_0_7 = kernel_2_mem[1 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_6 = kernel_2_mem[2 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_5 = kernel_2_mem[3 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_4 = kernel_2_mem[4 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_3 = kernel_2_mem[5 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_2 = kernel_2_mem[6 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_1 = kernel_2_mem[7 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_0_0 = kernel_2_mem[8 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];

                kernel_3_1_8 = kernel_2_mem[9 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_7 = kernel_2_mem[10 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_6 = kernel_2_mem[11 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_5 = kernel_2_mem[12 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_4 = kernel_2_mem[13 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_3 = kernel_2_mem[14 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_2 = kernel_2_mem[15 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_1 = kernel_2_mem[16 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_1_0 = kernel_2_mem[17 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];

                kernel_3_2_8 = kernel_2_mem[18 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_7 = kernel_2_mem[19 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_6 = kernel_2_mem[20 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_5 = kernel_2_mem[21 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_4 = kernel_2_mem[22 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_3 = kernel_2_mem[23 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_2 = kernel_2_mem[24 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_1 = kernel_2_mem[25 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_2_0 = kernel_2_mem[26 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];

                kernel_3_3_8 = kernel_2_mem[27 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_7 = kernel_2_mem[28 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_6 = kernel_2_mem[29 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_5 = kernel_2_mem[30 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_4 = kernel_2_mem[31 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_3 = kernel_2_mem[32 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_2 = kernel_2_mem[33 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_1 = kernel_2_mem[34 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];
                kernel_3_3_0 = kernel_2_mem[35 + 36 * Layer_2_kernel_round + 576 * (4 * round + 3)];

                if(`display_flag) begin
                    $display("Layer_2  |  round = %0d Kernel_0_0_8 = %04h  import complete",round,kernel_0_0_8);
                    $display("Layer_2  |  round = %0d Kernel_0_0_7 = %04h  import complete",round,kernel_0_0_7);
                    $display("Layer_2  |  round = %0d Kernel_0_0_6 = %04h  import complete",round,kernel_0_0_6);
                    $display("Layer_2  |  round = %0d Kernel_0_0_5 = %04h  import complete",round,kernel_0_0_5);
                    $display("Layer_2  |  round = %0d Kernel_0_0_4 = %04h  import complete",round,kernel_0_0_4);
                    $display("Layer_2  |  round = %0d Kernel_0_0_3 = %04h  import complete",round,kernel_0_0_3);
                    $display("Layer_2  |  round = %0d Kernel_0_0_2 = %04h  import complete",round,kernel_0_0_2);
                    $display("Layer_2  |  round = %0d Kernel_0_0_1 = %04h  import complete",round,kernel_0_0_1);
                    $display("Layer_2  |  round = %0d Kernel_0_0_0 = %04h  import complete",round,kernel_0_0_0);

                    $display("Layer_2  |  round = %0d Kernel_0_1_8 = %04h  import complete",round,kernel_0_1_8);
                    $display("Layer_2  |  round = %0d Kernel_0_1_7 = %04h  import complete",round,kernel_0_1_7);
                    $display("Layer_2  |  round = %0d Kernel_0_1_6 = %04h  import complete",round,kernel_0_1_6);
                    $display("Layer_2  |  round = %0d Kernel_0_1_5 = %04h  import complete",round,kernel_0_1_5);
                    $display("Layer_2  |  round = %0d Kernel_0_1_4 = %04h  import complete",round,kernel_0_1_4);
                    $display("Layer_2  |  round = %0d Kernel_0_1_3 = %04h  import complete",round,kernel_0_1_3);
                    $display("Layer_2  |  round = %0d Kernel_0_1_2 = %04h  import complete",round,kernel_0_1_2);
                    $display("Layer_2  |  round = %0d Kernel_0_1_1 = %04h  import complete",round,kernel_0_1_1);
                    $display("Layer_2  |  round = %0d Kernel_0_1_0 = %04h  import complete",round,kernel_0_1_0);

                    $display("Layer_2  |  round = %0d Kernel_0_2_8 = %04h  import complete",round,kernel_0_2_8);
                    $display("Layer_2  |  round = %0d Kernel_0_2_7 = %04h  import complete",round,kernel_0_2_7);
                    $display("Layer_2  |  round = %0d Kernel_0_2_6 = %04h  import complete",round,kernel_0_2_6);
                    $display("Layer_2  |  round = %0d Kernel_0_2_5 = %04h  import complete",round,kernel_0_2_5);
                    $display("Layer_2  |  round = %0d Kernel_0_2_4 = %04h  import complete",round,kernel_0_2_4);
                    $display("Layer_2  |  round = %0d Kernel_0_2_3 = %04h  import complete",round,kernel_0_2_3);
                    $display("Layer_2  |  round = %0d Kernel_0_2_2 = %04h  import complete",round,kernel_0_2_2);
                    $display("Layer_2  |  round = %0d Kernel_0_2_1 = %04h  import complete",round,kernel_0_2_1);
                    $display("Layer_2  |  round = %0d Kernel_0_2_0 = %04h  import complete",round,kernel_0_2_0);

                    $display("Layer_2  |  round = %0d Kernel_0_3_8 = %04h  import complete",round,kernel_0_3_8);
                    $display("Layer_2  |  round = %0d Kernel_0_3_7 = %04h  import complete",round,kernel_0_3_7);
                    $display("Layer_2  |  round = %0d Kernel_0_3_6 = %04h  import complete",round,kernel_0_3_6);
                    $display("Layer_2  |  round = %0d Kernel_0_3_5 = %04h  import complete",round,kernel_0_3_5);
                    $display("Layer_2  |  round = %0d Kernel_0_3_4 = %04h  import complete",round,kernel_0_3_4);
                    $display("Layer_2  |  round = %0d Kernel_0_3_3 = %04h  import complete",round,kernel_0_3_3);
                    $display("Layer_2  |  round = %0d Kernel_0_3_2 = %04h  import complete",round,kernel_0_3_2);
                    $display("Layer_2  |  round = %0d Kernel_0_3_1 = %04h  import complete",round,kernel_0_3_1);
                    $display("Layer_2  |  round = %0d Kernel_0_3_0 = %04h  import complete",round,kernel_0_3_0);

                    $display("Layer_2  |  round = %0d Kernel_1_0_8 = %04h  import complete",round,kernel_1_0_8);
                    $display("Layer_2  |  round = %0d Kernel_1_0_7 = %04h  import complete",round,kernel_1_0_7);
                    $display("Layer_2  |  round = %0d Kernel_1_0_6 = %04h  import complete",round,kernel_1_0_6);
                    $display("Layer_2  |  round = %0d Kernel_1_0_5 = %04h  import complete",round,kernel_1_0_5);
                    $display("Layer_2  |  round = %0d Kernel_1_0_4 = %04h  import complete",round,kernel_1_0_4);
                    $display("Layer_2  |  round = %0d Kernel_1_0_3 = %04h  import complete",round,kernel_1_0_3);
                    $display("Layer_2  |  round = %0d Kernel_1_0_2 = %04h  import complete",round,kernel_1_0_2);
                    $display("Layer_2  |  round = %0d Kernel_1_0_1 = %04h  import complete",round,kernel_1_0_1);
                    $display("Layer_2  |  round = %0d Kernel_1_0_0 = %04h  import complete",round,kernel_1_0_0);

                    $display("Layer_2  |  round = %0d Kernel_1_1_8 = %04h  import complete",round,kernel_1_1_8);
                    $display("Layer_2  |  round = %0d Kernel_1_1_7 = %04h  import complete",round,kernel_1_1_7);
                    $display("Layer_2  |  round = %0d Kernel_1_1_6 = %04h  import complete",round,kernel_1_1_6);
                    $display("Layer_2  |  round = %0d Kernel_1_1_5 = %04h  import complete",round,kernel_1_1_5);
                    $display("Layer_2  |  round = %0d Kernel_1_1_4 = %04h  import complete",round,kernel_1_1_4);
                    $display("Layer_2  |  round = %0d Kernel_1_1_3 = %04h  import complete",round,kernel_1_1_3);
                    $display("Layer_2  |  round = %0d Kernel_1_1_2 = %04h  import complete",round,kernel_1_1_2);
                    $display("Layer_2  |  round = %0d Kernel_1_1_1 = %04h  import complete",round,kernel_1_1_1);
                    $display("Layer_2  |  round = %0d Kernel_1_1_0 = %04h  import complete",round,kernel_1_1_0);

                    $display("Layer_2  |  round = %0d Kernel_1_2_8 = %04h  import complete",round,kernel_1_2_8);
                    $display("Layer_2  |  round = %0d Kernel_1_2_7 = %04h  import complete",round,kernel_1_2_7);
                    $display("Layer_2  |  round = %0d Kernel_1_2_6 = %04h  import complete",round,kernel_1_2_6);
                    $display("Layer_2  |  round = %0d Kernel_1_2_5 = %04h  import complete",round,kernel_1_2_5);
                    $display("Layer_2  |  round = %0d Kernel_1_2_4 = %04h  import complete",round,kernel_1_2_4);
                    $display("Layer_2  |  round = %0d Kernel_1_2_3 = %04h  import complete",round,kernel_1_2_3);
                    $display("Layer_2  |  round = %0d Kernel_1_2_2 = %04h  import complete",round,kernel_1_2_2);
                    $display("Layer_2  |  round = %0d Kernel_1_2_1 = %04h  import complete",round,kernel_1_2_1);
                    $display("Layer_2  |  round = %0d Kernel_1_2_0 = %04h  import complete",round,kernel_1_2_0);

                    $display("Layer_2  |  round = %0d Kernel_1_3_8 = %04h  import complete",round,kernel_1_3_8);
                    $display("Layer_2  |  round = %0d Kernel_1_3_7 = %04h  import complete",round,kernel_1_3_7);
                    $display("Layer_2  |  round = %0d Kernel_1_3_6 = %04h  import complete",round,kernel_1_3_6);
                    $display("Layer_2  |  round = %0d Kernel_1_3_5 = %04h  import complete",round,kernel_1_3_5);
                    $display("Layer_2  |  round = %0d Kernel_1_3_4 = %04h  import complete",round,kernel_1_3_4);
                    $display("Layer_2  |  round = %0d Kernel_1_3_3 = %04h  import complete",round,kernel_1_3_3);
                    $display("Layer_2  |  round = %0d Kernel_1_3_2 = %04h  import complete",round,kernel_1_3_2);
                    $display("Layer_2  |  round = %0d Kernel_1_3_1 = %04h  import complete",round,kernel_1_3_1);
                    $display("Layer_2  |  round = %0d Kernel_1_3_0 = %04h  import complete",round,kernel_1_3_0);

                    $display("Layer_2  |  round = %0d Kernel_2_0_8 = %04h  import complete",round,kernel_2_0_8);
                    $display("Layer_2  |  round = %0d Kernel_2_0_7 = %04h  import complete",round,kernel_2_0_7);
                    $display("Layer_2  |  round = %0d Kernel_2_0_6 = %04h  import complete",round,kernel_2_0_6);
                    $display("Layer_2  |  round = %0d Kernel_2_0_5 = %04h  import complete",round,kernel_2_0_5);
                    $display("Layer_2  |  round = %0d Kernel_2_0_4 = %04h  import complete",round,kernel_2_0_4);
                    $display("Layer_2  |  round = %0d Kernel_2_0_3 = %04h  import complete",round,kernel_2_0_3);
                    $display("Layer_2  |  round = %0d Kernel_2_0_2 = %04h  import complete",round,kernel_2_0_2);
                    $display("Layer_2  |  round = %0d Kernel_2_0_1 = %04h  import complete",round,kernel_2_0_1);
                    $display("Layer_2  |  round = %0d Kernel_2_0_0 = %04h  import complete",round,kernel_2_0_0);

                    $display("Layer_2  |  round = %0d Kernel_2_1_8 = %04h  import complete",round,kernel_2_1_8);
                    $display("Layer_2  |  round = %0d Kernel_2_1_7 = %04h  import complete",round,kernel_2_1_7);
                    $display("Layer_2  |  round = %0d Kernel_2_1_6 = %04h  import complete",round,kernel_2_1_6);
                    $display("Layer_2  |  round = %0d Kernel_2_1_5 = %04h  import complete",round,kernel_2_1_5);
                    $display("Layer_2  |  round = %0d Kernel_2_1_4 = %04h  import complete",round,kernel_2_1_4);
                    $display("Layer_2  |  round = %0d Kernel_2_1_3 = %04h  import complete",round,kernel_2_1_3);
                    $display("Layer_2  |  round = %0d Kernel_2_1_2 = %04h  import complete",round,kernel_2_1_2);
                    $display("Layer_2  |  round = %0d Kernel_2_1_1 = %04h  import complete",round,kernel_2_1_1);
                    $display("Layer_2  |  round = %0d Kernel_2_1_0 = %04h  import complete",round,kernel_2_1_0);

                    $display("Layer_2  |  round = %0d Kernel_2_2_8 = %04h  import complete",round,kernel_2_2_8);
                    $display("Layer_2  |  round = %0d Kernel_2_2_7 = %04h  import complete",round,kernel_2_2_7);
                    $display("Layer_2  |  round = %0d Kernel_2_2_6 = %04h  import complete",round,kernel_2_2_6);
                    $display("Layer_2  |  round = %0d Kernel_2_2_5 = %04h  import complete",round,kernel_2_2_5);
                    $display("Layer_2  |  round = %0d Kernel_2_2_4 = %04h  import complete",round,kernel_2_2_4);
                    $display("Layer_2  |  round = %0d Kernel_2_2_3 = %04h  import complete",round,kernel_2_2_3);
                    $display("Layer_2  |  round = %0d Kernel_2_2_2 = %04h  import complete",round,kernel_2_2_2);
                    $display("Layer_2  |  round = %0d Kernel_2_2_1 = %04h  import complete",round,kernel_2_2_1);
                    $display("Layer_2  |  round = %0d Kernel_2_2_0 = %04h  import complete",round,kernel_2_2_0);

                    $display("Layer_2  |  round = %0d Kernel_2_3_8 = %04h  import complete",round,kernel_2_3_8);
                    $display("Layer_2  |  round = %0d Kernel_2_3_7 = %04h  import complete",round,kernel_2_3_7);
                    $display("Layer_2  |  round = %0d Kernel_2_3_6 = %04h  import complete",round,kernel_2_3_6);
                    $display("Layer_2  |  round = %0d Kernel_2_3_5 = %04h  import complete",round,kernel_2_3_5);
                    $display("Layer_2  |  round = %0d Kernel_2_3_4 = %04h  import complete",round,kernel_2_3_4);
                    $display("Layer_2  |  round = %0d Kernel_2_3_3 = %04h  import complete",round,kernel_2_3_3);
                    $display("Layer_2  |  round = %0d Kernel_2_3_2 = %04h  import complete",round,kernel_2_3_2);
                    $display("Layer_2  |  round = %0d Kernel_2_3_1 = %04h  import complete",round,kernel_2_3_1);
                    $display("Layer_2  |  round = %0d Kernel_2_3_0 = %04h  import complete",round,kernel_2_3_0);

                    $display("Layer_2  |  round = %0d Kernel_3_0_8 = %04h  import complete",round,kernel_3_0_8);
                    $display("Layer_2  |  round = %0d Kernel_3_0_7 = %04h  import complete",round,kernel_3_0_7);
                    $display("Layer_2  |  round = %0d Kernel_3_0_6 = %04h  import complete",round,kernel_3_0_6);
                    $display("Layer_2  |  round = %0d Kernel_3_0_5 = %04h  import complete",round,kernel_3_0_5);
                    $display("Layer_2  |  round = %0d Kernel_3_0_4 = %04h  import complete",round,kernel_3_0_4);
                    $display("Layer_2  |  round = %0d Kernel_3_0_3 = %04h  import complete",round,kernel_3_0_3);
                    $display("Layer_2  |  round = %0d Kernel_3_0_2 = %04h  import complete",round,kernel_3_0_2);
                    $display("Layer_2  |  round = %0d Kernel_3_0_1 = %04h  import complete",round,kernel_3_0_1);
                    $display("Layer_2  |  round = %0d Kernel_3_0_0 = %04h  import complete",round,kernel_3_0_0);

                    $display("Layer_2  |  round = %0d Kernel_3_1_8 = %04h  import complete",round,kernel_3_1_8);
                    $display("Layer_2  |  round = %0d Kernel_3_1_7 = %04h  import complete",round,kernel_3_1_7);
                    $display("Layer_2  |  round = %0d Kernel_3_1_6 = %04h  import complete",round,kernel_3_1_6);
                    $display("Layer_2  |  round = %0d Kernel_3_1_5 = %04h  import complete",round,kernel_3_1_5);
                    $display("Layer_2  |  round = %0d Kernel_3_1_4 = %04h  import complete",round,kernel_3_1_4);
                    $display("Layer_2  |  round = %0d Kernel_3_1_3 = %04h  import complete",round,kernel_3_1_3);
                    $display("Layer_2  |  round = %0d Kernel_3_1_2 = %04h  import complete",round,kernel_3_1_2);
                    $display("Layer_2  |  round = %0d Kernel_3_1_1 = %04h  import complete",round,kernel_3_1_1);
                    $display("Layer_2  |  round = %0d Kernel_3_1_0 = %04h  import complete",round,kernel_3_1_0);

                    $display("Layer_2  |  round = %0d Kernel_3_2_8 = %04h  import complete",round,kernel_3_2_8);
                    $display("Layer_2  |  round = %0d Kernel_3_2_7 = %04h  import complete",round,kernel_3_2_7);
                    $display("Layer_2  |  round = %0d Kernel_3_2_6 = %04h  import complete",round,kernel_3_2_6);
                    $display("Layer_2  |  round = %0d Kernel_3_2_5 = %04h  import complete",round,kernel_3_2_5);
                    $display("Layer_2  |  round = %0d Kernel_3_2_4 = %04h  import complete",round,kernel_3_2_4);
                    $display("Layer_2  |  round = %0d Kernel_3_2_3 = %04h  import complete",round,kernel_3_2_3);
                    $display("Layer_2  |  round = %0d Kernel_3_3_2 = %04h  import complete",round,kernel_3_2_2);
                    $display("Layer_2  |  round = %0d Kernel_3_2_1 = %04h  import complete",round,kernel_3_2_1);
                    $display("Layer_2  |  round = %0d Kernel_3_2_0 = %04h  import complete",round,kernel_3_2_0);

                    $display("Layer_2  |  round = %0d Kernel_3_3_8 = %04h  import complete",round,kernel_3_3_8);
                    $display("Layer_2  |  round = %0d Kernel_3_3_7 = %04h  import complete",round,kernel_3_3_7);
                    $display("Layer_2  |  round = %0d Kernel_3_3_6 = %04h  import complete",round,kernel_3_3_6);
                    $display("Layer_2  |  round = %0d Kernel_3_3_5 = %04h  import complete",round,kernel_3_3_5);
                    $display("Layer_2  |  round = %0d Kernel_3_3_4 = %04h  import complete",round,kernel_3_3_4);
                    $display("Layer_2  |  round = %0d Kernel_3_3_3 = %04h  import complete",round,kernel_3_3_3);
                    $display("Layer_2  |  round = %0d Kernel_3_3_2 = %04h  import complete",round,kernel_3_3_2);
                    $display("Layer_2  |  round = %0d Kernel_3_3_1 = %04h  import complete",round,kernel_3_3_1);
                    $display("Layer_2  |  round = %0d Kernel_3_3_0 = %04h  import complete",round,kernel_3_3_0);
                end
                $display("Layer_2  |  round %02d Layer_2_kernel_round %02d Kernel import complete",round + 1,Layer_2_kernel_round);

                Layer_2_pixel_0 = 0;
                Layer_2_pixel_1 = 0;
                Layer_2_pixel_2 = 0;
                Layer_2_pixel_3 = 0;
                Layer_2_img_0_bytes = 0;
                Layer_2_img_1_bytes = 0;
                Layer_2_img_2_bytes = 0;
                Layer_2_img_3_bytes = 0;

                $display("\nLayer_2  |  round %02d Layer_2_kernel_round %02d Start to write pixel",round + 1,Layer_2_kernel_round);
                for(idx = 0; idx < `padding_img_size; idx = idx+1) begin
                    //data_in import
                    //Layer_1_padding_img
                    data_in_0 <= {1'b0,Layer_1_padding_img[idx][0 + 4 * Layer_2_kernel_round]};
                    data_in_1 <= {1'b0,Layer_1_padding_img[idx][1 + 4 * Layer_2_kernel_round]};
                    data_in_2 <= {1'b0,Layer_1_padding_img[idx][2 + 4 * Layer_2_kernel_round]};
                    data_in_3 <= {1'b0,Layer_1_padding_img[idx][3 + 4 * Layer_2_kernel_round]};

                    @(posedge clk);
                    #1;

                    //CA_sum     CA_sum_0 = AT_sum = AT_sum_0 + AT_sum_1 + AT_sum_2 + AT_sum_3
                    /*CA_sum_0_[Layer_2_kernel_round] = AT_sum_0;
                    CA_sum_1_[Layer_2_kernel_round] = AT_sum_1;
                    CA_sum_2_[Layer_2_kernel_round] = AT_sum_2;
                    CA_sum_3_[Layer_2_kernel_round] = AT_sum_3;*/

                    //---------------------------------------------------------------
                    //Write output data to output file here
                    //---------------------------------------------------------------
                    if(valid_singal_0) begin
                        Layer_2_CA_0[Layer_2_kernel_round][Layer_2_pixel_0] = AT_sum_0;
                        if(Layer_2_kernel_round == 15) begin
                            for(i = 0;i < 16;i = i + 1) begin
                                CA_sum_0_[i] = Layer_2_CA_0[i][Layer_2_pixel_0];
                            end
                            #0.000001;
                            //確保每個像素在檔案中都佔據 24-bit (3 Bytes)，強制讓輸出的圖片變成「看起來像灰階的彩色圖」。
                            if((Layer_2_pixel_0 != 0) & (Layer_2_pixel_0 % 5000) == 0) begin
                                $display("Layer_2  |  round %02d Img_%02d,Img_%02d,Img_%02d,Img_%02d has been writen %02d000/50176 pixel",round + 1,(1 + 4 * round),(2 + 4 * round),(3 + 4 * round),(4 + 4 * round),(Layer_2_pixel_0 / 5000) * 5);
                            end
                            $fwrite(Layer_2_img[0 + 4 * round],"%c%c%c",ReLU_result_0[14:7],ReLU_result_0[14:7],ReLU_result_0[14:7]);
                            Layer_2_img_0_bytes = Layer_2_img_0_bytes + 3;
                        end
                        Layer_2_pixel_0 = Layer_2_pixel_0 + 1;
                    end

                    if(valid_singal_1) begin
                        Layer_2_CA_1[Layer_2_kernel_round][Layer_2_pixel_1] = AT_sum_1;
                        if(Layer_2_kernel_round == 15) begin
                            for(i = 0;i < 16;i = i + 1) begin
                                CA_sum_1_[i] = Layer_2_CA_1[i][Layer_2_pixel_1];

                            end
                            #0.000001;
                            $fwrite(Layer_2_img[1 + 4 * round],"%c%c%c",ReLU_result_1[14:7],ReLU_result_1[14:7],ReLU_result_1[14:7]);
                            Layer_2_img_1_bytes = Layer_2_img_1_bytes + 3;
                        end
                        Layer_2_pixel_1 = Layer_2_pixel_1 + 1;
                    end

                    if(valid_singal_2) begin
                        Layer_2_CA_2[Layer_2_kernel_round][Layer_2_pixel_2] = AT_sum_2;
                        if(Layer_2_kernel_round == 15) begin
                            for(i = 0;i < 16;i = i + 1) begin
                                CA_sum_2_[i] = Layer_2_CA_2[i][Layer_2_pixel_2];
                            end
                            #0.000001;
                            $fwrite(Layer_2_img[2 + 4 * round],"%c%c%c",ReLU_result_2[14:7],ReLU_result_2[14:7],ReLU_result_2[14:7]);
                            Layer_2_img_2_bytes = Layer_2_img_2_bytes + 3;
                        end
                        Layer_2_pixel_2 = Layer_2_pixel_2 + 1;
                    end

                    if(valid_singal_3) begin
                        Layer_2_CA_3[Layer_2_kernel_round][Layer_2_pixel_3] = AT_sum_3;
                        if(Layer_2_kernel_round == 15) begin
                            for(i = 0;i < 16;i = i + 1) begin
                                CA_sum_3_[i] = Layer_2_CA_3[i][Layer_2_pixel_3];
                            end
                            #0.000001;
                            /*for(i = 0;i < 3;i = i + 1) begin
                                $fwrite(Layer_2_img[3 + 4 * round],"%c",ReLU_result_3[14:7]);
                                Layer_2_img_3_bytes = Layer_2_img_3_bytes + 1;
                            end*/
                            $fwrite(Layer_2_img[3 + 4 * round],"%c%c%c",ReLU_result_3[14:7],ReLU_result_3[14:7],ReLU_result_3[14:7]);
                            Layer_2_img_3_bytes = Layer_2_img_3_bytes + 3;
                        end
                        Layer_2_pixel_3 = Layer_2_pixel_3 + 1;
                    end
                end
                $display("Layer_2  |  round %02d Layer_2_kernel_round %02d Write pixel complete",round + 1,Layer_2_kernel_round);
            end

            Layer_2_img_bytes_mem[0 + 4 * round] = Layer_2_img_0_bytes + 54;
            Layer_2_img_bytes_mem[1 + 4 * round] = Layer_2_img_1_bytes + 54;
            Layer_2_img_bytes_mem[2 + 4 * round] = Layer_2_img_2_bytes + 54;
            Layer_2_img_bytes_mem[3 + 4 * round] = Layer_2_img_3_bytes + 54;

            Layer_2_pixel_mem[0 + 4 * round] = Layer_2_pixel_0;
            Layer_2_pixel_mem[1 + 4 * round] = Layer_2_pixel_1;
            Layer_2_pixel_mem[2 + 4 * round] = Layer_2_pixel_2;
            Layer_2_pixel_mem[3 + 4 * round] = Layer_2_pixel_3;

            $display("\n--------------------------- | Layer_2 %02d / %02d  End  Simulation | ---------------------------\n",round + 1,`Layer_1_round_times);
        end
        $display("--------------------------- | Layer_2 End Simulation | ---------------------------");
    end


    if(`Layer_1_enable) begin
        $display("\n|----------------------------------------------------------|");
        $display("|            |    Layer 1 Detection RESULT    |            |");
        $display("|----------------------------------------------------------|");
        $display("|  Corret byte = 150582     | |      Corret pixel = 50176  |");
        $display("|----------------------------------------------------------|");
        $display("|  STATE  |          BYTE          |         PIXEL         |");
        $display("|----------------------------------------------------------|");

        //16 => `round_times
        for(round = 0;round < `Layer_1_round_times;round = round + 1) begin
            for(i = 0;i < 4;i = i + 1) begin
                if(Layer_1_img_bytes_mem[i + 4 * round] !=`img_corret_bytes || Layer_1_pixel_mem[i + 4 * round] !=`img_corret_pixel) begin
                    $display("|  ERROR  | img_%02d_bytes = %06d  |  img_%02d_pixel = %05d |",i + 1 + 4 * round,Layer_1_img_bytes_mem[i + 4 * round],i + 1 + 4 * round,Layer_1_pixel_mem[i + 4 * round]);
                end
                else begin
                    $display("| SUCCESS | img_%02d_bytes = %06d  |  img_%02d_pixel = %05d |",i + 1 + 4 * round,Layer_1_img_bytes_mem[i + 4 * round],i + 1 + 4 * round,Layer_1_pixel_mem[i + 4 * round]);
                end
            end
        end
        $display("|----------------------------------------------------------|");
    end

    if(`Layer_2_enable) begin
        $display("\n|----------------------------------------------------------|");
        $display("|            |    Layer 2 Detection RESULT    |            |");
        $display("|----------------------------------------------------------|");
        $display("|  Corret byte = 150582     | |      Corret pixel = 50176  |");
        $display("|----------------------------------------------------------|");
        $display("|  STATE  |          BYTE          |         PIXEL         |");
        $display("|----------------------------------------------------------|");

        //16 => `round_times
        for(round = 0;round < `Layer_2_round_times;round = round + 1) begin
            for(i = 0;i < 4;i = i + 1) begin
                if(Layer_2_img_bytes_mem[i + 4 * round] !=`img_corret_bytes || Layer_2_pixel_mem[i + 4 * round] !=`img_corret_pixel) begin
                    $display("|  ERROR  | img_%02d_bytes = %06d  |  img_%02d_pixel = %05d |",i + 1 + 4 * round,Layer_2_img_bytes_mem[i + 4 * round],i + 1 + 4 * round,Layer_2_pixel_mem[i + 4 * round]);
                end
                else begin
                    $display("| SUCCESS | img_%02d_bytes = %06d  |  img_%02d_pixel = %05d |",i + 1 + 4 * round,Layer_2_img_bytes_mem[i + 4 * round],i + 1 + 4 * round,Layer_2_pixel_mem[i + 4 * round]);
                end
            end
        end
        $display("|----------------------------------------------------------|");
    end


    @(posedge clk);
    @(posedge clk);
    //(4 * `round_times)
    for(file_num = 0; file_num < 64; file_num = file_num + 1) begin
        $fclose(Layer_1_img[file_num]);
        $fclose(Layer_2_img[file_num]);
    end
    $finish;
end
//------------------------------------------------------------------------------------------------------------------------------

endmodule
