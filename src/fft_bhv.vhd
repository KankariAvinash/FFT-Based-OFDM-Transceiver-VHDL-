
library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use work.pkg_types_bhv.all;

entity fft_bhv is
  port(
    xn : in  complex_vec_fft_t;
    xk : out complex_vec_fft_t
  );
end;

architecture beh of fft_bhv is
begin
  process(xn)
    variable sum_re, sum_im : real;
    variable wre, wim : real;
    variable pr,  pi  : real;
  begin
    for k in xk'range loop
      sum_re := 0.0; sum_im := 0.0;
      for n in xn'range loop
        wre := cos( -(2.0*math_pi)*real(k*n)/real(N_FFT) );
        wim := sin( -(2.0*math_pi)*real(k*n)/real(N_FFT) );
        pr  := (xn(n).re*wre) - (xn(n).im*wim);
        pi  := (xn(n).re*wim) + (xn(n).im*wre);
        sum_re := sum_re + pr;
        sum_im := sum_im + pi;
      end loop;
      xk(k).re <= sum_re;
      xk(k).im <= sum_im;
    end loop;
  end process;
end architecture;
