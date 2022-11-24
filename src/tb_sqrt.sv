// Square root testbench
// by Wallace Everest
// 23-NOV-2022
// https://github.com/navray/tt02-square-root

`default_nettype none

module tb_sqrt ();

  logic [7:0] io_in = 8'b0;
  logic [7:0] io_out;

  navray_top navray_top_dut (
    .io_in (io_in),
    .io_out(io_out)
  );
endmodule
