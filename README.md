# JTAG TAP Controller Finite State Machine (FPGA / VHDL)

## 📌 Project Overview
This project involves the design, simulation, and implementation of a JTAG (Joint Test Action Group) Test Access Port (TAP) controller using VHDL. The system is designed to target a **Xilinx Spartan-3E FPGA**. 

The TAP controller is the heart of JTAG IEEE 1149.1 boundary-scan technology, operating as a 16-state synchronous Finite State Machine (FSM). This project successfully models the state transitions controlled by the Test Mode Select (TMS) and Test Clock (TCK) signals, enabling device testing, debugging, and boundary-scan operations.

## 🛠️ Hardware & Software Tools
* **Target Hardware:** Xilinx Spartan-3E FPGA
* **Hardware Description Language:** VHDL
* **Development Environment:** Xilinx ISE / Vivado
* **Core Concepts:** Finite State Machines (FSM), Boundary-Scan Architecture, Serial Port Interfaces (SPI), JTAG IEEE 1149.1 Standard

## ⚙️ System Architecture
The design implements the standard 16-state TAP Controller FSM, which includes:
1. **TEST-LOGIC-RESET:** Disables test logic for normal device operation.
2. **RUN-TEST/IDLE:** Active state for specific instruction execution.
3. **Data Register (DR) Branches:** `SELECT-DR-SCAN`, `CAPTURE-DR`, `SHIFT-DR`, `UPDATE-DR` for shifting test data in and out of boundary scan cells.
4. **Instruction Register (IR) Branches:** `SELECT-IR-SCAN`, `CAPTURE-IR`, `SHIFT-IR`, `UPDATE-IR` for loading JTAG instructions (BYPASS, EXTEST, INTEST, etc.).

## 💻 Code Structure
* `jtag_boundaryscan.vhd`: The core RTL design containing the 16-state FSM. It monitors the `TMS` and `TRST` pins on the rising edge of `TCK` to transition between states.
* `tb_jtag_boundaryscan.vhd`: The VHDL testbench that simulates the clock, reset conditions, and provides specific TMS bit sequences to verify proper state transitions in the simulator.

## 🚀 How to Run the Simulation
1. Create a new project in Xilinx ISE, Vivado, or ModelSim.
2. Add `jtag_boundaryscan.vhd` as your design source.
3. Add `tb_jtag_boundaryscan.vhd` as your simulation source.
4. Run the Behavioral Simulation to observe the FSM state transitions on the waveform viewer.

## 📝 Reference
This project was developed as part of a B.Tech final year project in Electronics and Communication Engineering at Aliah University.
