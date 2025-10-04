
library ieee;
use ieee.std_logic_1164.all;
use work.pkg_types_bhv.all;

entity top_ofdm_bhv is
  port(
    bits_in  : in  std_logic_vector(2*N_FFT-1 downto 0);
    bits_out : out std_logic_vector(2*N_FFT-1 downto 0)
  );
end;

architecture beh of top_ofdm_bhv is
  signal mapped      : complex_vec_fft_t;
  signal time_sym    : complex_vec_fft_t;
  signal with_cp     : complex_vec_cp_t;
  signal removed_cp  : complex_vec_fft_t;
  signal freq_sym    : complex_vec_fft_t;
begin
  u_map : entity work.qam_mapper    port map(bits_in, mapped);
  u_ifft: entity work.ifft_bhv      port map(mapped, time_sym);
  u_cpa : entity work.cp_add        port map(time_sym, with_cp);
  u_cpr : entity work.cp_remove     port map(with_cp, removed_cp);
  u_fft : entity work.fft_bhv       port map(removed_cp, freq_sym);
  u_dem : entity work.qam_demapper  port map(freq_sym, bits_out);
end architecture;
