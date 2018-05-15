onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_patterngen1/reset_i
add wave -noupdate -format Logic /tb_patterngen1/en_i
add wave -noupdate -format Logic /tb_patterngen1/clk_i
add wave -noupdate -format Logic /tb_patterngen1/s_vga_red_i
add wave -noupdate -format Logic /tb_patterngen1/s_vva_o 
add wave -noupdate -format Logic /tb_patterngen1/s_hva_o
add wave -noupdate -format Logic /tb_patterngen1/s_rgb_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ms}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
