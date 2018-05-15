-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_vga_ctl
--
-- FILENAME:       tb_vga_ctl.vhd
-- 
-- ARCHITECTURE:   sim
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           4. April 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_vga_ctl is
end tb_vga_ctl;

architecture sim of tb_vga_ctl is

 component vga_ctl
	port (
		clk_i	:	in std_logic;
		en_i 	:  	in std_logic;		-- enable 25Mhz
        reset_i : 	in std_logic;       -- asy reset high_act   	
        rgb_i	:	in std_logic_vector(11 downto 0);
        vga_o	:	out std_logic_vector (13 downto 0);
        vva_o	:	out std_logic;
        hva_o	:	out	std_logic
	);	
 end component;
 
 component prescaler
  port (
		clk_i 	:  	in std_logic;		-- clk  100Mhz
        reset_i : 	in std_logic;       -- asy reset high_act   	
        en_o 	:	out std_logic
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
	signal rgb_i:	 std_logic_vector (11 downto 0);
	signal s_vga_red_i    :std_logic_vector(3 downto 0);
	signal	s_vga_green_i :std_logic_vector(3 downto 0);
	signal	s_vga_blue_i  :std_logic_vector(3 downto 0);
	signal	s_vga_hsync_i :std_logic;
	signal	s_vga_vsync_i :std_logic;
	signal 	s_vva_o		:  std_logic;
	signal 	s_hva_o		:  std_logic;
begin
  -- Instantiate the cacl_ctl design for testing
  i_vga_ctl : vga_ctl
  port map      
    (
    clk_i		=>	clk_i,
    en_i   		=> 	en_i,			--sys clock 100 MHz
	reset_i 	=> 	reset_i,
	rgb_i		=>	rgb_i,
	vga_o(3 downto 0)=>	s_vga_red_i,
	vga_o(7 downto 4)=>	s_vga_green_i,
	vga_o(11 downto 8)=>	s_vga_blue_i,
	vga_o(12)	=>	s_vga_vsync_i,
	vga_o(13)	=>	s_vga_hsync_i,
	hva_o		=>	s_hva_o,
	vva_o		=>	s_vva_o
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
		rgb_i	<= x"0ff";
		reset_i <= '1';
		wait for 200 ns;
		
		reset_i <= '0';
		wait for  1 sec ;

		assert false report "END OF TEST" severity failure;
	end process p_sim;
end sim;


