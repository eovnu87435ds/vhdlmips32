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
	variable initAddress: std_logic_vector(31 downto 0);
	variable isFirstCycle: integer:=1;
	begin
		if isFirstCycle=1 then
			initAddress:=(others=>'0'); -- Initialize PC to 0 on first clock cycle
		else
			initAddress:=address;
		end if;
		
		if ck='1' and ck'event then
			isFirstCycle:=0;
			progCount<=initAddress;
		end if;
	end process;
end behavioral;