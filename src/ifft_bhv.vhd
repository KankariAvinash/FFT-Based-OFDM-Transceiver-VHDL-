
library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use work.pkg_types_bhv.all;

entity ifft_bhv is
  port(
    xk : in  complex_vec_fft_t;
    xn : out complex_vec_fft_t
  );
end;

architecture beh of ifft_bhv is
begin
  process(xk)
    variable sum_re, sum_im : real;
    variable wre, wim : real;
    variable pr,  pi  : real;
    constant scale : real := 1.0/real(N_FFT);
  begin
    -- Defensive sanity checks (will fail fast with a clear message if mismatched)
    assert xk'low = 0 and xk'high = N_FFT-1
      report "IFFT: xk range mismatch: low=" & integer'image(xk'low) &
             " high=" & integer'image(xk'high) severity failure;
    assert xn'low = 0 and xn'high = N_FFT-1
      report "IFFT: xn range mismatch: low=" & integer'image(xn'low) &
             " high=" & integer'image(xn'high) severity failure;

    for n in xn'range loop
      sum_re := 0.0; sum_im := 0.0;
      for k in xk'range loop
        wre := cos( (2.0*math_pi)*real(k*n)/real(N_FFT) );
        wim := sin( (2.0*math_pi)*real(k*n)/real(N_FFT) );
        pr  := (xk(k).re*wre) - (xk(k).im*wim);
        pi  := (xk(k).re*wim) + (xk(k).im*wre);
        sum_re := sum_re + pr;
        sum_im := sum_im + pi;
      end loop;
      xn(n).re <= sum_re*scale;
      xn(n).im <= sum_im*scale;
    end loop;
  end process;
end architecture;
