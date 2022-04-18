library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.newspaper_pack.all;
use work.column;

architecture Behavioral of tlv_gp_ifc is
	
	--component column
    --port(CLK2,RESET,DIRECTION,EN : in  std_logic;
		--	NEIGH_LEFT,INIT_STATE, NEIGH_RIGHT    : in std_logic_vector;
   --      STATE           : out std_logic_vector);
 -- end component;


	signal A : std_logic_vector(3 downto 0) := "0001";
	signal R : std_logic_vector(7 downto 0) := "01011100";
	signal arr2 : std_logic_vector(127 downto 0) := "10000000100000001111111110000000100000000100011010011001011000101000000110011001111111111000000010000000111111111000000010000000";
	signal arr : std_logic_vector(127 downto 0)  := "10000000100000001111111110000000100000000100011010011001011000101000000110011001111111111000000010000000111111111000000010000000";
	--signal arr2 : std_logic_vector(127 downto 0) := "01010101101010100101010110101010010101011010101001010101101010100101010110101010010101011010101001010101101010100101010110101010";
	--signal arr : std_logic_vector(127 downto 0)  := "01010101101010100101010110101010010101011010101001010101101010100101010110101010010101011010101001010101101010100101010110101010";
	signal cnt : std_logic_vector(24 downto 0) := (others => '0');  -- 1s - 20MHz / 20M ~ 24b
	signal cnt2 : std_logic_vector(21 downto 0) := (others => '0');  -- 1/2s - 20MHz / 20M ~ 24b
	signal cntRomIndex : std_logic_vector(1 downto 0) := (others => '0');  -- 1/2s - 20MHz / 20M ~ 24b
	signal rot : std_logic_vector(5 downto 0) := (others => '0');
	signal clk2 : std_logic := '0';
		signal en2 : std_logic := '0';
			signal en_FSM : std_logic := '1';
			signal reset2 : std_logic := '1';
			signal dir : std_logic := '1';						
			signal rst_fsm : std_logic := '0';
			signal incRom : std_logic := '0';
		shared	variable id : integer := 0;
	
begin

FSM: entity work.fsm(behavioral)
		port map(
		CLK => CLK,
	RST =>rst_fsm,
   RST_columns => reset2,
   EN => en2,
	DIR => dir,
	ROT =>rot,
   arr => arr2,
	incRom => incRom,
	cntRomIndex => cntRomIndex
		);

GEN_Column: 
 for I in 0 to 15 generate 
 
 
	middle: if I>0 and I<15 generate
    ColumnX:  entity work.column port map(clk => clk2, 
		 RESET=>reset2, 
		 INIT_STATE=>arr2(I*8+8-1 downto I*8),
	 STATE => arr(I*8+8-1 downto I*8),
		 NEIGH_RIGHT =>arr(I*8+8-1-8 downto I*8-8),
		  NEIGH_LEFT => arr(I*8+8-1+8 downto I*8+8),
		  DIRECTION => dir,
	  EN =>en2);
	    end generate;
	  start: if I=0 generate
    ColumnX:  entity work.column port map(clk => clk2, 
		 RESET=>reset2, 
		 INIT_STATE=>arr2(7 downto 0),
	 STATE => arr(7 downto 0),
		 NEIGH_RIGHT =>arr(127 downto 120),
		  NEIGH_LEFT => arr(15 downto 8),
		  DIRECTION => dir,
	  EN =>en2);
	  end generate;
	   ending: if I=15 generate
    ColumnX:  entity work.column port map(clk => clk2, 
		 RESET=>reset2, 
		 INIT_STATE=>arr2(127 downto 120),
	 STATE => arr(127 downto 120),
		 NEIGH_RIGHT =>arr(119 downto 112),
		  NEIGH_LEFT => arr(7 downto 0),
		  DIRECTION => dir,
	  EN =>en2);
	  end generate;
	  
    end generate;
  
--  ColumnX:  entity work.column port map
--       (clk => clk2, 
--		 RESET=>reset2, 
--		 INIT_STATE=>arr2(7 downto 0),
--		 STATE => arr(7 downto 0),
--		 NEIGH_LEFT =>arr(23 downto 16),
--		  NEIGH_RIGHT => "11111111",
--		  DIRECTION => dir,
--		  EN =>en2);
--		    Column1:  entity work.column port map
--       (clk => clk2, 
--		 RESET=>reset2, 
--		 INIT_STATE=>arr2(15 downto 8),
--		 STATE => arr(15 downto 8),
--		 NEIGH_LEFT =>arr(7 downto 0),
--		  NEIGH_RIGHT => "00000000",
--		  DIRECTION => dir,
--		  EN =>en2);
--		   Column2:  entity work.column port map
--       (clk => clk2, 
--		 RESET=>reset2, 
--		 INIT_STATE=>arr2(23 downto 16),
--		 STATE => arr(23 downto 16),
--		 NEIGH_LEFT =>arr(15 downto 8),
--		  NEIGH_RIGHT => "11111111",
--		  DIRECTION => dir,
--		  EN =>en2);
		  


	
	process (clk) is
		variable q : integer := 0;
	begin
		if rising_edge(clk) then
			cnt <= cnt + 1;
				
			if conv_integer(cnt) = "11111111111" then
				A <= A + 1;
				R <= GETCOLUMN(arr, q,8);
				q :=q+1;
			
			end if;
			if q = 16 then
			q:= 0;
			end if;
		end if;
	
	end process;


	process (clk) is
	begin
	if rising_edge(clk) then
			cnt2 <= cnt2 + 1;
			if conv_integer(cnt2) = 0 then
					clk2 <= '1';
					rot <= rot +1;
					else 
						clk2 <= '0';
				end if;
				--if conv_integer(cnt2) = 10 then
					--en2 <='1';
				--	reset2 <='0';
				--end if;
				if conv_integer(rot) = 48 then
					rot <= (others => '0');
				end if;
	end if;
	end process;
	
	process (incRom) is
	begin
	if rising_edge(incRom) then
			cntRomIndex <= cntRomIndex + 1;
	end if;
	end process;

	

    -- mapovani vystupu
    -- nemenit
    X(6) <= A(3);
    X(8) <= A(1);
    X(10) <= A(0);
    X(7) <= '0'; -- en_n
    X(9) <= A(2);

    X(16) <= R(1);
    X(18) <= R(0);
    X(20) <= R(7);
    X(22) <= R(2);
  
    X(17) <= R(4);
    X(19) <= R(3);
    X(21) <= R(6);
    X(23) <= R(5);
end Behavioral;

