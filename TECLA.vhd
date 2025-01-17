library ieee;
use ieee.std_logic_1164.all;

entity TECLA is
	port (bs_FFD: buffer std_logic;
		col: out std_logic_vector(3 downto 0);
		ren: in std_logic_vector(3 downto 0);
		vt: out integer range 0 to 15;
		clk: in std_logic);
end entity;

architecture aaa of TECLA is
signal cont: integer range 0 to 15; --4 bits, 4 alambres
signal bs: std_logic;
begin

flip_flop_anti_glitch:			
process(clk)
begin
	if falling_edge(clk) then --flanco de bajada
		bs_FFD <= bs;
	end if;
end process;
	
multiplexor_4_a_1:--etiqueta
with cont select
	bs <= 	ren(0) when 0|4|8|12,
			ren(1) when 1|5|9|13,
			ren(2) when 2|6|10|14,
			ren(3) when 3|7|11|15;
			
decodificador_2x4:
with cont select
	col <=  "0001" when 0|1|2|3,
			"0010" when 4|5|6|7,
			"0100" when 8|9|10|11,
			"1000" when 12|13|14|15;
						
contador_4_bits_con_habilitacion_en_bajo:
process(clk, bs)
begin
	if bs = '1' then
		cont <= cont;
	elsif rising_edge(clk) then -- if clk'event and clk='1' then
		cont <= cont + 1;
	end if;
end process;

decodificador_codigo_tecla_a_valor_tecla:
with cont select
	vt <=  	10 	when 0,
			11 	when 1,
			12 	when 2,
			13 	when 3,
			3 	when 4,
			6 	when 5,
			9 	when 6,
			15 	when 7,
			2 	when 8,
			5 	when 9,
			8 	when 10,
			0 	when 11,
			1 	when 12,
			4 	when 13,
			7 	when 14,
			14 	when 15;
end aaa;

