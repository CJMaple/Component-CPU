----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:25:30 09/11/2020 
-- Design Name: 
-- Module Name:    IR - Behavioral 
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

entity IR is
PORT(
		instruction : in STD_LOGIC_VECTOR (15 downto 0);
		rx,ry,rz,im : out STD_LOGIC_VECTOR (15 downto 0);
		run_IR : in STD_LOGIC
	);
end IR;

architecture Behavioral of IR is

begin

process
	begin
		rx <= x"0000";
		ry <= x"0000";
		rz <= x"0000";
		im <= x"0000";
		
		if run_IR = '1' then
			case instruction(15 downto 11) is
				when "00000" =>  --ADDSP3
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "00010" =>  --B
					im(10 downto 0) <= instruction(10 downto 0);
				when "00100" =>  --BEQZ
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "00101" =>  --BNEZ
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "00110" =>  --SLL、SRL、SRA
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
					im(2 downto 0) <= instruction(4 downto 2);
				when "01000" =>  --ADDIU3
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
					im(3 downto 0) <= instruction(3 downto 0);
				when "01001" =>  --ADDIU
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "01010" =>  --SLTI
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "01011" =>  --SLTUI
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "01100" =>  --BTEQZ、BTNEZ、SW_RS、ADDSP、MTSP
					if instruction(10 downto 8) = "100" then  --MTSP
						rx(2 downto 0) <= instruction(7 downto 5);
					else
						im(7 downto 0) <= instruction(7 downto 0);
					end if;
				when "01101" =>  --LI
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "01110" =>  --CMPI
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "01111" =>  --MOVE
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
				when "10010" =>  --LW_SP
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "10011" =>  --LW
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
					im(4 downto 0) <= instruction(4 downto 0);
				when "11010" =>  --SW_SP
					rx(2 downto 0) <= instruction(10 downto 8);
					im(7 downto 0) <= instruction(7 downto 0);
				when "11011" =>  --SW
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
					im(4 downto 0) <= instruction(4 downto 0);
				when "11100" =>  --ADDU、SUBU
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
					rz(2 downto 0) <= instruction(4 downto 2);
				when "11101" =>  --JR、JRRA、MFPC、JALR、SLT、SLTU、SLLV、SRLV、SRAV、CMP、NEG、AND、OR、XOR、NOT
					rx(2 downto 0) <= instruction(10 downto 8);
					ry(2 downto 0) <= instruction(7 downto 5);
				when "11110" =>  --MFIH、MTIH
					rx(2 downto 0) <= instruction(10 downto 8);
				when "11111" =>  --INT
					im(3 downto 0) <= instruction(3 downto 0);
				when others =>
					null;
			end case;
		end if;
	end process;
end Behavioral;

