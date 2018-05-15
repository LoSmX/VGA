-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         patterngen1
--
-- FILENAME:       patterngen1.vhd
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

entity patterngen1 is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	
end patterngen1;
