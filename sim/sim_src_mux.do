vsim -t ns -novopt -lib work work.tb_src_mux 
view *
do wave_src_mux.do
run 1000 ns
