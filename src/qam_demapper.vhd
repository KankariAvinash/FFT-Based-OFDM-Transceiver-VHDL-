
library ieee;
use ieee.std_logic_1164.all;
use work.pkg_types_bhv.all;

entity qam_demapper is
  port(
    syms : in  complex_vec_fft_t;
    bits : out std_logic_vector(2*N_FFT-1 downto 0)
  );
end;

architecture beh of qam_demapper is
begin
  process(syms)
  begin
    for i in syms'range loop
      bits(2*i+1) <= '0' when syms(i).re >= 0.0 else '1';
      bits(2*i)   <= '0' when syms(i).im >= 0.0 else '1';
    end loop;
  end process;
end architecture;
