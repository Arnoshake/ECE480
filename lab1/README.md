# ECE 480 — Lab 1: 2-Bit Comparator

## Overview

This repository contains the source code, simulation files, FPGA constraints, and documentation for ECE 480 Lab 1. The design implements and verifies a 2-bit comparator for the Basys 3 FPGA development board.

## Repository Structure

```text
LAB/
├── .gitignore
└── lab1/
    ├── src/
    │   ├── comparator.sv
    │   └── top.sv
    ├── sim/
    │   └── comparator_tb.sv
    ├── constr/
    │   └── basys3.xdc
    ├── README.md
    └── lab1_report.pdf
```

### File Descriptions

| File                   | Description                                                                                                                    |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `src/comparator.sv`    | SystemVerilog implementation of the 2-bit comparator.                                                                          |
| `src/top.sv`           | Top-level module that instantiates the comparator and connects its inputs and outputs to the Basys 3 switches and LEDs.        |
| `sim/comparator_tb.sv` | SystemVerilog testbench that uses nested `for` loops to test all possible input pairs and prints each test case for debugging. |
| `constr/basys3.xdc`    | Pin and timing constraints for the Basys 3 board.                                                                              |
| `README.md`            | Project overview, design description, verification strategy, and reproduction instructions.                                    |
| `lab1_report.pdf`      | Lab report containing the required truth table, block diagram, waveform evidence, and supporting analysis.                     |

## Design

The design is based on ECE 480 lecture material and in-class exercises covering 2-bit comparators. It compares two 2-bit operands and produces three outputs indicating their relationship.

### Inputs

* `a`: 2-bit operand assigned by `SW[1:0]`
* `b`: 2-bit operand assigned by `SW[3:2]`

### Outputs

* `aeqb`: Asserted when `a` equals `b`
* `altb`: Asserted when `a` is less than `b`
* `agtb`: Asserted when `a` is greater than `b`

### Comparator Operation

The comparator evaluates the corresponding bits of `a` and `b`, with the most significant bit (MSB) determining the result when the operands differ at that position. XNOR logic is used to identify equal corresponding bits. The MSB comparison is incorporated into the logic for the `altb` and `agtb` outputs.

The required truth table and block diagram are provided in `lab1_report.pdf`.

## Verification Strategy

The testbench uses nested `for` loops to exhaustively test all 16 possible input combinations of the two 2-bit operands.

For each test case, the testbench:

1. Assigns a pair of values to `a` and `b`.
2. Compares the comparator outputs against the expected results using equality and relational operators.
3. Prints the values of `a`, `b`, `aeqb`, `altb`, and `agtb`.
4. Prints an error message if any output does not match the expected result.

Successful completion of the nested loops confirms that all 16 input combinations were tested without detected errors.

Waveform evidence from the behavioral simulation is provided in `lab1_report.pdf`.

## FPGA Implementation

The design targets the Basys 3 FPGA development board. The top-level module maps the board switches to the comparator inputs and the comparator outputs to the board LEDs.

| Basys 3 I/O | Signal | Function             |
| ----------- | ------ | -------------------- |
| `SW[1:0]`   | `a`    | First 2-bit operand  |
| `SW[3:2]`   | `b`    | Second 2-bit operand |
| `LD1`       | `aeqb` | `a == b`             |
| `LD0`       | `agtb` | `a > b`              |
| `LD2`       | `altb` | `a < b`              |

Pin assignments are defined in `constr/basys3.xdc`.

## Engineering Issue and Vivado Verification

No significant issues were encountered during the Vivado workflow. Because the project was developed on a fresh installation of Ubuntu 24.04.4 LTS, USB drivers were installed to enable communication with the Basys 3 board.

Behavioral simulation was verified before hardware programming to identify logical errors early in the development process. This also provides a means of isolating potential hardware or software issues: if the behavioral simulation is correct, problems encountered during hardware programming can be investigated separately from the comparator logic.

This approach is particularly important for larger designs, where debugging problems later in the synthesis, implementation, or hardware stages can be significantly more difficult and time-consuming.

## Reproduction

This project was developed using **Vivado ML 2025.2 Standard Edition**.

To reproduce the design:

1. Create a Vivado project targeting the Basys 3 board.
2. Add the files in `src/` as design sources.
3. Add `sim/comparator_tb.sv` as a simulation source.
4. Add `constr/basys3.xdc` as the constraints file.
5. Run synthesis and implementation.
6. Generate the bitstream.
7. Program the Basys 3 board.
8. Test the comparator using the switches and LEDs.

Vivado-generated project, cache, synthesis, implementation, and simulation artifacts are excluded from the repository and can be regenerated from the submitted source, simulation, and constraint files.

## AI and External-Source Disclosure

### AI Assistance

AI assistance was used to establish the README format and structure, configure the Git repository for ECE 480, and assist with the installation of Vivado and the USB drivers required for the Basys 3 board.

### External Sources

The following sources were consulted:

* ECE 480 lecture notes and in-class exercises covering 2-bit comparators.
* Virtual Labs, IIT Roorkee, *Comparator Using Logic Gates*:
  https://de-iitr.vlabs.ac.in/exp/comparator-using-logic-gates/theory.html

## Author

**Zachary West**
ECE 480-001
08/29/2026

## Revision History

| Date       | Description     |
| ---------- | --------------- |
| 08/29/2026 | Initial version |

