// Square root algorithm
// by Wallace Everest
// 23-NOV-2022
// https://github.com/navray/tt02-square-root
//
// Based on work by:
// Yamin Li and Wanming Chu, 
// "A new non-restoring square root algorithm and its VLSI implementations,"
// Proceedings of the 1996 International Conference on Computer Design,
// VLSI in Computers and Processors, October 1996 Pages 538–544

`default_nettype none

module sqrt (
  input  wire        clk,
  input  wire  [6:0] data_in,
  output logic [3:0] data_out
);

  typedef logic [6:0] i_type;
  typedef logic [3:0] o_type;
  typedef logic [5:0] r_type;
  i_type [0:4] d;
  o_type [0:4] q;
  r_type [0:4] r;
  r_type [0:4] x;
  r_type [0:4] y;
  logic  [0:4] sign;
  logic signed [5:0] alu [0:4];
  
  assign d[0] = data_in;
  assign q[0] = 4'b0;
  assign r[0] = 6'b0;
  assign data_out = q[4];

  for (genvar i = 0; i < 3; i++) begin : sqrt_gen
    assign sign[i] = r[i][5];  // sign of R is operand
    assign x[i]    = {r[i][3:0], d[i][6:5]};
    assign y[i]    = {q[i], sign[i], 1'b1};
    assign alu[i]  = (sign[i] == 1'b0) ? (signed'(x[i]) - signed'(y[i])) : (signed'(x[i]) + signed'(y[i]));

    always_ff @(posedge clk) begin : sqrt_reg
        d[i+1] <= {d[i][4:0], 2'b0};     // shift left 2-bit
        q[i+1] <= {q[i][2:0], ~alu[i][5]};  // shift left 1-bit
        r[i+1] <= alu[i];
    end : sqrt_reg
  end : sqrt_gen
endmodule
