# Synchronous FIFO Design and Verification

A synchronous First-In, First-Out (FIFO) buffer designed using **SystemVerilog** and simulated using **AMD Xilinx Vivado 2025.2** with XSim.

## Overview

This project implements a synchronous FIFO that stores data temporarily and outputs it in the same order in which it was written. It uses a shared clock for read and write operations, circular pointers, occupancy tracking, and full/empty status flags.

The project demonstrates RTL design, digital logic, and simulation-based functional verification.

## Design Specifications

Design type: Synchronous FIFO         
HDL : SystemVerilog               
Data width : 8 bits                      
FIFO depth : 8 entries                
Simulator : Vivado XSim                 
Read/write interface: Synchronous control signals 

## Features

- Parameterized data width and FIFO depth
- Circular read and write pointers
- Occupancy counter to track stored entries
- `full` flag to indicate when the FIFO is full
- `empty` flag to indicate when the FIFO is empty
- Reset support
- Testbench-based functional verification

## Repository Structure

```text
SystemVerilog-Synchronous-FIFO/
├── rtl/
│   └── sync_fifo.sv
├── tb/
│   └── tb_sync_fifo.sv
├── reports/
│   └── synthesis reports (optional)
└── README.md
```

## Simulation and Verification

The design was simulated using Vivado XSim.

The initial testbench checks:

- FIFO reset and initial empty status
- Writing and reading data in FIFO order
- Empty flag deassertion after writing data
- Full flag assertion after filling the FIFO
- Full flag deassertion after a read
- Return to empty status after all data is read

**Simulation result:** `PASS: FIFO basic tests completed`

The simulation completed at 320 ns.

## Tools Used

- SystemVerilog
- AMD Xilinx Vivado 2025.2
- XSim behavioral simulator

## Future Improvements

- Add simultaneous read/write verification
- Test reset while the FIFO contains data
- Test attempted reads while empty and writes while full
- Add SystemVerilog assertions and functional coverage
- Compare synthesis resource utilization and timing
- Explore FPGA implementation on a compatible Zynq-7000 board

## Learning Outcomes

- RTL implementation of sequential digital systems
- FIFO pointer and occupancy management
- Full/empty flag generation
- SystemVerilog testbench development
- Behavioral simulation and debugging in Vivado

## Author

**Charitha S Jain**

Electronics and Communication Engineering | PES University
