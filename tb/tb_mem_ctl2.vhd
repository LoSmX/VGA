-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         tb_mem_ctl2
--
-- FILENAME:       b_mem_ctl2.vhd
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

entity tb_mem_ctl2 is
end tb_mem_ctl2;

architecture sim of tb_mem_ctl2 is

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
 
 component mem_ctl1
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	 
 end component;
 
 component mem_ctl2
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        fg_i 	:	in std_logic;
        rgb_o	:	out std_logic_vector (0 to 11)
	);	
 end component;
 
 component src_mux
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
 end component;
  
  -- Declare the signals used stimulating the design's inputs.
	signal clk_i:	 std_logic;	
	signal en_i: 	 std_logic;				--sys clock 100 MHz
	signal reset_i:  std_logic;
	signal s_swsync:	std_logic_vector (2 downto 0);
    signal s_pbsync:	std_logic_vector (3 downto 0);
    signal s_pattern1:	 std_logic_vector (11 downto 0);
    signal s_pattern2:	 std_logic_vector (11 downto 0);
	signal s_rgb_i:	 std_logic_vector (11 downto 0);
	signal s_mem1:	 std_logic_vector (11 downto 0);
	signal s_mem2:	 std_logic_vector (11 downto 0);
	signal s_vga_red_i    :std_logic_vector(3 downto 0);
	signal	s_vga_green_i :std_logic_vector(3 downto 0);
	signal	s_vga_blue_i  :std_logic_vector(3 downto 0);
	signal	s_vga_hsync_i :std_logic;
	signal	s_vga_vsync_i :std_logic;
	signal 	s_vva_o		:  std_logic;
	signal 	s_hva_o		:  std_logic;
	signal  s_fg_o		:  std_logic;
begin
  -- Instantiate the cacl_ctl design for testing
  i_vga_ctl : vga_ctl
  port map      
    (
    clk_i		=>	clk_i,
    en_i   		=> 	en_i,			--sys clock 100 MHz
	reset_i 	=> 	reset_i,
	rgb_i		=>	s_rgb_i,
	vga_o(11 downto 8)=>	s_vga_red_i,
	vga_o(7 downto 4)=>	s_vga_green_i,
	vga_o(3 downto 0)=>	s_vga_blue_i,
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
	
	i_mem_ctl1 : mem_ctl1
  port map      
    (
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i,       -- asy reset high_act   	
        vva_i	=> s_vva_o,
        hva_i	=> s_hva_o,
        rgb_o	=> s_mem1
    );
    
    i_mem_ctl2 : mem_ctl2
  port map      
    (
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i,       -- asy reset high_act   	
        fg_i	=> s_fg_o,
        rgb_o	=> s_mem2
    );
    
    i_src_mux	: src_mux
    port map(
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i, 
        swsync_i	=>	s_swsync,
        pbsync_i	=>	s_pbsync,
        pattern1_i	=>	s_pattern1,
        pattern2_i	=>	s_pattern2,
        mem1_i	=>	s_mem1,
        mem2_i	=>	s_mem2,
        fg_o 	=>	s_fg_o,
        pixel_o => 	s_rgb_i
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
		s_swsync <= "110";
		reset_i <= '1';
		wait for 200 ns;
		
		reset_i <= '0';
		wait for  1 sec ;

		assert false report "END OF TEST" severity failure;
	end process p_sim;
end sim;


