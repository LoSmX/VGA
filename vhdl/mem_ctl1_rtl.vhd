-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         mem_ctl1
--
-- FILENAME:       mem_ctl1_rtl.vhd
-- 
-- ARCHITECTURE:   mem_ctl1_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           4. May 2018
--
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

architecture rtl of mem_ctl1 is

type t_state is (PIXEL, NVA,NL );


--init constants

constant c_picture_width : integer := 319;
constant c_frame_width : integer := 639;
constant c_picture_hight : integer := 240;
constant c_frame_hight : integer := 480;
-- internal signals
signal s_state : t_state := NVA;
signal s_mem1_addr : std_logic_vector(16 downto 0); 
signal s_mem1_dout : std_logic_vector(11 downto 0); 
signal s_picture_width : integer := 1;
signal s_picture_hight : integer := 1;

begin
  p_memctl : process (clk_i, reset_i)
  begin
		if (reset_i='1') then
			s_picture_width <= 0;
			s_picture_hight <= 0;
			s_mem1_addr <= (others => '0');
			s_state	  <= NVA;
		elsif (clk_i'event and clk_i='1') then
			if en_i = '1' then
				case s_state is
--------------------------------------------- CASES
					when NVA =>	
						if hva_i='1' and vva_i='1' then
							s_mem1_addr <= (others => '0');
							s_picture_width <= 0;
							s_picture_hight <= 1;
							s_state<= PIXEL;
							--s_mem1_addr <= std_logic_vector(unsigned(s_mem1_addr)+1);

						else
							s_mem1_addr <= (others => '0');
						end if;
					
					when PIXEL =>	
						if s_picture_width = c_picture_width then
							s_picture_width<=s_picture_width+1;
							s_mem1_addr <= std_logic_vector(unsigned(s_mem1_addr)- c_picture_width); 
						elsif s_picture_width = c_frame_width then
							s_picture_width<=0;
							s_state<= NL;
						else
							s_picture_width<=s_picture_width+1;
							s_mem1_addr <= std_logic_vector(unsigned(s_mem1_addr)+1);
						end if;
						
					when NL =>	
						if s_picture_hight = c_picture_hight then
							if hva_i='1' then	
								s_picture_hight<=s_picture_hight+1;
								s_mem1_addr <= (others => '0');	
								s_picture_width<= 0;
								s_state<= PIXEL;
							end if;
						elsif s_picture_hight = c_frame_hight then
							s_picture_width<=0;
							s_mem1_addr <= (others => '0');
							s_state<= NVA;
						elsif hva_i='1' then
							s_picture_hight<=s_picture_hight+1;
							s_mem1_addr <= std_logic_vector(unsigned(s_mem1_addr)+1);
							s_state<= PIXEL;
						end if;

	
				end case;
			end if;
		  end if;
  end process p_memctl;

  -- connect ROM data outputs to 10 LEDs 
  mem1_addr_o <=s_mem1_addr; 
  rgb_o <= mem1_data_i;
        
end rtl;

