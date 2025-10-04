
#!/usr/bin/env bash
set -euo pipefail

rm -rf build_ghdl
mkdir -p build_ghdl

ghdl -a --std=08 --work=work --workdir=build_ghdl src/pkg_types_bhv.vhd
ghdl -a --std=08 --work=work --workdir=build_ghdl   src/fft_bhv.vhd src/ifft_bhv.vhd   src/qam_mapper.vhd src/qam_demapper.vhd   src/cp_add.vhd src/cp_remove.vhd   src/top_ofdm_bhv.vhd tb/tb_ofdm.vhd

ghdl -e --std=08 --work=work --workdir=build_ghdl tb_ofdm
ghdl -r --std=08 --work=work --workdir=build_ghdl tb_ofdm --backtrace-severity=error
