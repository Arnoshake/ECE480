# ECE 481 Lab 3: Counters, Registers, and Register Bank

## Git Repository URL
* **Repository URL:** `https://github.com/Arnoshake/ECE480`

---

## Submitted Modules and Purpose

| Module Name | File Location | Purpose & Implementation Details |
| :--- | :--- | :--- |
| `counter` | `src/counter.sv` | Parameterized synchronous up/down counter (`WIDTH`)[cite: 1]. Implements synchronous active-high reset (`rst`), count enable (`en`), directional counting (`up`), and natural modulo-$2^{\text{WIDTH}}$ rollover using `always_ff` and nonblocking assignments. |
| `register_bank` | `src/register_bank.sv` | Parameterized register bank ($M$ registers of width $W$). Features synchronous reset to zero, synchronous write logic controlled by `wr_en` and `wr_addr`, and asynchronous combinational read logic using `$clog2(M)` addressing. |
| `tick_generator` | `src/tick_generator.sv` | Parameterized frequency divider that retains the 100 MHz oscillator as the system clock while producing a periodic, single-cycle enable pulse (`tick`) at ~1–2 Hz[cite: 1]. Parameterized to allow rapid simulation cycles. |
| `lab3_top` | `src/lab3_top.sv` | Basys3 top-level integration module[cite: 1]. Connects the 100 MHz clock, inputs (`btnC`, `sw[0]`, `sw[1]`), tick generator, and parameterized 4-bit counter to the output LEDs (`led[3:0]`). |
| `tb_counter` | `sim/tb_counter.sv` | Self-checking testbench that automatically calculates expected values and tests synchronous reset, hold (`en=0`), directional counting, and maximum/minimum rollovers across `WIDTH=4` and `WIDTH=8`. |
| `tb_register_bank` | `sim/tb_register_bank.sv` | Self-checking testbench that verifies reset, sequential writes, out-of-order reads, data retention, address switching propagation, and read-after-write behavior across configurations ($M=4, W=8$) and ($M=8, W=4$). |


---

## Instructions to Reproduce Simulations and Hardware Build

### 1. Simulation Reproduction
To run the simulations in Vivado, add the corresponding design and testbench files to your simulation set and run behavioral simulation:

* **Counter Simulation:**
  * **Files needed:** `src/counter.sv`, `sim/tb_counter.sv`
  * Set `tb_counter` as the top module and run Behavioral Simulation.

* **Register Bank Simulation:**
  * **Files needed:** `src/register_bank.sv`, `sim/tb_register_bank.sv`
  * Set `tb_register_bank` as the top module and run Behavioral Simulation.

### 2. Hardware Build and Programming
1. Launch AMD Vivado and create an RTL project targeting the **Basys3 board** (`xc7a35tcpg236-1`).
2. Add all files in `src/` to the design sources set.
3. Add `constr/Basys3.xdc` to the constraints set.
4. Set `lab3_top` as the top-level module in the design hierarchy.
5. Run **Synthesis** and **Implementation**.
6. Open the implemented design and generate the **Timing Summary Report** to confirm:
   * The 100 MHz clock constraint (`period 10.00 ns`) is satisfied.
   * The Worst Negative Slack (WNS) is nonnegative ($\text{WNS} \ge 0$).
7. Generate the bitstream file (`.bit`) and program the physical Basys3 hardware via Vivado Hardware Manager.

---

## AI and External Source Disclosure

* **Generative AI Usage:**
  * Used Gemini in order to create the format/layout of the README, report, and directory layout.
