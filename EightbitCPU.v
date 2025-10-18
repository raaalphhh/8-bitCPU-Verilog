`timescale 1ns/100ps
module EightbitCPU (
    input clk_signal,        // Clock Input
    input reset_n,           // Reset Input
    output halt_signal       // HALT Output Signal
);

    reg [4:0] program_counter;     // Program Counter
    reg [7:0] accumulator;         // Accumulator Register

    reg [7:0] data_memory [0:31];  // 32x8 Memory Array

    wire [7:0] current_instruction = data_memory[program_counter];
    wire [2:0] operation_code = current_instruction[7:5];
    wire [4:0] operand_address = current_instruction[4:0];
    wire [7:0] operand_value = data_memory[operand_address];

    // CPU Operations on Positive Clock Edge
    always @(posedge clk_signal) begin
        if (reset_n) begin
            program_counter <= 5'd0; // Reset Program Counter
        end else begin
            case (operation_code)
                3'b000: begin
                    program_counter <= program_counter; // HALT Operation
                end

                3'b001: begin
                    accumulator <= accumulator + operand_value; // ADD Operation
                    program_counter <= program_counter + 1;
                end

                3'b010: begin
                    accumulator <= accumulator - operand_value; // SUB
                    program_counter <= program_counter + 1;
                end

                3'b011: begin
                    accumulator <= accumulator << 1 | (accumulator >> 7); // SL (Shift Left)
                    program_counter <= program_counter + 1;
                end

                3'b100: begin
                    accumulator <= ~accumulator; // NOT Operation
                    program_counter <= program_counter + 1;
                end

                3'b101: begin
                    accumulator <= accumulator & operand_value; // AND Operation
                    program_counter <= program_counter + 1;
                end

                3'b110: begin
                    accumulator <= accumulator | operand_value; // OR Operation
                    program_counter <= program_counter + 1;
                end

                3'b111: begin
                    accumulator <= accumulator ^ operand_value; // XOR Operation
                    program_counter <= program_counter + 1;
                end
            endcase
        end
    end

    assign halt_signal = (operation_code == 3'b000); // HALT Condition

endmodule

`timescale 1ns/100ps
module EightbitCPU_TB();

    reg clk_tb;            // Testbench Clock
    reg rst_tb;            // Testbench Reset
    wire halt_tb;          // HALT Signal in Testbench

    integer idx;

    // Clock Generation
    initial begin
        clk_tb = 0;
        rst_tb = 1;
        #5 rst_tb = 0;
        forever #2 clk_tb = ~clk_tb; // Toggle Clock
    end

    // Instantiate the CPU Module
    EightbitCPU uut (
        .clk_signal(clk_tb),
        .reset_n(rst_tb),
        .halt_signal(halt_tb)
    );

    // Initialize Memory and Registers
    initial begin
        $dumpfile("CPU_Test.vcd");
        $dumpvars(1, EightbitCPU_TB);
        #10;
        for (idx = 0; idx < 32; idx = idx + 1) begin
            uut.data_memory[idx] = 8'b0; // Clear Memory
        end
        uut.accumulator = 8'b0000_0000;
        uut.program_counter = 5'b00000;
    end

    // Load Memory Data
    initial begin
        #10;
        $readmemb("memory.mem", uut.data_memory); // Load Memory File
    end

    // Display Test Results
    initial begin
        #15;
        for (idx = 0; idx < 32; idx = idx + 1) begin
            $display("======================================");
            $display(" Memory Address      : %0d", idx);
            $display(" Memory Data         : %b", uut.data_memory[idx]);
            $display(" HALT Status         : %b", halt_tb);
            $display(" Current Instruction : %b", uut.current_instruction);
            $display(" Opcode              : %b", uut.operation_code);
            $display(" Operand Address     : %b", uut.operand_address);
            $display(" Program Counter     : %b", uut.program_counter);
            $display(" Accumulator Value   : %b", uut.accumulator);
            $display(" Operand Data        : %b", uut.operand_value);
            $display("======================================");
            #2;
        end
        #100 $finish;
    end

endmodule

