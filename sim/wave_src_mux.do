onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_src_mux/reset_i
add wave -noupdate -format Logic /tb_src_mux/clk_i
add wave -noupdate -format Logic /tb_src_mux/en_i
add wave -noupdate -format Logic /tb_src_mux/swsync_i
add wave -noupdate -format Logic /tb_src_mux/pbsync_i
add wave -noupdate -format Logic /tb_src_mux/pattern1_i
add wave -noupdate -format Logic /tb_src_mux/pixel_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
