-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         src_mux
--
-- FILENAME:       src_mux.vhd
-- 
-- ARCHITECTURE:   src_mux_rtl.vhd
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           5. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity src_mux is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        swsync_i	:	in std_logic_vector (2 downto 0); 	--switch input
        pbsync_i	:	in std_logic_vector (3 downto 0);	--butons input
        pattern1_i	: 	in std_logic_vector (11 downto 0); 	--pixel pattern1
        pattern2_i	: 	in std_logic_vector (11 downto 0); 	--pixel pattern2
        mem1_i	: 	in std_logic_vector (11 downto 0); 	--pixel pic1
        mem2_i	: 	in std_logic_vector (11 downto 0); 	--pixel pic2
        fg_o :	out std_logic; --output pixel
        pixel_o :	out std_logic_vector (11 downto 0) --output pixel
	);	
end src_mux;
