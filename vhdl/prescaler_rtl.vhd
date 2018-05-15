-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         prescaler
--
-- FILENAME:       presaler.vhd
-- 
-- ARCHITECTURE:   prescaler_rtl
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

architecture rtl of prescaler is
	constant C_ENCOUNTVAL : std_logic_vector(1 downto 0) := "11";

	signal s_enctr	: std_logic_vector(1 downto 0);
	signal s_en     : std_logic;
	
begin
-------------------------------Slowen
	p_slowen :process(clk_i,reset_i)
	begin
		if reset_i = '1' then
			s_enctr <="00";
			s_en <= '0';
		elsif clk_i'event and clk_i = '1' then
			if s_enctr = C_ENCOUNTVAL then
				s_en <= '1';
				s_enctr<="00";
			else
				s_en <= '0';
				s_enctr <= std_logic_vector(unsigned(s_enctr) + 1);
			end if;
		else end if;
	end process p_slowen;
	en_o <= s_en;
end rtl;
