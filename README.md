---

### **2. IPA Project README (RISC-V Processor)**

```markdown
# 64-bit Pipelined RISC-V Processor in Verilog

## Overview
This repository contains the complete Verilog implementation of a fully functional, pipelined 64-bit RISC-V processor. Developed as part of the academic curriculum at IIIT Hyderabad, this design tackles complex computer architecture challenges, specifically focusing on advanced pipeline optimization, dynamic hazard resolution, and early branching mechanisms to maximize instruction throughput.

## Key Features
* **Architecture:** 64-bit processor featuring a classic 5-stage instruction pipeline.
* **Advanced Mechanisms:** Early Branching, Data Forwarding, and Hazard Detection.
* **Verification:** Rigorous cycle-by-cycle waveform analysis and testbench validation for complex overlapping instruction sequences.

## Design Highlights
* **Early Branching Mechanism:** Custom logic computes branch target addresses and evaluates conditions early in the pipeline, drastically reducing branch penalties and unnecessary pipeline flushes.
* **Advanced Forwarding Logic:** A robust bypassing unit resolves Data Hazards on the fly by feeding newly computed values directly back into the ALU before they are written to the register file.
* **Hazard Detection Unit:** Intelligent control logic stalls the pipeline and inserts bubbles (NOPs) only when absolutely necessary (e.g., during load-use hazards that forwarding cannot resolve).
* **64-bit ALU:** Fully realized arithmetic logic unit capable of executing the base RISC-V integer instruction set.

## Processor Architecture Strategy
* Clear separation of the 5 pipeline stages (Instruction Fetch, Decode, Execute, Memory, Writeback) with discrete pipeline registers.
* Interconnected Forwarding and Hazard Detection units designed to minimize stall cycles without breaking instruction dependencies.
* The detailed datapath routing and control signal methodology are presented in the project report.

## Performance
* **Throughput:** Significantly higher Instructions Per Cycle (IPC) compared to single-cycle or non-forwarding pipelined architectures.
* **Branch Penalty:** Minimized due to the early branching evaluation logic.

## Software Tools Used
* **HDL Compilation & Simulation:** Icarus Verilog
* **Waveform Viewing:** GTKWave
* **Development Environment:** VS Code

## Advantages and Disadvantages
### Advantages
* Data forwarding nearly eliminates stall cycles for standard data dependencies.
* Early branching prevents massive pipeline flushes, maintaining high throughput.
* Modular Verilog design allows for straightforward debugging of individual pipeline stages.
### Disadvantages
* The inclusion of forwarding multiplexers and hazard detection logic increases the overall hardware complexity and critical path delay slightly.
* Lacks dynamic branch prediction, meaning some branch penalties still occur.

## Documentation
The complete design methodology, datapath diagrams, forwarding truth tables, hazard resolution strategies, and waveform analyses are discussed in detail in the project report (`Final_Report_IPA.pdf`).

## Future Improvements
### Performance Enhancements
* **Branch Prediction:** Implement a dynamic branch predictor (like a Branch Target Buffer) to further reduce penalties.
* **Memory Hierarchy:** Integrate L1 Data and Instruction caches to reduce memory access latency.
### Functionality Extensions
* **Instruction Set:** Expand support to include RISC-V 'M' (Multiply/Divide) or 'F' (Floating Point) extensions.

## Repository Structure
```text
Pipelined-RISC-V-processor-in-VERILOG-/
├── src/                             # Verilog source files (ALU, Pipeline Stages, Control Units)
├── testbenches/                     # Verilog testbenches for hazard and forwarding verification
├── Final_Report_IPA.pdf             # Detailed report (architecture, hazard logic, waveforms)
└── README.md                        # Repository documentation