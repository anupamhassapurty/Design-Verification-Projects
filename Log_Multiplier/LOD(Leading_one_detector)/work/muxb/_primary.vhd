library verilog;
use verilog.vl_types.all;
entity muxb is
    port(
        a               : in     vl_logic;
        s               : in     vl_logic;
        y               : out    vl_logic
    );
end muxb;
