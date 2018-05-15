vsim -t ns -novopt -lib work work.tb_patterngen2
view *
do wave_patterngen2.do
run 2 sec
