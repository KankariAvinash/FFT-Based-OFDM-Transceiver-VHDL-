
library ieee;
use ieee.std_logic_1164.all;
use work.pkg_types_bhv.all;

entity qam_mapper is
  port(
    bits : in  std_logic_vector(2*N_FFT-1 downto 0);
    syms : out complex_vec_fft_t
  );
end;

architecture beh of qam_mapper is
  constant inv_sqrt2 : real := 0.7071067811865475;
begin
  process(bits)
    variable v2 : std_logic_vector(1 downto 0);
  begin
    for i in syms'range loop
      v2 := bits(2*i+1) & bits(2*i);
      case v2 is
        when "00" => syms(i).re <= +inv_sqrt2; syms(i).im <= +inv_sqrt2;
        when "01" => syms(i).re <= +inv_sqrt2; syms(i).im <= -inv_sqrt2;
        when "11" => syms(i).re <= -inv_sqrt2; syms(i).im <= -inv_sqrt2;
        when others => syms(i).re <= -inv_sqrt2; syms(i).im <= +inv_sqrt2;
      end case;
    end loop;
  end process;
end architecture;
