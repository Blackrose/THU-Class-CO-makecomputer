----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Fu Zuoyou.
-- 
-- Create Date:    20:30:32 11/30/2013 
-- Design Name: 
-- Module Name:    flashio - Behavioral 
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

entity flashio is
	port(
		-- 字模式下为22-1，字节模式为22-0
		KEY16_INPUT: in std_logic_vector(15 downto 0);
		
		LED_output: out std_logic_vector(15 downto 0);
		led1: out std_logic_vector(6 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		
		flash_byte : out std_logic;
		flash_vpen : out std_logic;
		flash_ce : out std_logic;
		flash_oe : out std_logic;
		flash_we : out std_logic;
		flash_rp : out std_logic;
		flash_addr : out std_logic_vector(22 downto 1);
		flash_data : inout std_logic_vector(15 downto 0);
		
		addr_ram1: out std_logic_vector(15 downto 0)
	);
end flashio;

architecture Behavioral of flashio is
	type flash_state is (
		waiting,
		write1, write2, write3, write4, write5,
		read1, read2, read3, read4,
		sr1, sr2, sr3, sr4, sr5,
		erase1, erase2, erase3, erase4, erase5, erase6,
		done
	);
	signal state : flash_state := waiting;
	signal next_state : flash_state := waiting;
	signal ctl_read_last, ctl_write_last, ctl_erase_last : std_logic;
	signal dataout: std_logic_vector(15 downto 0);
	signal addr: std_logic_vector(22 downto 1);
	signal ctl_read : std_logic := '0';
	signal ctl_write :std_logic:= '0';
	signal ctl_erase :std_logic:= '0';
	signal datain: std_logic_vector(15 downto 0);
	component LED16
	Port(
		LED_output : out std_logic_vector(15 downto 0);
		input : in std_logic_vector(15 downto 0)
	);
	end component;
	component LED_seg7
	Port(
		input : in  STD_LOGIC_VECTOR (3 downto 0);
		output : out  STD_LOGIC_VECTOR (6 downto 0)
	);
	end component;
	signal tmp : std_logic_vector(3 downto 0);
begin

	l1: LED16 port map (LED_output => LED_output, input => dataout);
	l3: LED16 port map (LED_output => addr_ram1, input => datain);
	l2: LED_seg7 port map(input => addr(4 downto 1), output => led1);
	
	tmp <= '0' & ctl_read & ctl_write & ctl_erase;
	addr <= "000000000000000" & KEY16_INPUT(6 downto 0);
	datain <= KEY16_INPUT(12 downto 7) & "0000000000";
	
	ctl_read <= key16_input(15);
	ctl_write <= key16_input(14);
	ctl_erase <= key16_input(13);

	-- always set 1 for 字模式
	flash_byte <= '1';
	-- write protect, always 1
	flash_vpen <= '1';
	-- ce is enable, 0 is selected, 1 is not.
	flash_ce <= '0';
	-- 0 is reset, 1 is work, always 1
	flash_rp <= '1';

	process(clk, reset)
	begin
		if (reset = '0') then
			dataout <= (others => '0');
			flash_oe <= '1';
			flash_we <= '1';
			state <= waiting;
			next_state <= waiting;
			ctl_read_last <= ctl_read;
			ctl_write_last <= ctl_write;
			ctl_erase_last <= ctl_erase;
			flash_data <= (others => 'Z');
		elsif (clk'event and clk = '1') then
			case state is
				-- wait(initial)
				when waiting =>
					-- store last so you can change the value
					-- to triggle the action when necessary
					if (ctl_read /= ctl_read_last) then
						flash_we <= '0';
						state <= read1;
						ctl_read_last <= ctl_read;
					elsif (ctl_write /= ctl_write_last) then
						flash_we <= '0';
						state <= write1;
						ctl_write_last <= ctl_write;
					elsif (ctl_erase /= ctl_erase_last) then
						flash_we <= '0';
						dataout(0) <= '0';
						state <= erase1;
						ctl_erase_last <= ctl_erase;
					end if;
				
				-- write
				when write1 =>
					flash_data <= x"0040";
					state <= write2;
				when write2 =>
					flash_we <= '1';
					state <= write3;
				when write3 =>
					flash_we <= '0';
					state <= write4;
				when write4 =>
					flash_addr <= addr;
					flash_data <= datain;
					state <= write5;
				when write5 =>
					flash_we <= '1';
					state <= sr1;
					next_state <= done;
				
				-- small loop CM in write
				-- write 6 is sr1
				when sr1 =>
					flash_we <= '0';
					flash_data <= x"0070";
					state <= sr2;
				when sr2 =>
					flash_we <= '1';
					state <= sr3;
				when sr3 =>
					flash_data <= (others => 'Z');
					state <= sr4;
				when sr4 =>
					flash_oe <= '0';
					state <= sr5;
				when sr5 =>
					flash_oe <= '1';
					if flash_data(7) = '0' then
						state <= sr1;
					else
						state <= next_state;
					end if;
				
				-- read
				when read1 =>
					flash_data <= x"00FF";
					state <= read2;
				when read2 =>
					flash_we <= '1';
					state <= read3;
				when read3 =>
					flash_oe <= '0';
					flash_addr <= addr;
					flash_data <= (others => 'Z');
					state <= read4;
				when read4 =>
					dataout <= flash_data;
					state <= done;
				
				-- erase
				when erase1 =>
					flash_data <= x"0020";
					state <= erase2;
				when erase2 =>
					flash_we <= '1';
					state <= erase3;
				when erase3 =>
					flash_we <= '0';
					state <= erase4;
				when erase4 =>
					flash_data <= x"00D0";
					flash_addr <= addr;
					state <= erase5;
				when erase5 =>
					flash_we <= '1';
					next_state <= erase6;
					state <= sr1;
					-- jump to sr1
				-- return back from sr5
				when erase6 =>
					state <= done;
					dataout(0) <= '1';
				
				when others =>
					flash_oe <= '1';
					flash_we <= '1';
					flash_data <= (others => 'Z');
					state <= waiting;
			end case;
		end if;
	end process;

end Behavioral;

