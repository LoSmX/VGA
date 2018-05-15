onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_io_ctl/reset_i
add wave -noupdate -format Logic /tb_io_ctl/en_i
add wave -noupdate -format Logic /tb_io_ctl/sw_i
add wave -noupdate -format Logic /tb_io_ctl/pb_i
add wave -noupdate -format Logic /tb_io_ctl/swsync_o
add wave -noupdate -format Logic /tb_io_ctl/pbsync_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
