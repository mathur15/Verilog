# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all verilog modules in mux.v to working dir;
# could also have multiple verilog files.
vlog rippleadder.v -timescale 1ns/1ns

# Load simulation using mux as the top level simulation module.
vsim rippleadder

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# Test if everything set to 1 produces the correct output
force {SW[0]} 1
force {SW[1]} 1 
force {SW[2]} 1 
force {SW[3]} 1
force {SW[4]} 1 
force {SW[5]} 1 
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1
run 5ns

force {SW[0]} 1 0, 0 5
force {SW[1]} 0 0, 1 5
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1 0, 0 5
force {SW[5]} 0 0, 1 5
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0 
run 10ns

force {SW[0]} 0
force {SW[1]} 0 
force {SW[2]} 1 0, 0 5
force {SW[3]} 0 0, 1 5
force {SW[4]} 0
force {SW[5]} 0 
force {SW[6]} 1 0, 0 5
force {SW[7]} 0 0, 1 5
force {SW[8]} 0 
run 10ns
  
force {SW[0]} 0 0, 1 5
force {SW[1]} 0 0, 1 5
force {SW[2]} 1 
force {SW[3]} 0 0, 1 5
force {SW[4]} 0 0, 1 5
force {SW[5]} 1 
force {SW[6]} 0 0, 1 5
force {SW[7]} 0 0, 1 5
force {SW[8]} 1 0, 0 5
run 10ns

