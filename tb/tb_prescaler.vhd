-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_prescaler
--
-- FILENAME:       tb_presacler.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           13. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_prescaler is
end tb_prescaler;

architecture sim of tb_prescaler is

  component prescaler
  port (
		clk_i 	:  	in std_logic;		-- clk  100Mhz
        reset_i : 	in std_logic;       -- asy reset high_act   	
        en_o 	:	out std_logic
	);	
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
	signal clk_i: 	std_logic;				--sys clock 100 MHz
	signal reset_i: std_logic;
	signal en_o	:	std_logic;
	
begin

  -- Instantiate the cacl_ctl design for testing
  i_prescaler : prescaler
  port map              
    (
    clk_i   => 	clk_i,			--sys clock 100 MHz
	reset_i => 	reset_i,
	en_o 	=>	en_o
    );
	
	p_clk : process
	begin
		clk_i <='0';
		wait for 5 ns;
		clk_i <='1';
		wait for 5 ns;
	end process p_clk;
	
	p_sim : process
	begin
		reset_i <= '1';
		wait for 40 ns;
		reset_i <= '0';
		wait for 1 ms ;
		assert false report "END OF TEST" severity failure;
	end process p_sim;
end sim;


