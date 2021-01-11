module muxa(s,y);
input s;
output wire y;
assign y = s ? 0 : 1;
endmodule  

module muxb(a,s,y);
input a,s;
output wire y;
assign y = s ? 0 : a;
endmodule  

module four_bit_lod(a,y);
input [3:0]a;
output wire [3:0]y;
wire [2:0]x;
assign y[3] = a[3];
muxa a1(.s(a[3]),.y(x[2]));
muxb b1(.a(x[2]),.s(a[2]),.y(x[1]));
muxb b2(.a(x[1]),.s(a[1]),.y(x[0]));
and a2(y[2],x[2],a[2]);
and a3(y[1],x[1],a[1]);
and a4(y[0],x[0],a[0]);
endmodule

module four_bit_mux(a,s,y);
input [3:0]a;
input s;
output [3:0]y;
assign y = s ? a : 0 ;
endmodule  

module sixteen_bit_lod(d,o,zero_input_flag);
input [15:0]d;
output [15:0]o;
output zero_input_flag;
wire [15:0]z;
wire [3:0]x,y;
four_bit_lod l2(.a(d[15:12]),.y(z[15:12]));
four_bit_lod l3(.a(d[11:8]),.y(z[11:8]));
four_bit_lod l4(.a(d[7:4]),.y(z[7:4]));
four_bit_lod l5(.a(d[3:0]),.y(z[3:0]));
assign x[3] = |d[15:12];
assign x[2] = |d[11:8];
assign x[1] = |d[7:4];
assign x[0] = |d[3:0];
assign zero_input_flag = |x;
four_bit_lod l6(.a(x),.y(y));
four_bit_mux m1(.a(z[15:12]),.s(y[3]),.y(o[15:12]));
four_bit_mux m2(.a(z[11:8]),.s(y[2]),.y(o[11:8]));
four_bit_mux m3(.a(z[7:4]),.s(y[1]),.y(o[7:4]));
four_bit_mux m4(.a(z[3:0]),.s(y[0]),.y(o[3:0]));
endmodule