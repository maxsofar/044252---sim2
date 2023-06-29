// 32X32 Multiplier test template
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
    mult32x32 uut(
    .clk(clk),           
    .reset(reset),         
    .start(start),         
    .a(a),
    .b(b),      
    .busy(busy),         
    .product(product)
    );

    initial begin
        clk = 1'b0;
        start = 1'b0;

        //Set reset for 4 cycles
        reset = 1'b1;
        #40
        reset = 0'b0;

        #5
        // Set inputs to student IDs for one clock cycle
        a = 32'd332330489;
        b = 32'd207964701;

        #10

        // Start for one cycle
        start = 1'b1;
        #10
        start = 1'b0;
        
        // Wait for busy signal to go low
        @(negedge busy);

    end

    always begin
        #5
        clk = ~clk;
    end

// End of your code

endmodule

