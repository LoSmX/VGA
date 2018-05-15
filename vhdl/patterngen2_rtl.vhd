-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         patterngen2
--
-- FILENAME:       patterngen2_rtl.vhd
-- 
-- ARCHITECTURE:   patterngen2_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           2. May 2018
--
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

architecture rtl of patterngen2 is
	type t_state is (RED, GREEN ,BLUE , NVA,NL );

	constant c_hcolor_ctr : integer := 63;
	constant c_vcolor_ctr : integer := 48;

	signal s_vcolor		: unsigned(1 downto 0) :="00";
	signal s_hcolor_ctr : integer := 0;
	signal s_vcolor_ctr : integer := 0;

	signal s_state : t_state := NVA;
begin
	p_patterngen2 :process(clk_i,reset_i)
	begin
		if reset_i = '1' then
			rgb_o <= x"000";
			s_vcolor_ctr <= 0;
			s_hcolor_ctr <= 0;
			s_vcolor	<="00";
			s_state <= NVA;
		elsif clk_i'event and clk_i = '1' then
			if en_i ='1' then				
---------------------------------------------------- CASE		
				case s_state is
					when NVA =>	
						if hva_i='1' and vva_i='1' then
							s_vcolor_ctr <= 0;
							s_hcolor_ctr <= 0;
							s_vcolor<="00";
							rgb_o<=x"F00";
							s_state <= RED;
						end if;
						
					when RED =>	
						rgb_o<=x"F00";
						if hva_i='0' then			--end of line
							s_hcolor_ctr <= 0;
							if vva_i = '1' then				--next line
								s_vcolor_ctr<=s_vcolor_ctr+1;
								rgb_o<=x"000";
								s_state <= NL;
							else 							--end of frsme
								s_vcolor_ctr<=0;
								rgb_o<=x"000";
								s_state <= NVA;
							end if;
						else
							if s_hcolor_ctr = c_hcolor_ctr then --if colorchange
								s_hcolor_ctr <= 0;
								rgb_o<=x"0F0";
								s_state <= GREEN;
							else
								s_hcolor_ctr <= s_hcolor_ctr+1;
							end if;
						end if;
					
					when GREEN =>	
						rgb_o<=x"0F0";
						if hva_i='0' then			--end of line
							s_hcolor_ctr <= 0;
							if vva_i = '1' then				--next line
								s_vcolor_ctr<=s_vcolor_ctr+1;
								rgb_o<=x"000";
								s_state <= NL;
							else 							--end of frsme
								s_vcolor_ctr<=0;
								rgb_o<=x"000";
								s_state <= NVA;
							end if;
						else
							if s_hcolor_ctr = c_hcolor_ctr then --if colorchange
								s_hcolor_ctr <= 0;
								rgb_o<=x"00F";
								s_state <= BLUE;
							else
								s_hcolor_ctr <= s_hcolor_ctr+1;
							end if;
						end if;
						
					when BLUE =>	
						rgb_o<=x"00F";
						if hva_i='0' then			--end of line
							s_hcolor_ctr <= 0;
							if vva_i = '1' then				--next line
								s_vcolor_ctr<=s_vcolor_ctr+1;
								rgb_o<=x"000";
								s_state <= NL;
							else 							--end of frsme
								s_vcolor_ctr<=0;
								rgb_o<=x"000";
								s_state <= NVA;
							end if;
						else
							if s_hcolor_ctr = c_hcolor_ctr then --if colorchange
								s_hcolor_ctr <= 0;
								rgb_o<=x"F00";
								s_state <= RED;
							else
								s_hcolor_ctr <= s_hcolor_ctr+1;
							end if;
						end if;
						
					when NL =>	
						rgb_o<=x"000";
						if s_vcolor_ctr = c_vcolor_ctr then --if colorchange
								s_vcolor_ctr <= 0;
								if	s_vcolor ="10" then
									s_vcolor<="00";
								else
									s_vcolor<=s_vcolor+1;
								end if;
						end if;
						if hva_i='1' then
							if s_vcolor = "00" then
								s_state <= RED;
								rgb_o<=x"F00";
							elsif s_vcolor = "01" then
								rgb_o<=x"0F0";
								s_state <= GREEN;
							else
								rgb_o<=x"00F";
								s_state <= BLUE;
							end if;
						end if;
				end case;			
			end if;				
		end if;
	end process p_patterngen2;
end rtl;
