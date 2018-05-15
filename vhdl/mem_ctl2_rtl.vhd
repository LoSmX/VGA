-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         mem_ctl2
--
-- FILENAME:       mem_ctl2_rtl.vhd
-- 
-- ARCHITECTURE:   mem_ctl2_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           5. May 2018
--
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

architecture rtl of mem_ctl2 is

type t_state is (PIXEL, NVA,NL );

--init constants
constant c_add_max: std_logic_vector(13 downto 0) :=  "10011100001111" ;
constant c_line_ctr : integer := 100;


-- internal signals
signal s_state : t_state := NVA;
signal s_mem2_addr : std_logic_vector(13 downto 0); 
signal s_mem2_dout : std_logic_vector(11 downto 0); 
signal s_line_ctr : integer := 0;


begin
	
  p_memctl : process (clk_i, reset_i)
  begin
		if (reset_i='1') then
			s_mem2_addr <= (others => '0');
			s_line_ctr<=1;
			s_state	  <= NVA;
		elsif (clk_i'event and clk_i='1') then
			if en_i = '1' then
				case s_state is
--------------------------------------------- CASES
					when NVA =>	
						if fg_i ='1' then
							s_state<= PIXEL;
							s_line_ctr<=1;
							s_mem2_addr <= (others => '0');
						end if;
					
					when PIXEL =>
						if fg_i = '0' then
							s_state<= NL;
						end if;
						s_mem2_addr <= std_logic_vector(unsigned(s_mem2_addr)+1);
					
					when NL =>	
						if s_line_ctr /= c_line_ctr then
							if fg_i ='1' then
								s_line_ctr<= s_line_ctr+1;
								s_state<= PIXEL;
							end if;
						else 
							s_mem2_addr <= (others => '0');
							s_state<= NVA;
						end if;
				end case;
			end if;
		  end if;
  end process p_memctl;

  -- connect ROM data outputs to 10 LEDs  
  mem2_addr_o <= s_mem2_addr; 
  rgb_o <= mem2_data_i;
        
end rtl;

