
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package pkg_types_bhv is
  constant N_FFT  : integer := 8;
  constant CP_LEN : integer := N_FFT/4; -- 2
  subtype real_t is real;

  type complex_t is record
    re : real_t;
    im : real_t;
  end record;

  type complex_vec_t is array (natural range <>) of complex_t;

  subtype complex_vec_fft_t is complex_vec_t(0 to N_FFT-1);
  subtype complex_vec_cp_t  is complex_vec_t(0 to N_FFT+CP_LEN-1);

  function twiddle(k : integer; n : integer) return complex_t;   -- exp(-j*2πkn/N)
  function itwiddle(k : integer; n : integer) return complex_t;  -- exp(+j*2πkn/N)
end package;

package body pkg_types_bhv is
  function twiddle(k : integer; n : integer) return complex_t is
    variable r : complex_t;
    constant TWO_PI : real := 2.0*math_pi;
    variable ang : real := -TWO_PI*real(k*n)/real(N_FFT);
  begin
    r.re := cos(ang);
    r.im := sin(ang);
    return r;
  end;

  function itwiddle(k : integer; n : integer) return complex_t is
    variable r : complex_t;
    constant TWO_PI : real := 2.0*math_pi;
    variable ang : real := +TWO_PI*real(k*n)/real(N_FFT);
  begin
    r.re := cos(ang);
    r.im := sin(ang);
    return r;
  end;
end package body;
