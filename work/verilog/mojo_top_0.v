/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input cclk,
    output reg spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output reg [3:0] spi_channel,
    input avr_tx,
    output reg avr_rx,
    input avr_rx_busy,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip,
    output reg [2:0] abc,
    input [1:0] cs
  );
  
  
  
  reg rst;
  
  reg startwait;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  reg [2:0] M_testingvalue_d, M_testingvalue_q = 1'h0;
  reg [7:0] M_testresult_d, M_testresult_q = 1'h0;
  localparam INIT_controller = 2'd0;
  localparam WAIT_controller = 2'd1;
  localparam ACTIVE_controller = 2'd2;
  localparam HALT_controller = 2'd3;
  
  reg [1:0] M_controller_d, M_controller_q = INIT_controller;
  wire [1-1:0] M_myDisplay_out;
  display_2 myDisplay (
    .clk(clk),
    .rst(rst),
    .out(M_myDisplay_out)
  );
  wire [1-1:0] M_step_out;
  delay_step1_3 step (
    .clk(clk),
    .rst(startwait),
    .out(M_step_out)
  );
  
  always @* begin
    M_controller_d = M_controller_q;
    M_testingvalue_d = M_testingvalue_q;
    M_testresult_d = M_testresult_q;
    
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    led = 8'h00;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    io_led = 24'h000000;
    io_seg = 8'hff;
    io_sel = 4'hf;
    startwait = 1'h0;
    abc = M_testingvalue_q;
    io_led[16+6+1-:2] = cs;
    io_led[16+0+1-:2] = M_testingvalue_q[0+0-:1] + M_testingvalue_q[1+0-:1] + M_testingvalue_q[2+0-:1];
    io_led[8+7-:8] = M_testingvalue_q;
    if (cs == (M_testingvalue_q[0+0-:1] + M_testingvalue_q[1+0-:1] + M_testingvalue_q[2+0-:1])) begin
      M_testresult_d[(M_testingvalue_q)*1+0-:1] = 1'h1;
    end
    
    case (M_controller_q)
      INIT_controller: begin
        startwait = 1'h1;
        M_controller_d = WAIT_controller;
      end
      WAIT_controller: begin
        if (M_step_out) begin
          M_controller_d = ACTIVE_controller;
        end
      end
      ACTIVE_controller: begin
        if (M_testingvalue_q == 3'h7) begin
          M_controller_d = HALT_controller;
        end else begin
          M_testingvalue_d = M_testingvalue_q + 1'h1;
          startwait = 1'h1;
          M_controller_d = WAIT_controller;
        end
      end
    endcase
    io_led[0+0+7-:8] = M_testresult_q;
    if (M_myDisplay_out) begin
      io_seg = 8'h86;
      io_sel = 4'he;
    end else begin
      io_seg = 8'hcb;
      io_sel = 4'hd;
    end
    if (M_myDisplay_out) begin
      io_seg = 8'h9f;
      io_sel = 4'h7;
    end else begin
      io_seg = 8'h02;
      io_sel = 4'hb;
    end
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_testingvalue_q <= 1'h0;
      M_testresult_q <= 1'h0;
      M_controller_q <= 1'h0;
    end else begin
      M_testingvalue_q <= M_testingvalue_d;
      M_testresult_q <= M_testresult_d;
      M_controller_q <= M_controller_d;
    end
  end
  
endmodule
