-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         io_ctr
--
-- FILENAME:       io_ctl_rtl.vhd
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
USE ieee.numeric_std.ALL;

architecture rtl of io_ctl is
	constant C_ENCOUNTVAL : integer := 25000;
	signal s_1khzen	: std_logic;
	signal s_enctr	: integer := 0;
	signal s_swsync : std_logic_vector(2 downto 0);
	signal s_pbsync	: std_logic_vector(3 downto 0);
	
begin
----------------------SLOWEN
	p_slowen :process(clk_i,reset_i)
		begin
			if reset_i = '1' then
				s_enctr <= 0;
				s_1khzen <= '0';
			elsif clk_i'event and clk_i = '1' then
				if en_i ='1' then
					if s_enctr = C_ENCOUNTVAL then
						s_1khzen <= '1';
						s_enctr<= 0;
					else
						s_1khzen <= '0';
						s_enctr <= s_enctr + 1;
					end if;
				end if;
			else end if;
		end process p_slowen;
----------------------------------Debounce
	p_debounce : process (clk_i,reset_i)
	variable v_swsync : std_logic_vector(2 downto 0) := "000";
	variable v_pbsync : std_logic_vector(3 downto 0):= "0000";
	begin
		if reset_i = '1' then
			s_swsync<= "000";
			s_pbsync<= "0000";
		elsif clk_i'event and clk_i = '1' then
			if s_1khzen = '1' then
				if not(s_swsync = sw_i) then
					if v_swsync = sw_i then
						s_swsync <= v_swsync;
					else
						v_swsync := sw_i;
					end if;
				else
					v_swsync := s_swsync;
				end if;
				if not(s_pbsync = pb_i) then
					if v_pbsync = pb_i then
						s_pbsync <= v_pbsync;
					else
						v_pbsync := pb_i;
					end if;
				else
					v_pbsync := s_pbsync;
				end if;
			end if;
		else end if;
	end process p_debounce;
	swsync_o <= s_swsync;
	pbsync_o <= s_pbsync; 

end rtl;
