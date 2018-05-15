onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_Top/reset_i
add wave -noupdate -format Logic /tb_Top/en_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ms}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
