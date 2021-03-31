----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:51 09/11/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
Port(
	ALU_A : in  STD_LOGIC_VECTOR (15 downto 0);
	ALU_B : in  STD_LOGIC_VECTOR (15 downto 0);
	ALU_OP : in  STD_LOGIC_VECTOR (15 downto 0);
	ALU_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
	run_ALU : in STD_LOGIC
);
end ALU;

architecture Behavioral of ALU is

begin

process
begin
	if run_ALU = '1' then
		case ALU_OP is
			when x"0000" =>  --ADD
				ALU_OUT <= ALU_A + ALU_B;
			when x"0001" =>  --SUB
				ALU_OUT <= ALU_A - ALU_B;
			when others =>
				case ALU_OP(15 downto 11) is
					when "00110" =>
						case ALU_OP(4 downto 0) is
							when "00000" =>
								if ALU_B = x"0000" then
									ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SLL 8);
								else
									ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SLL CONV_INTEGER(ALU_B));
								end if;
							when "00010" =>
								if ALU_B = x"0000" then
									ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SRL 8);
								else
									ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SRL CONV_INTEGER(ALU_B));
								end if;
							when "00011" =>
								if ALU_B = x"0000" then
									ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SRA 8);
								else
									ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SRA CONV_INTEGER(ALU_B));
								end if;
							when others =>
								null;
						end case;
					
					when "11101" =>
						case ALU_OP(4 downto 0) is
							when "00100" =>
								ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SLL CONV_INTEGER(ALU_B));
							when "00110" =>
								ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SRL CONV_INTEGER(ALU_B));
							when "00111" =>
								ALU_OUT <= TO_STDLOGICVECTOR(TO_BITVECTOR(ALU_A) SRA CONV_INTEGER(ALU_B));
							when "01011" =>
								ALU_OUT <= (NOT ALU_A) + 1;
							when "01100" =>
								ALU_OUT <= ALU_A AND ALU_B;
							when "01101" =>
								ALU_OUT <= ALU_A OR ALU_B;
							when "01110" =>
								ALU_OUT <= ALU_A XOR ALU_B;
							when "01111" =>
								ALU_OUT <= NOT ALU_A;
							when others =>
								null;
						end case;
					
					when others =>
						null;
				end case;
		end case;
	end if;
end process;

end Behavioral;

