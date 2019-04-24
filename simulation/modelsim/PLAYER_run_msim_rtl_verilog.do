transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Altera_QuartusII_13.0/FPGA_2016141067_43/MUSIC_PLAY_CIRCUIT/source\ codes {D:/Altera_QuartusII_13.0/FPGA_2016141067_43/MUSIC_PLAY_CIRCUIT/source codes/CNT138T.v}

vlog -vlog01compat -work work +incdir+D:/Altera_QuartusII_13.0/FPGA_2016141067_43/MUSIC_PLAY_CIRCUIT/source\ codes {D:/Altera_QuartusII_13.0/FPGA_2016141067_43/MUSIC_PLAY_CIRCUIT/source codes/CNT138T_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  CNT138T_tb

add wave *
view structure
view signals
run -all
