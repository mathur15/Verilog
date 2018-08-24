vlib work

vlog -timescale 1ns/1ns part2.v

vsim part2

log {/*}
add wave {/*}
force {ld} 0;
force {reset_n} 0;
force {clk} 0 0ns, 1 {10ns} -r 20ns
force {start} 0;
run 60ns

force {ld} 1;
force {reset_n} 1;
run 60ns

force {ld} 0;
run 60 ns

force {start} 1;
run 60ns

force {start} 0;
run 60ns

force {start} 1;
run 60ns

force {start} 0;
run 2000ns



