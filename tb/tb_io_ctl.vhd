-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_io_ctl
--
-- FILENAME:       tb_io_ctl.vhd
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
use work.pkg_sw_pb.all;

entity tb_io_ctl is
end tb_io_ctl;

architecture sim of tb_io_ctl is

  component io_ctl
  port (
		clk_i	:	in std_logic;
		en_i 	:  	in std_logic;		-- enable 25Mhz
        reset_i : 	in std_logic;       -- asy reset high_act   	
        sw_i	:	in std_logic_vector (2 downto 0); --switch input
        pb_i	:	in std_logic_vector (3 downto 0); --butons input
        swsync_o:	out std_logic_vector (2 downto 0); -- switchstate
        pbsync_o:	out std_logic_vector (3 downto 0) -- buttonstate
	);		
  end component;
 
  component prescaler
  port (
		clk_i 	:  	in std_logic;		-- clk  100Mhz
        reset_i : 	in std_logic;       -- asy reset high_act   	
        en_o 	:	out std_logic
  );	
  end component;
  -- Declare the signals used stimulating the design's inputs.
  	signal clk_i: 	 std_logic;				--sys clock 100 MHz
	signal en_i: 	 std_logic;				--sys clock 100 MHz
	signal en_o:	 std_logic;
	signal reset_i:  std_logic;
	signal sw_i:	 std_logic_vector (2 downto 0);
	signal pb_i	:	 std_logic_vector (3 downto 0);
	signal swsync_o: std_logic_vector (2 downto 0);
	signal pbsync_o: std_logic_vector (3 downto 0);
	
begin

  -- Instantiate the cacl_ctl design for testing
  i_io_ctl : io_ctl
  port map              
    (
    clk_i   => 	clk_i,			--sys clock 100 MHz
    en_i   => 	en_i,			--sys clock 100 MHz
	reset_i => 	reset_i,
	sw_i =>	sw_i,
	pb_i=>pb_i,
	swsync_o=>swsync_o,
	pbsync_o=>pbsync_o
    );
    
  i_prescaler : prescaler
  port map              
  (
    clk_i   => 	clk_i,			--sys clock 100 MHz
	reset_i => 	reset_i,
	en_o 	=>	en_i
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
		sw_i	<= "000";
		pb_i	<= "0000";
		reset_i <= '1';
		wait for 200 ns;
		
		reset_i <= '0';
		wait for  40 ns ;
		
--------button press procedure + switches
		sw(sw_i, "001");
		wait for 100 ms;
		
		pb(pb_i, "1000");
		wait for 100 ms;
		pb(pb_i, "0000");
		wait for 100 ms;
		assert false report "END OF TEST" severity failure;
	end process p_sim;
end sim;


