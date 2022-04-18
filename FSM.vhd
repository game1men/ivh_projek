----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:56 04/18/2022 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
port(
   CLK : in std_logic;
	RST : in std_logic;
   RST_columns : out std_logic;
   EN : out std_logic;
	DIR : out std_logic;
	ROT : in std_logic_vector(5 downto 0);
   arr : out std_logic_vector(127 downto 0);
	 cntRomIndex : in std_logic_vector(1 downto 0);
	 incRom : out std_logic
   );
end FSM;

architecture Behavioral of FSM is
	type STATE_T is (START,RIGHT,LEFT,ANIMATION);
	signal test : std_logic_vector(127 downto 0)  := "10000000100000001111111110000000100000000100011010011001011000101000000110011001111111111000000010000000111111111000000010000000";
   signal anim : std_logic_vector(127 downto 0) := "01010101101010100101010110101010010101011010101001010101101010100101010110101010010101011010101001010101101010100101010110101010";
	signal state : STATE_T := START;
begin


ROM: entity work.rom(behavioral)
		port map(
		address => cntRomIndex,
	data =>test
		);
	
process (CLK) begin 
		if rising_edge(CLK) then
		if RST = '1' then
				state <= START;
				RST_columns <= '1'; EN <='0'; incRom<='0';
				arr <= test;
			else
				
			case state is
					when START =>
						RST_columns <= '1'; EN <='0'; 	arr <= test; incRom<='0';
						if conv_integer(ROT) = 2 then
						state <= RIGHT;
						end if;
					when RIGHT => 
						RST_columns <= '0'; EN <='1'; DIR <='1';
						if conv_integer(ROT) = 48 then
						state <= LEFT; RST_columns <= '1'; EN <='1';
						end if;
					when LEFT => 
						RST_columns <= '0'; EN <='1';DIR <='0';
						if conv_integer(ROT) = 48 then
						state <= ANIMATION;
						end if;
					when ANIMATION => 
						RST_columns <= '1'; EN <='1';DIR <='0'; 	arr <= anim;
						if conv_integer(ROT) = 48 then
						state <= START;  incRom<='1';
						end if;
					when others =>null;
				end case;
	
			end if;
			end if;
	end process;

end Behavioral;

