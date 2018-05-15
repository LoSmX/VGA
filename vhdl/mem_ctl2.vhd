-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         mem_ctl2
--
-- FILENAME:       mem_ctl2.vhd
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

entity mem_ctl2 is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        fg_i 	:	in std_logic;
        mem2_data_i:in std_logic_vector(11 downto 0);
        rgb_o	:	out std_logic_vector (11 downto 0);
        mem2_addr_o: out std_logic_vector(13 downto 0)
	);	
end mem_ctl2;
