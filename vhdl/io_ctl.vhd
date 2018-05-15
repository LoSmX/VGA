-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         io_ctr
--
-- FILENAME:       io_ctl.vhd
-- 
-- ARCHITECTURE:   io_ctl_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           5. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity io_ctl is
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        sw_i	:	in std_logic_vector (2 downto 0); --switch input
        pb_i	:	in std_logic_vector (3 downto 0); --butons input
        swsync_o:	out std_logic_vector (2 downto 0); -- switchstate
        pbsync_o:	out std_logic_vector (3 downto 0) -- buttonstate
	);	
end io_ctl;
