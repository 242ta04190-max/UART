`timescale 1ns/1ps

module tb_uart;

    reg clk;
    reg rst;

    reg       tx_start;
    reg [7:0] tx_data;

    wire       tx;
    wire       tx_busy;
    wire       tx_done;

    wire [7:0] rx_data;
    wire       rx_valid;

    uart_top #(
        .CLKS_PER_BIT(16)
    ) uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .rx(tx),
        .tx(tx),
        .tx_busy(tx_busy),
        .tx_done(tx_done),
        .rx_data(rx_data),
        .rx_valid(rx_valid)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("uart.vcd");
        $dumpvars(0, tb_uart);

        $monitor("Time=%0t | TX=%b | TX_BUSY=%b | TX_DONE=%b | RX_DATA=%h | RX_VALID=%b",
                 $time, tx, tx_busy, tx_done, rx_data, rx_valid);

        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        #20;
        rst = 0;

        // Transmit 0xA5
        #20;
        tx_data = 8'hA5;
        tx_start = 1;

        #10;
        tx_start = 0;

        // Wait for transmission and reception
        #1800;

        // Transmit another byte: 0x3C
        tx_data = 8'h3C;
        tx_start = 1;

        #10;
        tx_start = 0;

        #1800;

        $finish;
    end

endmodule