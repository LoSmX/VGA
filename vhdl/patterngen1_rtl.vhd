-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         patterngen1
--
-- FILENAME:       patterngen1_rtl.vhd
-- 
-- ARCHITECTURE:   patterngen1_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           16. April 2018
--
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

architecture rtl of patterngen1 is
	type t_state is (RED, GREEN ,BLUE ,BLACK, NVA,NL );

	constant c_pixel_ctr : integer := 639;	-- pixel per line
	constant c_line_ctr : integer := 481;	
	constant c_color_ctr : integer := 39;	
	
	signal s_pixel_ctr : integer := 0;
	signal s_line_ctr  : integer  := 0;
	signal s_color_ctr : integer := 0;
	signal s_state : t_state := NVA;
begin
-------------------------------Slowen
	p_patterngen1 :process(clk_i,reset_i)
	begin
		if reset_i = '1' then
			rgb_o <= x"000";
			s_line_ctr <= 0;
			s_pixel_ctr <=  0;
			s_color_ctr <= 0;
			s_state <= NVA;
		elsif clk_i'event and clk_i = '1' then
			if en_i ='1' then				
---------------------------------------------------- CASE		
				case s_state is
					when NVA =>	
						if hva_i='1' and vva_i='1' then
							s_line_ctr <= 0;
							s_pixel_ctr <=  0;
							s_color_ctr <= 0;
							s_state <= RED;
							rgb_o<=x"F00";
						end if;
						
					when RED =>	
						rgb_o<=x"F00";
						if s_color_ctr = c_color_ctr then
							s_color_ctr <= 0;
							s_state <= GREEN;
						else
							s_color_ctr<=s_color_ctr+1;
						end if;
						s_pixel_ctr<=s_pixel_ctr+1;
						
					when GREEN =>	
						rgb_o<=x"0F0";
						if s_color_ctr = c_color_ctr then
							s_color_ctr <= 0;
							s_state <= BLUE;
						else
							s_color_ctr<=s_color_ctr+1;
						end if;
						s_pixel_ctr<=s_pixel_ctr+1;
						
					when BLUE =>	
						rgb_o<=x"00F";
						if s_color_ctr = c_color_ctr then
							s_color_ctr <= 0;
							s_state <= BLACK;
						else
							s_color_ctr<=s_color_ctr+1;
						end if;
						s_pixel_ctr<=s_pixel_ctr+1;
						
					when BLACK =>	
						rgb_o<=x"000";
						if s_color_ctr = c_color_ctr then
							if hva_i='0' then
								s_color_ctr <= 0;
								s_pixel_ctr <= 0;
								if vva_i = '1' then
									s_line_ctr<=s_line_ctr+1;
									s_state <= NL;
								else 
									s_line_ctr<=0;
									s_state <= NVA;
								end if;
							else
								s_color_ctr <= 0;
								s_state <= RED;
							end if;
						else
							s_color_ctr<=s_color_ctr+1;
						end if;
						s_pixel_ctr<=s_pixel_ctr+1;
						
					when NL =>	
						rgb_o<=x"000";
						if hva_i='1' then
							s_state <= RED;
							rgb_o<=x"F00";
						end if;
				end case;			
			end if;				
		end if;
	end process p_patterngen1;
end rtl;
