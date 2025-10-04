# Author
Avinash Kankari

M.Sc. Communication and Information Technology

# FFT-Based OFDM Transceiver (Behavioral VHDL)

This project implements a complete **OFDM baseband chain** using behavioral VHDL with a simple QPSK modulation scheme.

### 🧩 Components
- **pkg_types_bhv.vhd** — type definitions and complex math helpers  
- **fft_bhv.vhd / ifft_bhv.vhd** — direct DFT-based FFT/IFFT models  
- **qam_mapper.vhd / qam_demapper.vhd** — QPSK mapping/demapping  
- **cp_add.vhd / cp_remove.vhd** — cyclic prefix handling  
- **top_ofdm_bhv.vhd** — top-level OFDM transceiver chain  
- **tb_ofdm.vhd** — self-checking testbench verifying BER = 0  

### ⚙️ Requirements
- [GHDL](https://github.com/ghdl/ghdl) (VHDL-2008 capable build)
- `bash` (for the `run_sim.sh` helper)

### ▶️ Run Simulation
```bash
chmod +x run_sim.sh
./run_sim.sh
```

If everything is configured correctly, you should see:
```
PASS: BER=0 for QPSK/OFDM (N=8) behavioral chain
```

### 🧪 Notes
- Uses constrained subtypes (`complex_vec_fft_t`, `complex_vec_cp_t`) for safety  
- All loops use `'range` instead of hardcoded indices  
- Compatible with GHDL VHDL-2008 standard  
- Pure behavioral (not synthesizable — for functional verification only)  

### 🧰 Troubleshooting
If you get a **bound check failure**, clean rebuild:
```bash
rm -rf build_ghdl work-obj08.cf
./run_sim.sh
```

### 📁 Directory Structure
```
ofdm_constrained_v3/
├── src/
│   ├── pkg_types_bhv.vhd
│   ├── fft_bhv.vhd
│   ├── ifft_bhv.vhd
│   ├── qam_mapper.vhd
│   ├── qam_demapper.vhd
│   ├── cp_add.vhd
│   ├── cp_remove.vhd
│   └── top_ofdm_bhv.vhd
├── tb/
│   └── tb_ofdm.vhd
├── run_sim.sh
├── README.md
└── .gitignore
```
