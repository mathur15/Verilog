
# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all verilog modules in mux.v to working dir;
# could also have multiple verilog files.
vlog -timescale 1ns/1ns part2.v

# Load simulation using mux as the top level simulation module.
vsim part2

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}
# Set input values using the force command, signal names need to be in {} brackets.
force {CLOCK_50} 0 0, 1 5 -r 10
force {KEY[0]} 0 0, 1 10

force {KEY[1]} 1 0, 0 10 
force {KEY[1]} 1 20, 0 30
force {KEY[1]} 1 40, 0 50
force {KEY[1]} 1 60, 0 70
force {KEY[1]} 1 80, 0 90
force {SW[7:0]} 00000111 0, 000001111 20, 00001010 40, 00000010 60
# Run simulation for a few ns.
run 200 ns
