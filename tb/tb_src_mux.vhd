-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_src_mux
--
-- FILENAME:       tb_src_mux.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           18. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_src_mux is
end tb_src_mux;

architecture sim of tb_src_mux is

 component src_mux
	port (
		clk_i	:	in std_logic;
		en_i 	:  	in std_logic;		-- enable 25Mhz
        reset_i : 	in std_logic;       -- asy reset high_act   	
        swsync_i	:	in std_logic_vector (2 downto 0); 	--switch input
        pbsync_i	:	in std_logic_vector (3 downto 0);	--butons input
        pattern1_i	: 	in std_logic_vector (11 downto 0); 	--pixel pattern1
        pattern2_i	: 	in std_logic_vector (11 downto 0); 	--pixel pattern2
        mem1_i	: 	in std_logic_vector (11 downto 0); 	--pixel pic1
        mem2_i	: 	in std_logic_vector (11 downto 0); 	--pixel pic2
        pixel_o :	out std_logic_vector (11 downto 0) --output pixel
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
	signal clk_i:	 std_logic;
	signal en_i: 	 std_logic;				--sys clock 100 MHz
	signal reset_i:  std_logic;
	signal swsync_i:	 std_logic_vector (2 downto 0);
	signal pbsync_i	:	 std_logic_vector (3 downto 0);
	signal pattern1_i :  std_logic_vector (11 downto 0); 
	signal pattern2_i :  std_logic_vector (11 downto 0);
	signal mem1_i:		std_logic_vector (11 downto 0);
	signal mem2_i:		std_logic_vector (11 downto 0);
	signal pixel_o:		std_logic_vector (11 downto 0);

begin

  -- Instantiate the cacl_ctl design for testing
  i_src_mux : src_mux
  port map      
    (
    clk_i		=>	clk_i,
    en_i   		=> 	en_i,			--sys clock 100 MHz
	reset_i 	=> 	reset_i,
	swsync_i 	=>	swsync_i,
	pbsync_i	=>	pbsync_i,
	pattern1_i 	=> 	pattern1_i,
	pattern2_i	=>	pattern2_i,
	mem1_i		=>	mem1_i,
	mem2_i		=>	mem2_i,
	pixel_o		=>	pixel_o
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
		clk_i <='1';
		wait for 5 ns;
		clk_i <='0';
		wait for 5 ns;
	end process p_clk;
	
	p_sim : process
	begin
		swsync_i	<= "000";
		pbsync_i	<= "0000";
		pattern1_i	<= x"000";
		reset_i <= '1';
		wait for 200 ns;
		
		reset_i <= '0';
		wait for  40 ns ;
		
--------button press procedure + switches
		swsync_i	<=	"000";
		wait for 100 ns;
		pattern1_i	<= x"F00";
		wait for 100 ns;
		pattern1_i	<= x"FF0";
		wait for 100 ns;
		pattern1_i	<= x"FFF";
		wait for 100 ns;
		assert false report "END OF TEST" severity failure;
	end process p_sim;
end sim;


