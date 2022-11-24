// Top-level wrapper
// by Wallace Everest
// 23-NOV-2022
// https://github.com/navray/tt02-square-root

`default_nettype none

module navray_top (
  input  wire  [7:0] io_in,
  output logic [7:0] io_out
);

  assign io_out = 4'b0;
  
  sqrt sqrt_inst (
    .clk     (io_in[0]),
    .data_in (io_in[7:1]),
    .data_out(io_out[3:0])
  );
endmodule
