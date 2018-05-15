onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_mem_ctl1/reset_i
add wave -noupdate -format Logic /tb_mem_ctl1/en_i
add wave -noupdate -format Logic /tb_mem_ctl1/clk_i
add wave -noupdate -format Logic /tb_mem_ctl1/s_vga_red_i
add wave -noupdate -format Logic /tb_mem_ctl1/s_vva_o 
add wave -noupdate -format Logic /tb_mem_ctl1/s_hva_o
add wave -noupdate -format Logic /tb_mem_ctl1/s_rgb_i
add wave -noupdate -format Logic /tb_mem_ctl1/i_mem_ctl1/s_mem1_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ms}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
