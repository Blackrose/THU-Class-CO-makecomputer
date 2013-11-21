----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:18 11/21/2013 
-- Design Name: 
-- Module Name:    RiskChecker - Behavioral 
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

entity RiskChecker is
    Port ( PCWrite : out  STD_LOGIC;
           IFIDWrite : out  STD_LOGIC;
           ControlRst : out  STD_LOGIC;
           IDEX_MemWrite : in  STD_LOGIC;
           IDEX_W : in  STD_LOGIC;
           IDEX_R1 : in  STD_LOGIC;
           IDEX_R2 : in  STD_LOGIC);
end RiskChecker;

architecture Behavioral of RiskChecker is

begin


end Behavioral;
