onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_mem_ctl2/reset_i
add wave -noupdate -format Logic /tb_mem_ctl2/en_i
add wave -noupdate -format Logic /tb_mem_ctl2/clk_i
add wave -noupdate -format Logic /tb_mem_ctl2/s_vga_red_i
add wave -noupdate -format Logic /tb_mem_ctl2/s_vva_o 
add wave -noupdate -format Logic /tb_mem_ctl2/s_hva_o
add wave -noupdate -format Logic /tb_mem_ctl2/s_rgb_i
add wave -noupdate -format Logic /tb_mem_ctl2/i_mem_ctl2/s_mem2_addr
add wave -noupdate -format Logic /tb_mem_ctl2/i_src_mux/s_pospixel
add wave -noupdate -format Logic /tb_mem_ctl2/i_src_mux/s_pixel
add wave -noupdate -format Logic /tb_mem_ctl2/s_fg_o

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ms}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
