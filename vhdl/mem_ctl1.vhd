-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         mem_ctl1
--
-- FILENAME:       mem_ctl1.vhd
-- 
-- ARCHITECTURE:   mem_ctl1_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           2. May 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity mem_ctl1 is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        mem1_data_i:in std_logic_vector(11 downto 0);
        mem1_addr_o: out std_logic_vector(16 downto 0);
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	
end mem_ctl1;
