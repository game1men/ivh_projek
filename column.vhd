----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:13 04/17/2022 
-- Design Name: 
-- Module Name:    column - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity column is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           INIT_STATE : in  STD_LOGIC_VECTOR (7 downto 0);
			  STATE : out  STD_LOGIC_VECTOR (7 downto 0);
           NEIGH_LEFT : in  STD_LOGIC_VECTOR (7 downto 0);
           NEIGH_RIGHT : in  STD_LOGIC_VECTOR (7 downto 0);
           DIRECTION : in  STD_LOGIC;
           EN : in  STD_LOGIC := '0');
end column;

architecture Behavioral of column is



begin
	

	
	process (CLK) begin
	
	
	
		if rising_edge(CLK) then
			if RESET = '1' then
				STATE <=INIT_STATE;
			else
				if EN = '1' then 
					if DIRECTION = '0' then
		
						STATE <=NEIGH_LEFT ;
					else 
						STATE <=NEIGH_RIGHT;
					end if;
				end if;
			end if;
		end if;
		
	end process;
	


end Behavioral;

