module alu_32(
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alu_control,
    output reg [31:0] result,
    output wire zero,
    output wire carry_out,
    output wire overflow
);

    wire [31:0] b_mod;
    wire [32:0] carry;
    wire [31:0] result_add;

    assign b_mod    = (alu_control == 4'b0110) ? ~b : b;
    assign carry[0] = (alu_control == 4'b0110);

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : ADDER
            full_adder_1bit fa (
                .a(a[i]),
                .b(b_mod[i]),
                .cin(carry[i]),
                .sum(result_add[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign carry_out = carry[32];
    assign overflow  = carry[31] ^ carry[32];

    always @(*) begin
        case (alu_control)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = result_add;
            4'b0110: result = result_add;
            4'b0111: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0);

endmodule
