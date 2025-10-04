
library ieee;
use ieee.std_logic_1164.all;
use work.pkg_types_bhv.all;

entity tb_ofdm is end;

architecture sim of tb_ofdm is
  constant N : integer := N_FFT;
  signal bits_in  : std_logic_vector(2*N-1 downto 0);
  signal bits_out : std_logic_vector(2*N-1 downto 0);
begin
  dut: entity work.top_ofdm_bhv
    port map(bits_in => bits_in, bits_out => bits_out);

  stim: process
    variable errors : integer := 0;
  begin
    bits_in <= (others => '0');
    wait for 1 ns;

    for vec in 0 to 255 loop
      for i in 0 to 2*N-1 loop
        if ((vec / (2**i)) mod 2) = 0 then
          bits_in(i) <= '0';
        else
          bits_in(i) <= '1';
        end if;
      end loop;

      wait for 1 ns;

      if bits_out /= bits_in then
        errors := errors + 1;
      end if;
    end loop;

    assert errors = 0
      report "BER!=0 in noiseless channel. Errors=" & integer'image(errors)
      severity failure;
    report "PASS: BER=0 for QPSK/OFDM (N=8) behavioral chain" severity note;
    wait;
  end process;
end architecture;
