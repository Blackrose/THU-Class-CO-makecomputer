----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Fu Zuoyou.
-- 
-- Create Date:    19:03:31 11/21/2013 
-- Design Name: 
-- Module Name:    TReg - Behavioral 
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

entity TReg is
    Port(
		Input : in  STD_LOGIC_VECTOR (15 downto 0);
		TType : in  STD_LOGIC;
		TWrite : in  STD_LOGIC;
		T : out  STD_LOGIC
	);
end TReg;

architecture Behavioral of TReg is

begin


end Behavioral;

