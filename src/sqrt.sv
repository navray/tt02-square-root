// Title: Square-root algorithm in SystemVerlog
// Author: Wallace Everest
// Date: 23-NOV-2022
// https://github.com/navray/tt02-square-root
//
// Decription:
//   Based on work by Yamin Li and Wanming Chu, 
//   "A new non-restoring square root algorithm and its VLSI implementations,"
//   Proceedings of the 1996 International Conference on Computer Design,
//   VLSI in Computers and Processors, October 1996 Pages 538–544
//
// Implementation:
//   Code is parameterized to accept variable input width.
//   Output width is always half the input width.

`default_nettype none

module sqrt
#(parameter G_WIDTH = 8)  // size must be even
(
  input  wire                 clk,
  input  wire [G_WIDTH-1:0]   data_in,
  output wire [G_WIDTH/2-1:0] data_out
);

  typedef logic unsigned [G_WIDTH-1:0]   d_type;
  typedef logic unsigned [G_WIDTH/2-1:0] q_type;
  typedef logic signed   [G_WIDTH/2+1:0] r_type;
  d_type d    [0:G_WIDTH/2];
  q_type q    [0:G_WIDTH/2];
  r_type r    [0:G_WIDTH/2];
  r_type x    [0:G_WIDTH/2-1];
  r_type y    [0:G_WIDTH/2-1];
  r_type alu  [0:G_WIDTH/2-1];
  logic  sign [0:G_WIDTH/2-1];

  assign data_out = q[G_WIDTH/2];
  
  always_comb begin : sqrt_io
    d[0] = data_in;
    q[0] = '0;
    r[0] = '0;
  end : sqrt_io;
    
  for (genvar i = 0; i <= (G_WIDTH/2-1); i++) begin : sqrt_gen
    always_comb begin : sqrt_comb
      sign[i] = r[i][G_WIDTH/2+1];  // sign of R is operand
      x[i]    = {r[i][G_WIDTH/2-1:0], d[i][G_WIDTH-1:G_WIDTH-2]};
      y[i]    = {q[i], sign[i], 1'b1};
      alu[i]  = (sign[i] == 1'b0) ? (x[i] - y[i]) : (x[i] + y[i]);
    end : sqrt_comb;
    
    always_ff @(posedge clk) begin : sqrt_reg
        d[i+1] <= {d[i][G_WIDTH-3:0], 2'b0};  // left shift 2-bit
        q[i+1] <= {q[i][G_WIDTH/2-2:0], ~alu[i][G_WIDTH/2+1]};  // left shift 1-bit
        r[i+1] <= alu[i];
    end : sqrt_reg
  end : sqrt_gen
endmodule
