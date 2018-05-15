onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_vga_ctl/reset_i
add wave -noupdate -format Logic /tb_vga_ctl/en_i
add wave -noupdate -format Logic /tb_vga_ctl/rgb_i
add wave -noupdate -format Logic /tb_vga_ctl/s_vga_red_i
add wave -noupdate -format Logic /tb_vga_ctl/s_vga_green_i
add wave -noupdate -format Logic /tb_vga_ctl/s_vga_blue_i 
add wave -noupdate -format Logic /tb_vga_ctl/s_vga_hsync_i 
add wave -noupdate -format Logic /tb_vga_ctl/s_vga_vsync_i 
add wave -noupdate -format Logic /tb_vga_ctl/s_vva_o 
add wave -noupdate -format Logic /tb_vga_ctl/s_hva_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ms}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
