module log_multiplier1_test;
reg [15:0]n1,n2;
wire  [33:0]p0;
wire  zero_input_flag1,zero_input_flag2;
log_multiplier1 m1(n1,n2,p0,zero_input_flag1,zero_input_flag2);
initial begin 
n1=0; n2=0;
$monitor($time,"n1 = %d, n2 =%d, product = %d",n1,n2,p0);
end 
initial begin
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#10 n1 = $random; n2 = $random;
#50 $stop; 
end 
endmodule  
