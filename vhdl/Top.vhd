-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         Top
--
-- FILENAME:       Top.vhd
-- 
-- ARCHITECTURE:   Top_struc
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           5. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Top is
	port (
		clk_i:   	in std_logic;    					--sys clock 100 MHz
		reset_i:   	in std_logic;   					--asy reset hich-act
        sw_i:   	in std_logic_vector (2 downto 0); 	-- switches
        pb_i:   	in std_logic_vector (3 downto 0);	--buttons 
		vga_o:	out std_logic_vector(13 downto 0)--vga output
	);
end Top;

