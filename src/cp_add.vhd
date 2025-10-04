
library ieee;
use ieee.std_logic_1164.all;
use work.pkg_types_bhv.all;

entity cp_add is
  port(
    in_syms  : in  complex_vec_fft_t;
    out_syms : out complex_vec_cp_t
  );
end;

architecture beh of cp_add is
begin
  process(in_syms)
  begin
    for i in out_syms'low to out_syms'high loop
      if i < CP_LEN then
        out_syms(i) <= in_syms(in_syms'high - CP_LEN + 1 + i);
      else
        out_syms(i) <= in_syms(i - CP_LEN);
      end if;
    end loop;
  end process;
end architecture;
