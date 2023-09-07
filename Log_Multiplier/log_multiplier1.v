module log_multiplier1(n1,n2,p0,zero_input_flag1,zero_input_flag2);
input [15:0]n1,n2;
output wire  [33:0]p0;
output zero_input_flag1,zero_input_flag2;
wire  [3:0]k1,k2;
wire  [31:0]n11,n22,n111,n222,k;
wire [4:0]k12;
wire  [32:0]n;
stage_one   o1(.n1(n1),.n2(n2),.n11(n11),.n22(n22),.k1(k1),.k2(k2),.zero_input_flag1(zero_input_flag1),.zero_input_flag2(zero_input_flag2));
stage_two   o2(.k1(k1),.k2(k2),.n11(n11),.n22(n22),.k12(k12),.n111(n111),.n222(n222));
stage_three o3(.k12(k12),.n111(n111),.n222(n222),.k(k),.n(n));
stage_four  o4(.k(k),.n(n),.p0(p0));
endmodule

module stage_four(k,n,p0);
input [31:0]k;
input [32:0]n;
output [33:0]p0;
adderc c1(.a(k),.b(n),.y(p0));
endmodule 

module stage_three(k12,n111,n222,k,n);
input [4:0]k12;
input [31:0]n111,n222;
output [31:0]k;
output [32:0]n;
decoder d1(.a(k12),.y(k));
adderb  b1(.a(n111),.b(n222),.y(n));
endmodule 

module stage_two(k1,k2,n11,n22,k12,n111,n222);
input [3:0]k1,k2;
input [31:0]n11,n22;
output [4:0]k12;
output [31:0]n111,n222;
addera a1(.a(k1),.b(k2),.y(k12));
barrel_shifter b1(.x(n11),.s(k2),.z(n111));
barrel_shifter b2(.x(n22),.s(k1),.z(n222));
endmodule 


module stage_one(n1,n2,n11,n22,k1,k2,zero_input_flag1,zero_input_flag2);
input [15:0]n1,n2;
output [31:0]n11,n22;
output [3:0]k1,k2;
output zero_input_flag1,zero_input_flag2;
wire [15:0]w1,w2;
sixteen_bit_lod   s1(.d(n1),.o(w1),.zero_input_flag(zero_input_flag1));
sixteen_bit_lod   s2(.d(n2),.o(w2),.zero_input_flag(zero_input_flag2));
priority_encoder  p1(.a(w1),.y(k1));
priority_encoder  p2(.a(w2),.y(k2));
xor_gate          x1(.a(n1),.b(w1),.y(n11));
xor_gate          x2(.a(n2),.b(w2),.y(n22));
endmodule


module decoder(a,y);
input [4:0]a;
output [31:0]y;
assign  y[0] =  ~a[4]  &  ~a[3]  &  ~a[2]  &  ~a[1]  &  ~a[0] ;  
assign  y[1] =  ~a[4]  &  ~a[3]  &  ~a[2]  &  ~a[1]  &   a[0] ;  
assign  y[2] =  ~a[4]  &  ~a[3]  &  ~a[2]  &   a[1]  &  ~a[0] ;  
assign  y[3] =  ~a[4]  &  ~a[3]  &  ~a[2]  &   a[1]  &   a[0] ;  
assign  y[4] =  ~a[4]  &  ~a[3]  &   a[2]  &  ~a[1]  &  ~a[0] ;  
assign  y[5] =  ~a[4]  &  ~a[3]  &   a[2]  &  ~a[1]  &   a[0] ;  
assign  y[6] =  ~a[4]  &  ~a[3]  &   a[2]  &   a[1]  &  ~a[0] ;  
assign  y[7] =  ~a[4]  &  ~a[3]  &   a[2]  &   a[1]  &   a[0] ;  
assign  y[8] =  ~a[4]  &   a[3]  &  ~a[2]  &  ~a[1]  &  ~a[0] ;  
assign  y[9] =  ~a[4]  &   a[3]  &  ~a[2]  &  ~a[1]  &   a[0] ;  
assign y[10] =  ~a[4]  &   a[3]  &  ~a[2]  &   a[1]  &  ~a[0] ;  
assign y[11] =  ~a[4]  &   a[3]  &  ~a[2]  &   a[1]  &   a[0] ;  
assign y[12] =  ~a[4]  &   a[3]  &   a[2]  &  ~a[1]  &  ~a[0] ;  
assign y[13] =  ~a[4]  &   a[3]  &   a[2]  &  ~a[1]  &   a[0] ;  
assign y[14] =  ~a[4]  &   a[3]  &   a[2]  &   a[1]  &  ~a[0] ;  
assign y[15] =  ~a[4]  &   a[3]  &   a[2]  &   a[1]  &   a[0] ;  
assign y[16] =   a[4]  &  ~a[3]  &  ~a[2]  &  ~a[1]  &  ~a[0] ;  
assign y[17] =   a[4]  &  ~a[3]  &  ~a[2]  &  ~a[1]  &   a[0] ;  
assign y[18] =   a[4]  &  ~a[3]  &  ~a[2]  &   a[1]  &  ~a[0] ;  
assign y[19] =   a[4]  &  ~a[3]  &  ~a[2]  &   a[1]  &   a[0] ;  
assign y[20] =   a[4]  &  ~a[3]  &   a[2]  &  ~a[1]  &  ~a[0] ;  
assign y[21] =   a[4]  &  ~a[3]  &   a[2]  &  ~a[1]  &   a[0] ;  
assign y[22] =   a[4]  &  ~a[3]  &   a[2]  &   a[1]  &  ~a[0] ;  
assign y[23] =   a[4]  &  ~a[3]  &   a[2]  &   a[1]  &   a[0] ;  
assign y[24] =   a[4]  &   a[3]  &  ~a[2]  &  ~a[1]  &  ~a[0] ;  
assign y[25] =   a[4]  &   a[3]  &  ~a[2]  &  ~a[1]  &   a[0] ;  
assign y[26] =   a[4]  &   a[3]  &  ~a[2]  &   a[1]  &  ~a[0] ;  
assign y[27] =   a[4]  &   a[3]  &  ~a[2]  &   a[1]  &   a[0] ;  
assign y[28] =   a[4]  &   a[3]  &   a[2]  &  ~a[1]  &  ~a[0] ;  
assign y[29] =   a[4]  &   a[3]  &   a[2]  &  ~a[1]  &   a[0] ;  
assign y[30] =   a[4]  &   a[3]  &   a[2]  &   a[1]  &  ~a[0] ;  
assign y[31] =   a[4]  &   a[3]  &   a[2]  &   a[1]  &   a[0] ;  
endmodule

module addera(a,b,y);
input [3:0]a,b;
output [4:0]y;
assign y = a + b;
endmodule 

module adderb(a,b,y);
input [31:0]a,b;
output [32:0]y;
assign y = a + b;
endmodule 

module adderc(a,b,y);
input [31:0]a;
input [32:0]b;
output [33:0]y;
assign y = a + b;
endmodule 


module mux(a,b,s,y);
input a,b,s;
output y;
assign y = s ? a : b;
endmodule 

module barrel_shifter(x,s,z);
input [31:0]x;
input [3:0]s;
output [31:0]z;
wire [127:0]y;
mux m0(.a(1'b0),.b(x[0]),.s(s[0]),.y(y[0])); 
mux m1(.a(x[0]),.b(x[1]),.s(s[0]),.y(y[1]));
mux m2(.a(x[1]),.b(x[2]),.s(s[0]),.y(y[2])); 
mux m3(.a(x[2]),.b(x[3]),.s(s[0]),.y(y[3])); 
mux m4(.a(x[3]),.b(x[4]),.s(s[0]),.y(y[4]));
mux m5(.a(x[4]),.b(x[5]),.s(s[0]),.y(y[5])); 
mux m6(.a(x[5]),.b(x[6]),.s(s[0]),.y(y[6])); 
mux m7(.a(x[6]),.b(x[7]),.s(s[0]),.y(y[7])); 
mux m8(.a(x[7]),.b(x[8]),.s(s[0]),.y(y[8])); 
mux m9(.a(x[8]),.b(x[9]),.s(s[0]),.y(y[9])); 
mux m10(.a(x[9]),.b(x[10]),.s(s[0]),.y(y[10])); 
mux m11(.a(x[10]),.b(x[11]),.s(s[0]),.y(y[11])); 
mux m12(.a(x[11]),.b(x[12]),.s(s[0]),.y(y[12])); 
mux m13(.a(x[12]),.b(x[13]),.s(s[0]),.y(y[13]));
mux m14(.a(x[13]),.b(x[14]),.s(s[0]),.y(y[14])); 
mux m15(.a(x[14]),.b(x[15]),.s(s[0]),.y(y[15]));
mux m16(.a(x[15]),.b(x[16]),.s(s[0]),.y(y[16])); 
mux m17(.a(x[16]),.b(x[17]),.s(s[0]),.y(y[17])); 
mux m18(.a(x[17]),.b(x[18]),.s(s[0]),.y(y[18]));
mux m19(.a(x[18]),.b(x[19]),.s(s[0]),.y(y[19]));  
mux m20(.a(x[19]),.b(x[20]),.s(s[0]),.y(y[20])); 
mux m21(.a(x[20]),.b(x[21]),.s(s[0]),.y(y[21])); 
mux m22(.a(x[21]),.b(x[22]),.s(s[0]),.y(y[22])); 
mux m23(.a(x[22]),.b(x[23]),.s(s[0]),.y(y[23])); 
mux m24(.a(x[23]),.b(x[24]),.s(s[0]),.y(y[24])); 
mux m25(.a(x[24]),.b(x[25]),.s(s[0]),.y(y[25])); 
mux m26(.a(x[25]),.b(x[26]),.s(s[0]),.y(y[26])); 
mux m27(.a(x[26]),.b(x[27]),.s(s[0]),.y(y[27])); 
mux m28(.a(x[27]),.b(x[28]),.s(s[0]),.y(y[28]));
mux m29(.a(x[28]),.b(x[29]),.s(s[0]),.y(y[29])); 
mux m30(.a(x[29]),.b(x[30]),.s(s[0]),.y(y[30])); 
mux m31(.a(x[30]),.b(x[31]),.s(s[0]),.y(y[31]));
mux m32(.a(1'b0),.b(y[0]),.s(s[1]),.y(y[32])); 
mux m33(.a(1'b0),.b(y[1]),.s(s[1]),.y(y[33])); 
mux m34(.a(y[0]),.b(y[2]),.s(s[1]),.y(y[34])); 
mux m35(.a(y[1]),.b(y[3]),.s(s[1]),.y(y[35])); 
mux m36(.a(y[2]),.b(y[4]),.s(s[1]),.y(y[36])); 
mux m37(.a(y[3]),.b(y[5]),.s(s[1]),.y(y[37])); 
mux m38(.a(y[4]),.b(y[6]),.s(s[1]),.y(y[38])); 
mux m39(.a(y[5]),.b(y[7]),.s(s[1]),.y(y[39])); 
mux m40(.a(y[6]),.b(y[8]),.s(s[1]),.y(y[40])); 
mux m41(.a(y[7]),.b(y[9]),.s(s[1]),.y(y[41])); 
mux m42(.a(y[8]),.b(y[10]),.s(s[1]),.y(y[42]));
mux m43(.a(y[9]),.b(y[11]),.s(s[1]),.y(y[43])); 
mux m44(.a(y[10]),.b(y[12]),.s(s[1]),.y(y[44])); 
mux m45(.a(y[11]),.b(y[13]),.s(s[1]),.y(y[45]));
mux m46(.a(y[12]),.b(y[14]),.s(s[1]),.y(y[46])); 
mux m47(.a(y[13]),.b(y[15]),.s(s[1]),.y(y[47])); 
mux m48(.a(y[14]),.b(y[16]),.s(s[1]),.y(y[48])); 
mux m49(.a(y[15]),.b(y[17]),.s(s[1]),.y(y[49])); 
mux m50(.a(y[16]),.b(y[18]),.s(s[1]),.y(y[50])); 
mux m51(.a(y[17]),.b(y[19]),.s(s[1]),.y(y[51])); 
mux m52(.a(y[18]),.b(y[20]),.s(s[1]),.y(y[52])); 
mux m53(.a(y[19]),.b(y[21]),.s(s[1]),.y(y[53])); 
mux m54(.a(y[20]),.b(y[22]),.s(s[1]),.y(y[54])); 
mux m55(.a(y[21]),.b(y[23]),.s(s[1]),.y(y[55])); 
mux m56(.a(y[22]),.b(y[24]),.s(s[1]),.y(y[56]));
mux m57(.a(y[23]),.b(y[25]),.s(s[1]),.y(y[57])); 
mux m58(.a(y[24]),.b(y[26]),.s(s[1]),.y(y[58])); 
mux m59(.a(y[25]),.b(y[27]),.s(s[1]),.y(y[59]));
mux m60(.a(y[26]),.b(y[28]),.s(s[1]),.y(y[60])); 
mux m61(.a(y[27]),.b(y[29]),.s(s[1]),.y(y[61])); 
mux m62(.a(y[28]),.b(y[30]),.s(s[1]),.y(y[62])); 
mux m63(.a(y[29]),.b(y[31]),.s(s[1]),.y(y[63])); 
mux m64(.a(1'b0),.b(y[32]),.s(s[2]),.y(y[64])); 
mux m65(.a(1'b0),.b(y[33]),.s(s[2]),.y(y[65])); 
mux m66(.a(1'b0),.b(y[34]),.s(s[2]),.y(y[66])); 
mux m67(.a(1'b0),.b(y[35]),.s(s[2]),.y(y[67])); 
mux m68(.a(y[32]),.b(y[36]),.s(s[2]),.y(y[68])); 
mux m69(.a(y[33]),.b(y[37]),.s(s[2]),.y(y[69])); 
mux m70(.a(y[34]),.b(y[38]),.s(s[2]),.y(y[70]));
mux m71(.a(y[35]),.b(y[39]),.s(s[2]),.y(y[71])); 
mux m72(.a(y[36]),.b(y[40]),.s(s[2]),.y(y[72])); 
mux m73(.a(y[37]),.b(y[41]),.s(s[2]),.y(y[73]));
mux m74(.a(y[38]),.b(y[42]),.s(s[2]),.y(y[74])); 
mux m75(.a(y[39]),.b(y[43]),.s(s[2]),.y(y[75])); 
mux m76(.a(y[40]),.b(y[44]),.s(s[2]),.y(y[76])); 
mux m77(.a(y[41]),.b(y[45]),.s(s[2]),.y(y[77])); 
mux m78(.a(y[42]),.b(y[46]),.s(s[2]),.y(y[78])); 
mux m79(.a(y[43]),.b(y[47]),.s(s[2]),.y(y[79])); 
mux m80(.a(y[44]),.b(y[48]),.s(s[2]),.y(y[80])); 
mux m81(.a(y[45]),.b(y[49]),.s(s[2]),.y(y[81])); 
mux m82(.a(y[46]),.b(y[50]),.s(s[2]),.y(y[82])); 
mux m83(.a(y[47]),.b(y[51]),.s(s[2]),.y(y[83])); 
mux m84(.a(y[48]),.b(y[52]),.s(s[2]),.y(y[84]));
mux m85(.a(y[49]),.b(y[53]),.s(s[2]),.y(y[85])); 
mux m86(.a(y[50]),.b(y[54]),.s(s[2]),.y(y[86])); 
mux m87(.a(y[51]),.b(y[55]),.s(s[2]),.y(y[87]));
mux m88(.a(y[52]),.b(y[56]),.s(s[2]),.y(y[88])); 
mux m89(.a(y[53]),.b(y[57]),.s(s[2]),.y(y[89])); 
mux m90(.a(y[54]),.b(y[58]),.s(s[2]),.y(y[90])); 
mux m91(.a(y[55]),.b(y[59]),.s(s[2]),.y(y[91])); 
mux m92(.a(y[56]),.b(y[60]),.s(s[2]),.y(y[92])); 
mux m93(.a(y[57]),.b(y[61]),.s(s[2]),.y(y[93])); 
mux m94(.a(y[58]),.b(y[62]),.s(s[2]),.y(y[94])); 
mux m95(.a(y[59]),.b(y[63]),.s(s[2]),.y(y[95])); 
mux m96(.a(1'b0),.b(y[64]),.s(s[3]),.y(y[96])); 
mux m97(.a(1'b0),.b(y[65]),.s(s[3]),.y(y[97])); 
mux m98(.a(1'b0),.b(y[66]),.s(s[3]),.y(y[98])); 
mux m99(.a(1'b0),.b(y[67]),.s(s[3]),.y(y[99]));
mux m100(.a(1'b0),.b(y[68]),.s(s[3]),.y(y[100])); 
mux m101(.a(1'b0),.b(y[69]),.s(s[3]),.y(y[101])); 
mux m102(.a(1'b0),.b(y[70]),.s(s[3]),.y(y[102])); 
mux m103(.a(1'b0),.b(y[71]),.s(s[3]),.y(y[103])); 
mux m104(.a(y[64]),.b(y[72]),.s(s[3]),.y(y[104])); 
mux m105(.a(y[65]),.b(y[73]),.s(s[3]),.y(y[105])); 
mux m106(.a(y[66]),.b(y[74]),.s(s[3]),.y(y[106])); 
mux m107(.a(y[67]),.b(y[75]),.s(s[3]),.y(y[107])); 
mux m108(.a(y[68]),.b(y[76]),.s(s[3]),.y(y[108])); 
mux m109(.a(y[69]),.b(y[77]),.s(s[3]),.y(y[109])); 
mux m110(.a(y[70]),.b(y[78]),.s(s[3]),.y(y[110])); 
mux m111(.a(y[71]),.b(y[79]),.s(s[3]),.y(y[111]));
mux m112(.a(y[72]),.b(y[80]),.s(s[3]),.y(y[112])); 
mux m113(.a(y[73]),.b(y[81]),.s(s[3]),.y(y[113])); 
mux m114(.a(y[74]),.b(y[82]),.s(s[3]),.y(y[114])); 
mux m115(.a(y[75]),.b(y[83]),.s(s[3]),.y(y[115])); 
mux m116(.a(y[76]),.b(y[84]),.s(s[3]),.y(y[116])); 
mux m117(.a(y[77]),.b(y[85]),.s(s[3]),.y(y[117])); 
mux m118(.a(y[78]),.b(y[86]),.s(s[3]),.y(y[118])); 
mux m119(.a(y[79]),.b(y[87]),.s(s[3]),.y(y[119])); 
mux m120(.a(y[80]),.b(y[88]),.s(s[3]),.y(y[120])); 
mux m121(.a(y[81]),.b(y[89]),.s(s[3]),.y(y[121])); 
mux m122(.a(y[82]),.b(y[90]),.s(s[3]),.y(y[122])); 
mux m123(.a(y[83]),.b(y[91]),.s(s[3]),.y(y[123]));
mux m124(.a(y[84]),.b(y[92]),.s(s[3]),.y(y[124])); 
mux m125(.a(y[85]),.b(y[93]),.s(s[3]),.y(y[125])); 
mux m126(.a(y[86]),.b(y[94]),.s(s[3]),.y(y[126])); 
mux m127(.a(y[87]),.b(y[95]),.s(s[3]),.y(y[127])); 
mux m128(.a(1'b0),.b(y[96]),.s(1'b0),.y(z[0])); 
mux m129(.a(1'b0),.b(y[97]),.s(1'b0),.y(z[1])); 
mux m130(.a(1'b0),.b(y[98]),.s(1'b0),.y(z[2])); 
mux m131(.a(1'b0),.b(y[99]),.s(1'b0),.y(z[3])); 
mux m132(.a(1'b0),.b(y[100]),.s(1'b0),.y(z[4])); 
mux m133(.a(1'b0),.b(y[101]),.s(1'b0),.y(z[5])); 
mux m134(.a(1'b0),.b(y[102]),.s(1'b0),.y(z[6])); 
mux m135(.a(1'b0),.b(y[103]),.s(1'b0),.y(z[7]));
mux m136(.a(1'b0),.b(y[104]),.s(1'b0),.y(z[8])); 
mux m137(.a(1'b0),.b(y[105]),.s(1'b0),.y(z[9])); 
mux m138(.a(1'b0),.b(y[106]),.s(1'b0),.y(z[10])); 
mux m139(.a(1'b0),.b(y[107]),.s(1'b0),.y(z[11])); 
mux m140(.a(1'b0),.b(y[108]),.s(1'b0),.y(z[12])); 
mux m141(.a(1'b0),.b(y[109]),.s(1'b0),.y(z[13])); 
mux m142(.a(1'b0),.b(y[110]),.s(1'b0),.y(z[14])); 
mux m143(.a(1'b0),.b(y[111]),.s(1'b0),.y(z[15])); 
mux m144(.a(y[96]),.b(y[112]),.s(1'b0),.y(z[16])); 
mux m145(.a(y[97]),.b(y[113]),.s(1'b0),.y(z[17])); 
mux m146(.a(y[98]),.b(y[114]),.s(1'b0),.y(z[18])); 
mux m147(.a(y[99]),.b(y[115]),.s(1'b0),.y(z[19]));
mux m148(.a(y[100]),.b(y[116]),.s(1'b0),.y(z[20])); 
mux m149(.a(y[101]),.b(y[117]),.s(1'b0),.y(z[21])); 
mux m150(.a(y[102]),.b(y[118]),.s(1'b0),.y(z[22])); 
mux m151(.a(y[103]),.b(y[119]),.s(1'b0),.y(z[23])); 
mux m152(.a(y[104]),.b(y[120]),.s(1'b0),.y(z[24])); 
mux m153(.a(y[105]),.b(y[121]),.s(1'b0),.y(z[25])); 
mux m154(.a(y[106]),.b(y[122]),.s(1'b0),.y(z[26])); 
mux m155(.a(y[107]),.b(y[123]),.s(1'b0),.y(z[27])); 
mux m156(.a(y[108]),.b(y[124]),.s(1'b0),.y(z[28])); 
mux m157(.a(y[109]),.b(y[125]),.s(1'b0),.y(z[29])); 
mux m158(.a(y[110]),.b(y[126]),.s(1'b0),.y(z[30])); 
mux m159(.a(y[111]),.b(y[127]),.s(1'b0),.y(z[31])); 
endmodule

module xor_gate(a,b,y);
input [15:0]a,b;
output [31:0]y;
assign y = a^b;
endmodule 

module priority_encoder(a,y);
input [15:0]a;
output reg [3:0]y;
always @(*)
if (a[15]==1'b1) 
	y=4'd15;  
else if (a[14]==1'b1) 
	y=4'd14;
else if (a[13]==1'b1) 
	y=4'd13;
else if (a[12]==1'b1) 
	y=4'd12;
else if (a[11]==1'b1) 
	y=4'd11;
else if (a[10]==1'b1) 
	y=4'd10;
else if (a[9]==1'b1) 
	y=4'd9;
else if (a[8]==1'b1) 
	y=4'd8;
else if (a[7]==1'b1) 
	y=4'd7;
else if (a[6]==1'b1) 
	y=4'd6;
else if (a[5]==1'b1) 
	y=4'd5;
else if (a[4]==1'b1) 
	y=4'd4;
else if (a[3]==1'b1) 
	y=4'd3;
else if (a[2]==1'b1) 
	y=4'd2;
else if (a[1]==1'b1) 
	y=4'd1;
else y=4'd0;
endmodule

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





