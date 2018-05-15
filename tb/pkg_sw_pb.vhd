-------------------------------------------------------------------------------
--                                                                      
--                        VGA CONTROLLER
--  
-------------------------------------------------------------------------------
--                                                                      
-- PACKAGE:			pkg_sw_pb        
--
-- FILENAME: 		pkg_sw_pb.vhd
-- 
-- ENGINEER:       Milos JOVANOVIC
--
-- DATE:           15. March 2018
--
--
-------------------------------------------------------------------------------
library IEEE;
use	IEEE.std_logic_1164.all;

package pkg_sw_pb is
	procedure sw(
		signal sw_state	: out std_logic_vector (2 downto 0);
		constant v 		: in  std_logic_vector (2 downto 0)
	);
	procedure pb(
		signal pb_state	: out std_logic_vector (3 downto 0);
		constant v 		: in  std_logic_vector (3 downto 0)
	);
end pkg_sw_pb;

package body pkg_sw_pb is
	procedure sw(
		signal sw_state	: out std_logic_vector (2 downto 0);
		constant v 		: in  std_logic_vector (2 downto 0)
	)is 
	begin
		sw_state<= v;
		wait for 200 us;
		sw_state<= not(v);
		wait for 200 us;
		sw_state<= v;
	end sw;
	
	procedure pb(
		signal pb_state	: out std_logic_vector (3 downto 0);
		constant v 		: in  std_logic_vector (3 downto 0)
	)is 
	begin
		pb_state<= v;
		wait for 200 us;
		pb_state<= not(v);
		wait for 200 us;
		pb_state<= v;
	end pb;
		
	
end package body pkg_sw_pb;

