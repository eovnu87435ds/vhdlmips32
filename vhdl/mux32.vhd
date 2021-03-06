library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity Mux32 is
	port (
		zero,one : in STD_LOGIC_VECTOR(31 downto 0);
		sel : in STD_LOGIC;
		muxout : out STD_LOGIC_VECTOR(31 downto 0));
end Mux32;

architecture behavioral of Mux32 is

begin
process(zero, one, sel)
begin
	if sel = '0' then
		muxout <= zero;
	end if;
	if sel = '1' then
		muxout <= one;
	end if;
end process;
end behavioral;