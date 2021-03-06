library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity Mux5 is
	port (
		zero5,one5 : in STD_LOGIC_VECTOR(4 downto 0);
		sel5 : in STD_LOGIC;
		muxout5 : out STD_LOGIC_VECTOR(4 downto 0));
end Mux5;

architecture behavioral of Mux5 is

begin
process(zero5, one5, sel5)
begin
	if sel5 = '0' then
		muxout5 <= zero5;
	end if;
	if sel5 = '1' then
		muxout5 <= one5;
	end if;
end process;
end behavioral;