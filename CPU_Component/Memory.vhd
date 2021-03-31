----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:38 09/12/2020 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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

entity Memory is
PORT(
		DATA : out STD_LOGIC_VECTOR (15 downto 0);  --RAM数据
		RAM1_EN : out STD_LOGIC;  --RAM使能
      RAM1_OE : out STD_LOGIC;  --RAM读使能
      RAM1_WE : out STD_LOGIC;  --RAM写使能
		control_state : inout INTEGER range 0 to 7;
		w_r_control : in STD_LOGIC;
		CLOCK : in STD_LOGIC;
		run_M : in STD_LOGIC;
		end_M : out STD_Logic
	);
end Memory;

architecture Behavioral of Memory is

begin

process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' and run_M = '1' then
			if w_r_control = '1' then  --write
				case control_state is
					when 0 =>
						RAM1_EN <= '0';
						RAM1_OE <= '1';
						RAM1_WE <= '1';
						control_state <= 1;
						end_M <= '0';
					when 1 =>
						RAM1_OE <= '1';
						RAM1_WE <= '0';
						control_state <= 2;
						end_M <= '0';
					when 2 =>
						RAM1_EN <= '1';
						RAM1_OE <= '0';
						RAM1_WE <= '0';
						control_state <= 0;
						end_M <= '1';
					when others =>
						null;
				end case;
			else  --read
				case control_state is
					when 0 =>
						RAM1_EN <= '0';
						RAM1_OE <= '1';
						RAM1_WE <= '1';
						control_state <= 1;
						end_M <= '0';
					when 1 =>
						RAM1_OE <= '0';
						RAM1_WE <= '1';
						DATA <= (others=> 'Z');
						control_state <= 2;
						end_M <= '0';
					when 2 =>
						RAM1_EN <= '1';
						RAM1_OE <= '0';
						RAM1_WE <= '0';
						control_state <= 0;
						end_M <= '1';
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

end Behavioral;

