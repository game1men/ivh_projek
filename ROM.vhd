----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:34:09 04/18/2022 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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

entity ROM is
    Port ( address : in  STD_LOGIC_vector(1 downto 0);
           DATA : out  std_logic_vector(127 downto 0));
end ROM;

architecture Behavioral of ROM is
  type mem is array ( 0 to 3) of std_logic_vector(127 downto 0);
  constant rom_data : mem := (
    0  => "10000000100000001111111110000000100000000100011010011001011000101000000110011001111111111000000010000000111111111000000010000000",
    1  => "01010101101010100101010110101010010101011010101001010101101010100101010110101010010101011010101001010101101010100101010110101010",
    2  => "11111111100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000111111111",
    3  => "10000000100000000100000001000000001000000010000000010000000100000000100000001000000001000000010000000010000000100000000100000001");
begin

 process (address)
   begin
     case address is
       when "00" => data <= rom_data(0);
       when "01" => data <= rom_data(1);
       when "10" => data <= rom_data(2);
       when "11" => data <= rom_data(3);
		  when others => data <= rom_data(3);
	 end case;
  end process;
end Behavioral;

