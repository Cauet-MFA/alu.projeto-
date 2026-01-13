module tb_alu_32;
    reg  [31:0] a, b;
    reg  [3:0] alu_control;
    wire [31:0] result;
    wire zero, carry_out, overflow;

    alu_32 dut(
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero),
        .carry_out(carry_out),
        .overflow(overflow)
    );

    initial begin
        a = 10; b = 5;
        alu_control = 4'b0010; #10;
        alu_control = 4'b0110; #10;
        alu_control = 4'b0000; #10;
        alu_control = 4'b0001; #10;
        alu_control = 4'b0111; #10;
        $stop;
    end
endmodule
