-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         patterngen2
--
-- FILENAME:       patterngen2.vhd
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

entity patterngen2 is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	
end patterngen2;
