`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  Copyright 2013-2016 Istvan Hegedus
//
//  FPGATED is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  FPGATED is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>. 
//
// Create Date:    22:03:30 11/20/2014 
// Design Name: 	 Commodore Plus/4 color value conversion to 12bit RGB values 
// Module Name:    colors_to_rgb.v 
// Project Name:   FPGATED
// Target Devices: Xilinx Spartan 3E
//
// Description: 	
// 	Converts TED's 7 bit color codes to 12 bit RGB values used by video DAC.
//		12 bit DAC values from Jozsef Laszlo
//
// Revisions: 
// Revision 0.1 - File Created 
//
//////////////////////////////////////////////////////////////////////////////////
module colors_to_rgb(
	 input clk,
    input [6:0] color,
    output [7:0] red,
    output [7:0] green,
    output [7:0] blue,
	 input        pal
    );
	 
reg [23:0] pal_lut [127:0];
reg [23:0] ntsc_lut [127:0];
reg [23:0] rgbcolor;


initial
	begin
		pal_lut[0]=24'h00_00_00;
		pal_lut[1]=24'h27_27_27;
		pal_lut[2]=24'h60_0f_10;
		pal_lut[3]=24'h00_40_3f;
		pal_lut[4]=24'h56_04_66;
		pal_lut[5]=24'h00_4b_00;
		pal_lut[6]=24'h1a_1a_8c;
		pal_lut[7]=24'h35_34_00;
		pal_lut[8]=24'h53_1e_00;
		pal_lut[9]=24'h47_28_00;
		pal_lut[10]=24'h18_43_00;
		pal_lut[11]=24'h61_08_34;
		pal_lut[12]=24'h00_47_1e;
		pal_lut[13]=24'h04_29_7a;
		pal_lut[14]=24'h28_13_8f;
		pal_lut[15]=24'h08_48_00;
		pal_lut[16]=24'h00_00_00;
		pal_lut[17]=24'h37_37_37;
		pal_lut[18]=24'h6f_1e_1f;
		pal_lut[19]=24'h00_4f_4e;
		pal_lut[20]=24'h65_13_75;
		pal_lut[21]=24'h04_5a_05;
		pal_lut[22]=24'h2a_2a_9c;
		pal_lut[23]=24'h44_44_00;
		pal_lut[24]=24'h63_2e_00;
		pal_lut[25]=24'h56_38_00;
		pal_lut[26]=24'h28_52_00;
		pal_lut[27]=24'h70_17_43;
		pal_lut[28]=24'h00_56_2e;
		pal_lut[29]=24'h14_38_8a;
		pal_lut[30]=24'h38_22_9e;
		pal_lut[31]=24'h17_58_00;
		pal_lut[32]=24'h00_00_00;
		pal_lut[33]=24'h43_43_43;
		pal_lut[34]=24'h7c_2b_2c;
		pal_lut[35]=24'h0b_5c_5b;
		pal_lut[36]=24'h72_20_82;
		pal_lut[37]=24'h11_67_11;
		pal_lut[38]=24'h36_37_a8;
		pal_lut[39]=24'h51_50_00;
		pal_lut[40]=24'h6f_3a_00;
		pal_lut[41]=24'h63_44_00;
		pal_lut[42]=24'h34_5f_00;
		pal_lut[43]=24'h7d_24_50;
		pal_lut[44]=24'h0a_63_3a;
		pal_lut[45]=24'h21_45_96;
		pal_lut[46]=24'h45_2f_ab;
		pal_lut[47]=24'h24_65_00;
		pal_lut[48]=24'h00_00_00;
		pal_lut[49]=24'h55_55_55;
		pal_lut[50]=24'h8d_3c_3d;
		pal_lut[51]=24'h1c_6d_6c;
		pal_lut[52]=24'h83_31_93;
		pal_lut[53]=24'h22_78_22;
		pal_lut[54]=24'h47_48_b9;
		pal_lut[55]=24'h62_61_00;
		pal_lut[56]=24'h80_4b_11;
		pal_lut[57]=24'h74_55_00;
		pal_lut[58]=24'h45_70_00;
		pal_lut[59]=24'h8e_35_61;
		pal_lut[60]=24'h1b_74_4b;
		pal_lut[61]=24'h32_56_a7;
		pal_lut[62]=24'h56_40_bc;
		pal_lut[63]=24'h35_76_00;
		pal_lut[64]=24'h00_00_00;
		pal_lut[65]=24'h79_79_79;
		pal_lut[66]=24'hb2_61_62;
		pal_lut[67]=24'h40_91_90;
		pal_lut[68]=24'ha7_55_b7;
		pal_lut[69]=24'h46_9d_47;
		pal_lut[70]=24'h6c_6c_de;
		pal_lut[71]=24'h86_86_14;
		pal_lut[72]=24'ha5_70_35;
		pal_lut[73]=24'h99_7a_22;
		pal_lut[74]=24'h6a_94_15;
		pal_lut[75]=24'hb3_59_86;
		pal_lut[76]=24'h3f_98_70;
		pal_lut[77]=24'h56_7b_cc;
		pal_lut[78]=24'h7a_64_e1;
		pal_lut[79]=24'h59_9a_22;
		pal_lut[80]=24'h00_00_00;
		pal_lut[81]=24'ha9_a9_a9;
		pal_lut[82]=24'he1_90_91;
		pal_lut[83]=24'h70_c1_c0;
		pal_lut[84]=24'hd7_85_e7;
		pal_lut[85]=24'h76_cc_76;
		pal_lut[86]=24'h9c_9c_ff;
		pal_lut[87]=24'hb6_b6_44;
		pal_lut[88]=24'hd5_a0_65;
		pal_lut[89]=24'hc8_a9_52;
		pal_lut[90]=24'h9a_c4_45;
		pal_lut[91]=24'he2_89_b5;
		pal_lut[92]=24'h6f_c8_a0;
		pal_lut[93]=24'h86_aa_fb;
		pal_lut[94]=24'haa_94_ff;
		pal_lut[95]=24'h89_ca_52;
		pal_lut[96]=24'h00_00_00;
		pal_lut[97]=24'hc7_c7_c7;
		pal_lut[98]=24'hff_af_b0;
		pal_lut[99]=24'h8f_e0_df;
		pal_lut[100]=24'hf6_a3_ff;
		pal_lut[101]=24'h94_eb_95;
		pal_lut[102]=24'hba_ba_ff;
		pal_lut[103]=24'hd4_d4_62;
		pal_lut[104]=24'hf3_be_83;
		pal_lut[105]=24'he7_c8_70;
		pal_lut[106]=24'hb8_e2_63;
		pal_lut[107]=24'hff_a7_d4;
		pal_lut[108]=24'h8d_e7_be;
		pal_lut[109]=24'ha4_c9_ff;
		pal_lut[110]=24'hc8_b3_ff;
		pal_lut[111]=24'ha8_e8_70;
		pal_lut[112]=24'h00_00_00;
		pal_lut[113]=24'hfa_fa_fa;
		pal_lut[114]=24'hff_e2_e3;
		pal_lut[115]=24'hc2_ff_ff;
		pal_lut[116]=24'hff_d6_ff;
		pal_lut[117]=24'hc7_ff_c8;
		pal_lut[118]=24'hed_ed_ff;
		pal_lut[119]=24'hff_ff_95;
		pal_lut[120]=24'hff_f1_b6;
		pal_lut[121]=24'hff_fb_a3;
		pal_lut[122]=24'heb_ff_96;
		pal_lut[123]=24'hff_da_ff;
		pal_lut[124]=24'hc0_ff_f1;
		pal_lut[125]=24'hd7_fc_ff;
		pal_lut[126]=24'hfb_e6_ff;
		pal_lut[127]=24'hdb_ff_a3;

		ntsc_lut[0]=24'h00_00_00;
		ntsc_lut[1]=24'h27_27_27;
		ntsc_lut[2]=24'h60_0f_10;
		ntsc_lut[3]=24'h00_40_3f;
		ntsc_lut[4]=24'h56_04_66;
		ntsc_lut[5]=24'h00_4b_00;
		ntsc_lut[6]=24'h1a_1a_8c;
		ntsc_lut[7]=24'h35_34_00;
		ntsc_lut[8]=24'h58_1a_00;
		ntsc_lut[9]=24'h46_29_00;
		ntsc_lut[10]=24'h18_43_00;
		ntsc_lut[11]=24'h61_08_34;
		ntsc_lut[12]=24'h00_47_1e;
		ntsc_lut[13]=24'h04_29_7a;
		ntsc_lut[14]=24'h3e_09_87;
		ntsc_lut[15]=24'h08_48_00;
		ntsc_lut[16]=24'h00_00_00;
		ntsc_lut[17]=24'h37_37_37;
		ntsc_lut[18]=24'h6f_1e_1f;
		ntsc_lut[19]=24'h00_4f_4e;
		ntsc_lut[20]=24'h65_13_75;
		ntsc_lut[21]=24'h04_5a_05;
		ntsc_lut[22]=24'h2a_2a_9c;
		ntsc_lut[23]=24'h44_44_00;
		ntsc_lut[24]=24'h68_29_00;
		ntsc_lut[25]=24'h56_38_00;
		ntsc_lut[26]=24'h28_52_00;
		ntsc_lut[27]=24'h70_17_43;
		ntsc_lut[28]=24'h00_56_2e;
		ntsc_lut[29]=24'h14_38_8a;
		ntsc_lut[30]=24'h4d_19_96;
		ntsc_lut[31]=24'h17_58_00;
		ntsc_lut[32]=24'h00_00_00;
		ntsc_lut[33]=24'h43_43_43;
		ntsc_lut[34]=24'h7c_2b_2c;
		ntsc_lut[35]=24'h0b_5c_5b;
		ntsc_lut[36]=24'h72_20_82;
		ntsc_lut[37]=24'h11_67_11;
		ntsc_lut[38]=24'h36_37_a8;
		ntsc_lut[39]=24'h51_50_00;
		ntsc_lut[40]=24'h74_36_0b;
		ntsc_lut[41]=24'h62_45_00;
		ntsc_lut[42]=24'h34_5f_00;
		ntsc_lut[43]=24'h7d_24_50;
		ntsc_lut[44]=24'h0a_63_3a;
		ntsc_lut[45]=24'h21_45_96;
		ntsc_lut[46]=24'h5a_25_a3;
		ntsc_lut[47]=24'h24_65_00;
		ntsc_lut[48]=24'h00_00_00;
		ntsc_lut[49]=24'h55_55_55;
		ntsc_lut[50]=24'h8d_3c_3d;
		ntsc_lut[51]=24'h1c_6d_6c;
		ntsc_lut[52]=24'h83_31_93;
		ntsc_lut[53]=24'h22_78_22;
		ntsc_lut[54]=24'h47_48_b9;
		ntsc_lut[55]=24'h62_61_00;
		ntsc_lut[56]=24'h85_47_1c;
		ntsc_lut[57]=24'h73_56_00;
		ntsc_lut[58]=24'h45_70_00;
		ntsc_lut[59]=24'h8e_35_61;
		ntsc_lut[60]=24'h1b_74_4b;
		ntsc_lut[61]=24'h32_56_a7;
		ntsc_lut[62]=24'h6b_36_b4;
		ntsc_lut[63]=24'h35_76_00;
		ntsc_lut[64]=24'h00_00_00;
		ntsc_lut[65]=24'h79_79_79;
		ntsc_lut[66]=24'hb2_61_62;
		ntsc_lut[67]=24'h40_91_90;
		ntsc_lut[68]=24'ha7_55_b7;
		ntsc_lut[69]=24'h46_9d_47;
		ntsc_lut[70]=24'h6c_6c_de;
		ntsc_lut[71]=24'h86_86_14;
		ntsc_lut[72]=24'haa_6b_41;
		ntsc_lut[73]=24'h98_7a_21;
		ntsc_lut[74]=24'h6a_94_15;
		ntsc_lut[75]=24'hb3_59_86;
		ntsc_lut[76]=24'h3f_98_70;
		ntsc_lut[77]=24'h56_7b_cc;
		ntsc_lut[78]=24'h90_5b_d8;
		ntsc_lut[79]=24'h59_9a_22;
		ntsc_lut[80]=24'h00_00_00;
		ntsc_lut[81]=24'ha9_a9_a9;
		ntsc_lut[82]=24'he1_90_91;
		ntsc_lut[83]=24'h70_c1_c0;
		ntsc_lut[84]=24'hd7_85_e7;
		ntsc_lut[85]=24'h76_cc_76;
		ntsc_lut[86]=24'h9c_9c_ff;
		ntsc_lut[87]=24'hb6_b6_44;
		ntsc_lut[88]=24'hd9_9b_70;
		ntsc_lut[89]=24'hc7_aa_51;
		ntsc_lut[90]=24'h9a_c4_45;
		ntsc_lut[91]=24'he2_89_b5;
		ntsc_lut[92]=24'h6f_c8_a0;
		ntsc_lut[93]=24'h86_aa_fb;
		ntsc_lut[94]=24'hbf_8b_ff;
		ntsc_lut[95]=24'h89_ca_52;
		ntsc_lut[96]=24'h00_00_00;
		ntsc_lut[97]=24'hc7_c7_c7;
		ntsc_lut[98]=24'hff_af_b0;
		ntsc_lut[99]=24'h8f_e0_df;
		ntsc_lut[100]=24'hf6_a3_ff;
		ntsc_lut[101]=24'h94_eb_95;
		ntsc_lut[102]=24'hba_ba_ff;
		ntsc_lut[103]=24'hd4_d4_62;
		ntsc_lut[104]=24'hf8_b9_8f;
		ntsc_lut[105]=24'he6_c9_6f;
		ntsc_lut[106]=24'hb8_e2_63;
		ntsc_lut[107]=24'hff_a7_d4;
		ntsc_lut[108]=24'h8d_e7_be;
		ntsc_lut[109]=24'ha4_c9_ff;
		ntsc_lut[110]=24'hde_a9_ff;
		ntsc_lut[111]=24'ha8_e8_70;
		ntsc_lut[112]=24'h00_00_00;
		ntsc_lut[113]=24'hfa_fa_fa;
		ntsc_lut[114]=24'hff_e2_e3;
		ntsc_lut[115]=24'hc2_ff_ff;
		ntsc_lut[116]=24'hff_d6_ff;
		ntsc_lut[117]=24'hc7_ff_c8;
		ntsc_lut[118]=24'hed_ed_ff;
		ntsc_lut[119]=24'hff_ff_95;
		ntsc_lut[120]=24'hff_ec_c2;
		ntsc_lut[121]=24'hff_fc_a2;
		ntsc_lut[122]=24'heb_ff_96;
		ntsc_lut[123]=24'hff_da_ff;
		ntsc_lut[124]=24'hc0_ff_f1;
		ntsc_lut[125]=24'hd7_fc_ff;
		ntsc_lut[126]=24'hff_dc_ff;
		ntsc_lut[127]=24'hdb_ff_a3;
end		

always @(posedge clk)
	begin
	  rgbcolor<=pal?pal_lut[color]:ntsc_lut[color];
	end
	
assign red=rgbcolor[23:16];
assign green=rgbcolor[15:8];
assign blue=rgbcolor[7:0];

endmodule
