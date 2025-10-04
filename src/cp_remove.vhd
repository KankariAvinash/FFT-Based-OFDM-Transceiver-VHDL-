
library ieee;
use ieee.std_logic_1164.all;
use work.pkg_types_bhv.all;

entity cp_remove is
  port(
    in_syms  : in  complex_vec_cp_t;
    out_syms : out complex_vec_fft_t
  );
end;

architecture beh of cp_remove is
begin
  process(in_syms)
  begin
    for i in out_syms'range loop
      out_syms(i) <= in_syms(CP_LEN + i);
    end loop;
  end process;
end architecture;
