-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         Top
--
-- FILENAME:       Top_struc.vhd
-- 
-- ARCHITECTURE:   Top_struc
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           5. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

architecture struc of Top is

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
 
 component mem_ctl1
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        mem1_data_i:in std_logic_vector(11 downto 0);
        mem1_addr_o: out std_logic_vector(16 downto 0);
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	 
 end component;
 
 component mem_ctl2
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        fg_i 	:	in std_logic;
        rgb_o	:	out std_logic_vector (0 to 11);
        mem2_data_i:in std_logic_vector(11 downto 0);
        mem2_addr_o: out std_logic_vector(13 downto 0)
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
 
 component patterngen1
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	 
 end component;
 
 component patterngen2
	port (
		en_i 	:  	in std_logic;		-- enable 25Mhz
		clk_i	:	in std_logic;
        reset_i : 	in std_logic;       -- asy reset high_act   	
        vva_i	:	in std_logic;
        hva_i	:	in std_logic;
        rgb_o	:	out std_logic_vector (11 downto 0)
	);	 
 end component;
 
 component mem1 is
  port(
    clka  : in  std_logic; -- ROM clock
    addra : in  std_logic_vector(16 downto 0); -- ROM address
    douta : out std_logic_vector(11 downto 0) -- ROM data outputs
    );
end component;

component mem2 is
  port(
    clka  : in  std_logic; -- ROM clock
    addra : in  std_logic_vector(13 downto 0); -- ROM address
    douta : out std_logic_vector(11 downto 0) -- ROM data outputs
    );
end component;
  

  -- Declare the signals of prescaler
	
	signal en_i: 	 std_logic;				--sys clock 100 MHz
	signal s_swsync:	std_logic_vector (2 downto 0);
    signal s_pbsync:	std_logic_vector (3 downto 0);
    signal s_sw_i:	std_logic_vector (2 downto 0);
    signal s_pb_i:	std_logic_vector (3 downto 0);
    signal s_pattern1:	 std_logic_vector (11 downto 0);
    signal s_pattern2:	 std_logic_vector (11 downto 0);
	signal s_rgb_i:	 std_logic_vector (11 downto 0);
	signal s_mem1:	 std_logic_vector (11 downto 0);
	signal s_mem2:	 std_logic_vector (11 downto 0);
	signal s_vva_o		:  std_logic;
	signal s_hva_o		:  std_logic;
	signal s_fg_o		:  std_logic;
	signal s_mem1_addr : std_logic_vector(16 downto 0); 
	signal s_mem1_dout : std_logic_vector(11 downto 0);
	signal s_mem2_addr : std_logic_vector(13 downto 0); 
	signal s_mem2_dout : std_logic_vector(11 downto 0);  
	
begin

  -- Instantiate the io_ctl
  i_io_ctl : io_ctl
  port map(
		clk_i		=>	clk_i,
		en_i 	=> en_i,					--sys clock 100 MHz
		reset_i => reset_i,
		sw_i	=> sw_i,
		pb_i	=> pb_i,
		swsync_o => s_swsync,
		pbsync_o => s_pbsync
	);

  -- Instantiate the prescaler
  i_prescaler : prescaler
  port map(
		clk_i  	=> clk_i,  	--sys clock 100 MHz
		reset_i => reset_i,
		en_o 	=> en_i
	);

  i_vga_ctl : vga_ctl
  port map(
    clk_i		=>	clk_i,
    en_i   		=> 	en_i,			--sys clock 100 MHz
	reset_i 	=> 	reset_i,
	rgb_i		=>	s_rgb_i,
	vga_o		=>	vga_o,
	hva_o		=>	s_hva_o,
	vva_o		=>	s_vva_o
    );
    
    i_mem_ctl1 : mem_ctl1
	port map(
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i,       -- asy reset high_act   	
        vva_i	=> s_vva_o,
        hva_i	=> s_hva_o,
        rgb_o	=> s_mem1,
        mem1_addr_o => s_mem1_addr,
        mem1_data_i => s_mem1_dout
    );
    
    i_mem_ctl2 : mem_ctl2
	port map(
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i,       -- asy reset high_act   	
        fg_i	=> s_fg_o,
        rgb_o	=> s_mem2,
        mem2_addr_o =>s_mem2_addr,
        mem2_data_i =>s_mem2_dout
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
	
	i_paterngen1 : patterngen1
  port map      
    (
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i,       -- asy reset high_act   	
        vva_i	=> s_vva_o,
        hva_i	=> s_hva_o,
        rgb_o	=> s_pattern1
    );
    
	i_paterngen2 : patterngen2
  port map      
    (
		en_i 	=> en_i,	-- enable 25Mhz
		clk_i	=> clk_i,
        reset_i => reset_i,       -- asy reset high_act   	
        vva_i	=> s_vva_o,
        hva_i	=> s_hva_o,
        rgb_o	=> s_pattern2
    );
	
	i_mem2 : mem2
    port map(
      clka  => clk_i,
      addra => s_mem2_addr,
      douta => s_mem2_dout
    );
    
    i_mem1 : mem1
    port map(
      clka  => clk_i,
      addra => s_mem1_addr,
      douta => s_mem1_dout
    );
end struc;
