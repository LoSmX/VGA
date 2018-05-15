-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- ENTITY:         vga_ctr
--
-- FILENAME:       vga_ctl_rtl.vhd
-- 
-- ARCHITECTURE:   vga_ctl_rtl
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           19. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

architecture rtl of vga_ctl is

	type t_state is (BP, FP, SYNC,VA );
	
	constant c_pixel_ctr : integer := 639;	-- pixel per line
	constant c_hfp_ctr : integer := 15;		--horizontal front porch
	constant c_hsync_ctr : integer := 95; 	--horizontal sync
	constant c_hbp_ctr : integer := 47; 	--horizontal back porch
	
	constant c_vsync_ctr : integer := 1599; 	--vertical sync
	constant c_vfp_ctr : integer := 7999;		--horizontal front porch
	constant c_vbp_ctr : integer := 26399; 	--horizontal back porch
	constant c_vva_ctr : integer := 383999;	-- pixel per line

	
	signal s_hstate	:	t_state	:=	SYNC;
	signal s_vstate	:	t_state	:=	SYNC;
	signal s_hsync_ctr 	: integer := 0;	--hcounter
	signal s_vsync_ctr 	: integer := 0; --vcouter
	signal s_vga_o		: std_logic_vector (13 downto 0); --hsync vsync red green blue


	
begin
------------------------ VSYNC -----------------------------------------
	p_vsync : process (clk_i,reset_i)
	begin
		if reset_i = '1' then
			s_vga_o(12)<='1';
			vva_o<='0';
			s_vsync_ctr <= 0;
			s_vstate <= SYNC;
		elsif clk_i'event and clk_i = '1' then
			if en_i ='1' then
				case s_vstate is
	---------------------------------------------------- CASE
					when SYNC =>
						s_vga_o(12)<='1';
						if s_vsync_ctr = c_vsync_ctr then
							s_vsync_ctr<=0;
							s_vga_o(12)<='1';
							s_vstate <= BP;
						else
							s_vsync_ctr<= s_vsync_ctr+1;
						end if;
						
					when BP =>
						s_vga_o(12)<='0';
						if s_vsync_ctr = c_vbp_ctr then
							s_vsync_ctr<=0;
							vva_o<='1';
							s_vga_o(12)<='0';
							s_vstate <= VA;
						else
							s_vsync_ctr<= s_vsync_ctr+1;
						end if;
						
					when VA =>
						s_vga_o(12)<='0';
						if s_vsync_ctr = c_vva_ctr then
							s_vstate <= FP;
							vva_o<='0';
							s_vsync_ctr <= 0;
						else
							s_vsync_ctr<= s_vsync_ctr+1;
						end if;
						
					when FP =>
						s_vga_o(12)<='0';
						if s_vsync_ctr = c_vfp_ctr then
							s_vsync_ctr<=0;
							s_vga_o(12)<='0';
							s_vstate <= SYNC;
						else
							s_vsync_ctr<= s_vsync_ctr+1;
						end if;
					
					when others =>
						s_vstate <= SYNC;
	--------------------------------------------------- CASE END
				end case;
			end if;
		end if;
	end process p_vsync;
	vga_o(12)<= s_vga_o(12);
	
---------------------Hsync and pixel------------------------------------
	p_hsync : process (clk_i,reset_i)
	begin
		if reset_i = '1' then
			hva_o<='0';
			s_vga_o(13)<='1';
			s_vga_o(11 downto 0)<= x"000";
			s_hsync_ctr <= 0;
			s_hstate <= SYNC;
		elsif clk_i'event and clk_i = '1' then
			if en_i='1' then
---------------------------------------------------- CASE
				case s_hstate is
					when SYNC =>
						s_vga_o(13)<='1';
						if s_hsync_ctr = c_hsync_ctr then
							s_hsync_ctr<=0;
							s_vga_o(13)<='1';
							s_hstate <= BP;
						else
							s_hsync_ctr<= s_hsync_ctr+1;
						end if;
						
					when BP =>
						s_vga_o(13)<='0';
						if s_hsync_ctr = c_hbp_ctr then
							s_hsync_ctr<=0;
							s_vga_o(13)<='0';
							hva_o<='1';
							s_hstate <= VA;
						else
							s_hsync_ctr<= s_hsync_ctr+1;
						end if;
						
					when VA =>
						s_vga_o(13)<='0';
						if s_vstate = VA then
							s_vga_o (11 downto 0) <= rgb_i;
						end if;
						if s_hsync_ctr = c_pixel_ctr then
							s_hstate <= FP;
							hva_o<='0';
							s_vga_o (11 downto 0) <= x"000";
							s_hsync_ctr <= 0;
						else
							s_hsync_ctr<= s_hsync_ctr+1;
						end if;
						
					when FP =>
						s_vga_o(13)<='0';
						if s_hsync_ctr = c_hfp_ctr then
							s_hsync_ctr<=0;
							s_vga_o(13)<='0';
							s_hstate <= SYNC;
						else
							s_hsync_ctr<= s_hsync_ctr+1;
						end if;
						
					when others =>
						s_hstate <= SYNC;
	---------------------------------------------------- CASE END
				end case;
			end if;
		end if;
	end process p_hsync;
	vga_o(13) <= s_vga_o(13);
	vga_o(11 downto 0) <= s_vga_o(11 downto 0);

end rtl;
