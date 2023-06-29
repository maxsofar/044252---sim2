// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------
    logic [7:0] a_out;
    logic [15:0] b_out;
    logic [24:0] multi_out;
    logic [63:0] shift_out;
    logic [63:0] adder_out;
    logic [63:0] ff_out;

    //a mux
    always_comb begin
        case (a_sel)
            2'd0: a_out = a[7:0];
            2'd1: a_out = a[15:8];
            2'd2: a_out = a[23:16];
            2'd3: a_out = a[31:24];
            default: a_out = 8'd0;
        endcase
    end

    //b mux
    always_comb begin
        case (b_sel)
            1'b0: b_out = b[15:0];
            1'b1: b_out = b[31:16];
            default: b_out = 16'd0;
        endcase
    end

    //16x8 multiplier
    always_comb begin
        multi_out = b_out * a_out;
    end

    //shifter
    always_comb begin
    case (shift_sel)
        3'd0: shift_out = multi_out << 0;
        3'd1: shift_out = multi_out << 8;
        3'd2: shift_out = multi_out << 16;
        3'd3: shift_out = multi_out << 24;
        3'd4: shift_out = multi_out << 32;
        3'd5: shift_out = multi_out << 40;
        default: shift_out = 64'd0;
    endcase
    end

    //adder
    always_comb begin
        adder_out = shift_out + ff_out;
    end

    //flip flop
    always_ff @(posedge clk, posedge reset) begin
        if (reset == 1) begin
            ff_out <= 64'd0;
        end
        else begin
            if (clr_prod == 1'b1) begin
                ff_out <= 64'd0;
            end
            else if (upd_prod == 1'b1) begin
                ff_out <= adder_out;
            end
        end
    end

    assign product = ff_out;

// End of your code

endmodule
