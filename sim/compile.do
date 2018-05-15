# Generated
# copy .mif file (which holds content of 1k ROM) into ModelSim simulation directory
file copy -force ../generate/mem1/mem1/mem1.mif ./
file copy -force ../generate/mem2/mem2/mem2.mif ./

# compile simulation model of generated 1k ROM
vlog ../generate/mem1/mem1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/mem1/mem1/synth/mem1.vhd
vlog ../generate/mem2/mem2/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/mem2/mem2/synth/mem2.vhd

# compile Xilinx GLBL module (required for proper initialization
# of all generated  Xilinx macros during simulation)
#vlog ../generate/glbl.v



# Entities
vcom ../vhdl/prescaler.vhd
vcom ../vhdl/io_ctl.vhd
vcom ../vhdl/src_mux.vhd
vcom ../vhdl/vga_ctl.vhd
vcom ../vhdl/patterngen1.vhd
vcom ../vhdl/patterngen2.vhd
vcom ../vhdl/mem_ctl1.vhd
vcom ../vhdl/mem_ctl2.vhd
vcom ../vhdl/Top.vhd


# Arcitectures
vcom ../vhdl/prescaler_rtl.vhd
vcom ../vhdl/src_mux_rtl.vhd
vcom ../vhdl/vga_ctl_rtl.vhd
vcom ../vhdl/patterngen1_rtl.vhd
vcom ../vhdl/patterngen2_rtl.vhd
vcom ../vhdl/mem_ctl1_rtl.vhd
vcom ../vhdl/mem_ctl2_rtl.vhd
vcom ../vhdl/Top_struc.vhd

# Testbenches
vcom ../tb/pkg_sw_pb.vhd
vcom ../tb/vga_monitor_.vhd
vcom ../tb/vga_monitor_sim.vhd
vcom ../tb/tb_io_ctl.vhd
vcom ../tb/tb_prescaler.vhd
vcom ../tb/tb_src_mux.vhd
vcom ../tb/tb_patterngen1.vhd
vcom ../tb/tb_patterngen2.vhd
vcom ../tb/tb_mem_ctl1.vhd
vcom ../tb/tb_mem_ctl2.vhd
vcom ../tb/tb_vga_ctl.vhd
vcom ../tb/tb_Top.vhd
