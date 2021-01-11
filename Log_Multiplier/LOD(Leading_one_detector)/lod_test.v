module lod_test();
reg [15:0]d;
wire [15:0]o;
wire zero_input_flag;
sixteen_bit_lod d1(d,o,zero_input_flag);
initial begin 
d = 16'b0;
$monitor ($time,"Input = %b, Output = %b, zero_input_flag = %b",d,o,zero_input_flag);
end
initial begin
#10 d = 16'b1001_1000_0000_1100 ;
#10 d = 16'b0001_1000_0000_1100 ;
#10 d = 16'b0000_0100_1000_1100 ;
#10 d = 16'b0000_1100 ;
#50 $stop;
end 
endmodule
 