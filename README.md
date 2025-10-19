# ⚙️ 8-Bit CPU (Verilog Implementation)

This repository contains the **Verilog implementation** of an **8-bit CPU**, developed as part of a group project requirement.  
The CPU follows an **accumulator-based architecture** and executes a set of **basic ALU and control operations**.

---

## 🧩 Overview

The CPU is designed to perform arithmetic, logic, and control instructions using an **8-bit data width** and a **5-bit program counter**.  
It simulates instruction fetching, decoding, and execution in a simplified architecture suitable for educational and testing purposes.

---

## 🔍 Features

- 🧠 **Accumulator-Based Design** – All operations use a single accumulator register  
- 🧮 **ALU Operations** – ADD, SUB, AND, OR, XOR, NOT, SHIFT LEFT  
- 🧾 **Program Counter (PC)** – 5-bit counter supports up to 32 instructions  
- 🧰 **Memory Array** – 32x8 instruction and data memory  
- 🧱 **Halt Mechanism** – Supports program termination via HALT opcode  
- 🧪 **Testbench Included** – Complete simulation testbench with `$dumpfile` and `$readmemb` integration

---

## 🧠 Instruction Set Architecture (ISA)

| Opcode | Binary | Operation | Description |
|:------:|:-------:|:----------|:-------------|
| HALT | 000 | Stop Execution | Stops program counter |
| ADD  | 001 | Acc ← Acc + M[addr] | Adds operand to accumulator |
| SUB  | 010 | Acc ← Acc - M[addr] | Subtracts operand |
| SHL  | 011 | Acc ← Shift Left | Rotates bits left |
| NOT  | 100 | Acc ← NOT(Acc) | Bitwise negation |
| AND  | 101 | Acc ← Acc AND M[addr] | Bitwise AND |
| OR   | 110 | Acc ← Acc OR M[addr] | Bitwise OR |
| XOR  | 111 | Acc ← Acc XOR M[addr] | Bitwise XOR |

---

## 🧰 File Structure
```
8bit-CPU-Verilog/
├── EightbitCPU.v # Main CPU Module
├── memory.mem # Instruction Memory File
└── README.md
```

---

## 🧪 Simulation Guide

### ▶️ Using Icarus Verilog (or any HDL simulator)
```bash
# Compile
iverilog -o cpu_sim EightbitCPU.v EightbitCPU_TB.v

# Run Simulation
vvp cpu_sim

# View Waveform (optional)
gtkwave CPU_Test.vcd
The memory.mem file contains preloaded instructions executed by the CPU.
```

### 👨‍💻 Developers
```
Developed by Computer Engineering Students:
ARMADO, James Neftali B.
ANDAL, Anthony Aries C.
BINOSA, Joyce C.
BUENAVENTURA, Ralph D.
CAPARAS, Mumphry S.
CARASIG, Janelle Isabel M.
CASTRO, Ia Micah G.
CERRO, Christian Paul
CORREA, Reingel F.
DELA CRUZ, Jay Vee A.
ERFE, Irysse J.
LORENZO, Yesuah Jirah D.

📍 Bulacan State University | Computer Architecture and Organization - Course Project 
🧾 Academic Term: 1st Semester, AY 2024–2025
```
