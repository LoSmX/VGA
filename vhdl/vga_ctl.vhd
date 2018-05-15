-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         vga_ctl
--
-- FILENAME:       vga_ctl.vhd
-- 
-- ARCHITECTURE:   vga_ctl_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           19. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity vga_ctl is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        rgb_i	:	in std_logic_vector(11 downto 0);
        vga_o	:	out std_logic_vector (13 downto 0); --hsync vsync red green blue
        vva_o	:	out std_logic;
        hva_o	:	out	std_logic
	);	
end vga_ctl;
