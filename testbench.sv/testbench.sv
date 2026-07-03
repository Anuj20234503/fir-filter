`timescale 1ns/1ps

module testbench();

parameter N1=8;
parameter N2=16;
parameter N3=32;

reg clk;
reg rst;
reg enable;
reg [N2-1:0] input_data;
reg [N2-1:0] data[0:99];

wire [N3-1:0] output_data;
wire [N2-1:0] sampleT;

fir_filter instance1(
    .input_data(input_data),
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .output_data(output_data),
    .sampleT(sampleT)
);

integer k;
integer File1;

// Clock generation
always #10 clk = ~clk;

// Monitor
initial begin
    $monitor("t=%0t clk=%b rst=%b enable=%b input=%0d output=%0d",
             $time, clk, rst, enable, input_data, output_data);
end

// Debug print every clock
always @(posedge clk) begin
    $display("POSCLK t=%0t rst=%b enable=%b input=%0d sampleT=%0d output=%0d",
             $time, rst, enable, input_data, sampleT, output_data);
end

// Main stimulus
initial begin
    clk = 0;
    rst = 0;
    enable = 0;
    input_data = 0;

    $readmemb("input.txt", data);

    $display("data[0] = %b", data[0]);
    $display("data[1] = %b", data[1]);
    $display("data[2] = %b", data[2]);

    File1 = $fopen("save.data","w");

    #20 rst = 1'b1;
    #40 begin
        rst = 1'b0;
        enable = 1'b1;
    end

    input_data = data[0];

    for (k=1; k<100; k=k+1) begin
        @(posedge clk);
        $fdisplay(File1,"%b",output_data);
        input_data = data[k];
    end

    $fclose(File1);
    $display("Simulation completed");
    $finish;
end

endmodule
