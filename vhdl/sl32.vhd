library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity sl32 is
	port(signOut:in std_logic_vector(31 downto 0);	-- will receive instruction[15:0] padded with 16 0's
		BranchAddress:out std_logic_vector(31 downto 0));	-- Output of the shift left twice.
end sl32;

architecture behavioral of sl32 is
begin
	process(signOut)
	begin
		BranchAddress<=signOut(29 downto 0) & "00";
	end process;
end behavioral;