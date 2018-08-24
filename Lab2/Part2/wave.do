vlib work
vlog -timescale 1ns/1ns mux.v
vsim mux
log {/*}
add wave {/*}

force {SW[ 0 ]} 0
force {SW[ 1 ]} 1
force {SW[ 2 ]} 0
force {SW[ 3 ]} 1
run 10ns

force {SW[ 8 ]} 0
force {SW[ 9 ]} 0
run 10ns

force {SW[ 8 ]} 0
force {SW[ 9 ]} 1
run 10ns

force {SW[ 8 ]} 1
force {SW[ 9 ]} 0
run 10ns

force {SW[ 8 ]} 1
force {SW[ 9 ]} 1
run 10ns
