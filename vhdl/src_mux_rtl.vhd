-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         src_nux
--
-- FILENAME:       src_mux_rtl.vhd
-- 
-- ARCHITECTURE:   src_mux_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           18. March 2018
--
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

architecture rtl of src_mux is
	
	type t_state is (FG,BG);
	
	constant c_size: integer := 100;
	constant c_hight: integer := 525;
	constant c_width: integer := 800;
	
	signal s_state : t_state := BG;
	signal s_fg	   : std_logic := '0';
	signal s_pospixel: integer := 350;
	signal s_posline: integer := 212;
	signal s_pixel : 	integer := 1;
	signal s_fgpixel : 	integer := 1;
	signal s_line : 	integer := 1;
	signal s_fgline : 	integer := 0;
	
	signal s_lbp :	std_logic_vector (3 downto 0);

begin
-------------------------------Slowen
	p_src_mux :process(clk_i,reset_i)
	begin
		if reset_i = '1' then
			pixel_o <=x"000";
			s_state <=BG;
			s_pixel	  <= 1;
			s_line 	  <= 1;
			s_fgline  <= 0;
			s_fg 	  <='0';
			fg_o 	  <='0';
		elsif clk_i'event and clk_i = '1' then
			if en_i ='1' then
				case s_state is
					when BG =>
						case swsync_i(1 downto 0) is 
							when "00" =>
								pixel_o <= pattern1_i;
					
							when "01" =>
								pixel_o <= pattern2_i;
								
							when others =>
								pixel_o <= mem1_i;	
						end case;
						if s_pixel = s_pospixel and (s_line = s_posline
						    or s_fg='1')and swsync_i(2)='1' then
							s_state <= FG;
							s_fg<='1';
							s_fgpixel <= 1;
							fg_o<='1';
							s_pixel <= s_pixel+1;
						elsif s_pixel=c_width then
							s_pixel<= 1;
							if s_line/= c_hight then
								s_line <= s_line+1;
							else
								s_line <= 1;
							end if;
						else
							s_pixel <= s_pixel+1;
						end if;
					
					when FG =>
						pixel_o <= mem2_i;
						if s_fgpixel = c_size then
							s_fgline <= s_fgline +1;
							fg_o<='0';
							s_state	 <=BG;
						else 
							s_fgpixel<=s_fgpixel+1;
						end if;
						if s_fgline = c_size then
							s_fg<='0'; 
							s_fgline <=0;
						end if;
						s_pixel <= s_pixel+1;
					end case;
			end if;
		else end if;
	end process p_src_mux;
	
	p_buttons :process(clk_i,reset_i)
	begin
		if reset_i = '1' then
			s_pospixel<= 270;
			s_posline <= 190;
			s_lbp<= x"0";
		elsif clk_i'event and clk_i = '1' then
			if en_i ='1' then
				
				if pbsync_i(0)/=s_lbp(0)and pbsync_i(0) = '1'then
					s_posline<=s_posline-10;
				end if;
				
				if pbsync_i(3)/=s_lbp(3)and pbsync_i(3) = '1'then
					s_posline<=s_posline+10;
				end if;
				
				if pbsync_i(1)/=s_lbp(1)and pbsync_i(1) = '1'then
					s_pospixel<=s_pospixel-10;
				end if;
				
				if pbsync_i(2)/=s_lbp(2)and pbsync_i(2) = '1'then
					s_pospixel<=s_pospixel+10;
				end if;
				
				s_lbp<= pbsync_i;
			end if;
		else end if;
	end process p_buttons;
end rtl;
