# UART Verilog Project

## 📌 Project Overview

This project implements a basic **UART (Universal Asynchronous Receiver/Transmitter)** using Verilog HDL.

UART is a serial communication protocol commonly used to transfer data between digital systems.

This project implements:

* UART Transmitter
* UART Receiver
* UART Top Module
* Verilog Testbench
* Simulation waveform

The design uses an **8-bit data format with 1 start bit and 1 stop bit, without parity**.

## 🔹 UART Configuration

| Parameter     | Value        |
| ------------- | ------------ |
| Data bits     | 8            |
| Start bits    | 1            |
| Stop bits     | 1            |
| Parity        | None         |
| Data order    | LSB first    |
| Communication | Asynchronous |

## 🔹 UART Frame

Each transmitted byte follows this format:

```text
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
  1  |   0   |       8 Data Bits       |               1
```

The UART line remains HIGH when idle.

A transmission begins with a LOW start bit, followed by the eight data bits, and ends with a HIGH stop bit.

## 📂 Project Structure

```text
uart-verilog/
│
├── README.md
│
├── src/
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── uart_top.v
│
├── testbench/
│   └── tb_uart.v
│
└── simulation/
    └── waveform.png
```

## 💻 UART Transmitter

The transmitter accepts an 8-bit parallel input:

```text
tx_data[7:0]
```

When `tx_start` is asserted, the transmitter sends the data serially through the `tx` output.

The transmitter provides:

* `tx_busy` – indicates that transmission is in progress
* `tx_done` – indicates that transmission has completed

## 📡 UART Receiver

The receiver monitors the serial `rx` input.

When it detects a start bit, it samples the incoming data bits and reconstructs the original 8-bit value.

The receiver provides:

* `rx_data[7:0]` – received byte
* `rx_valid` – indicates that a complete byte has been received

## 🔁 Loopback Simulation

For simulation, the transmitter output is connected directly to the receiver input.

```text
        +-------------+
        | UART TX     |
        |             |
Data -->|             |---- TX
        +-------------+     |
                             |
                             v
                       +-------------+
                       | UART RX     |
                       |             |
                       +-------------+
                             |
                             v
                         RX DATA
```

This allows the transmitted data to be automatically received and verified.

## 🧪 Testbench

The testbench sends two bytes:

```text
0xA5
0x3C
```

The receiver should reconstruct the same values.

Expected results:

```text
Transmitted: A5
Received:    A5

Transmitted: 3C
Received:    3C
```

## 🛠️ Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* GitHub

## ▶️ Simulation

Navigate to the project directory and compile the Verilog files:

```bash
iverilog -o uart_sim src/uart_tx.v src/uart_rx.v src/uart_top.v testbench/tb_uart.v
```

Run the simulation:

```bash
vvp uart_sim
```

The simulation generates:

```text
uart.vcd
```

## 📊 View Waveform

Open the generated waveform using GTKWave:

```bash
gtkwave uart.vcd
```

Add these signals to the waveform:

```text
clk
rst
tx_start
tx_data
tx
tx_busy
tx_done
rx_data
rx_valid
```

Save the waveform screenshot as:

```text
simulation/waveform.png
```

## 📋 Expected Simulation

During transmission of `8'hA5`, the serial TX signal contains the UART frame for that byte.

After the complete frame has been received:

```text
rx_data  = A5
rx_valid = 1
```

For the second byte:

```text
rx_data  = 3C
rx_valid = 1
```

## 🎯 Applications of UART

UART communication is used in:

* Microcontroller communication
* FPGA development boards
* Serial terminals
* Debug interfaces
* Embedded systems
* GPS modules
* Bluetooth modules
* Communication between digital systems

## 📚 Learning Outcomes

This project demonstrates:

* UART serial communication
* Finite state machines
* Verilog HDL
* Serial-to-parallel conversion
* Parallel-to-serial conversion
* Testbench development
* Loopback testing
* Icarus Verilog simulation
* GTKWave waveform analysis
* GitHub project organization

## 👩‍💻 Author

**Honey Praveena**

## 📄 License

This project is created for educational and academic purposes.
