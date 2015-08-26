library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PC is
	port(ck:in std_logic;
		address:in std_logic_vector(31 downto 0);	-- Will receive a program count.
		progCount:out std_logic_vector(31 downto 0));	-- Program count that will be returned.
end PC;

architecture behavioral of PC is
begin
	process(ck)
	begin
		if ck='1' and ck'event then 
			-- Increment the program count. Has to be 4 byte aligned due to the 32-bit architecture.
			progCount<=address;
		end if;
	end process;
end behavioral;