-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_Top
--
-- FILENAME:       tb_Top.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           6. May 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_Top is
end tb_Top;
architecture sim of tb_Top is

 component Top
	port (
		clk_i:   	in std_logic;    					--sys clock 100 MHz
		reset_i:   	in std_logic;   					--asy reset hich-act
        sw_i:   	in std_logic_vector (2 downto 0); 	-- switches
        pb_i:   	in std_logic_vector (3 downto 0);	--buttons 
		vga_o:	out std_logic_vector(13 downto 0)--vga output
	);
 end component;
 
 
 component vga_monitor
	generic(
		g_no_frames : integer range 1 to 99 := 1;
		g_path      : string                := "vga_output/"
    );
	port(
		s_reset_i     : in std_logic;
		s_vga_red_i   : in std_logic_vector(3 downto 0);
		s_vga_green_i : in std_logic_vector(3 downto 0);
		s_vga_blue_i  : in std_logic_vector(3 downto 0);
		s_vga_hsync_i : in std_logic;
		s_vga_vsync_i : in std_logic
    ); 
 end component;
 
 
  
  -- Declare the signals used stimulating the design's inputs.
	signal clk_i:	 std_logic;	
	signal en_i: 	 std_logic;				--sys clock 100 MHz
	signal reset_i:  std_logic;
	signal s_sw_i:	std_logic_vector (2 downto 0);
    signal s_pb_i:	std_logic_vector (3 downto 0);
	signal s_vga_red_i    :std_logic_vector(3 downto 0);
	signal	s_vga_green_i :std_logic_vector(3 downto 0);
	signal	s_vga_blue_i  :std_logic_vector(3 downto 0);
	signal	s_vga_hsync_i :std_logic;
	signal	s_vga_vsync_i :std_logic;
begin
  -- Instantiate the cacl_ctl design for testing
  i_Top : Top
  port map      
    (
    clk_i		=>	clk_i,
	reset_i 	=> 	reset_i,
	sw_i		=>	s_sw_i,
    pb_i		=>	s_pb_i,
	vga_o(11 downto 8)=>	s_vga_red_i,
	vga_o(7 downto 4)=>	s_vga_green_i,
	vga_o(3 downto 0)=>	s_vga_blue_i,
	vga_o(12)	=>	s_vga_vsync_i,
	vga_o(13)	=>	s_vga_hsync_i
    );
    
  i_vga_monitor : vga_monitor
  port map      
    (
		s_reset_i 	=> 	reset_i,
		s_vga_red_i =>	s_vga_red_i,
		s_vga_green_i =>	s_vga_green_i,
		s_vga_blue_i  =>	s_vga_blue_i,
		s_vga_vsync_i =>	s_vga_vsync_i,
		s_vga_hsync_i =>	s_vga_hsync_i
    );
-----------------------------------------PROCESS
	p_clk : process
	begin
		clk_i <='1';
		wait for 5 ns;
		clk_i <='0';
		wait for 5 ns;
	end process p_clk;
	
	p_sim : process
	begin
		s_sw_i <= "110";
		reset_i <= '1';
		wait for 200 ns;
		
		reset_i <= '0';
		wait for  1 sec ;

		assert false report "END OF TEST" severity failure;
	end process p_sim;
end sim;


