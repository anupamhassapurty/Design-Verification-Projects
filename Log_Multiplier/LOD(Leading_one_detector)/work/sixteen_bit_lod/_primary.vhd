library verilog;
use verilog.vl_types.all;
entity sixteen_bit_lod is
    port(
        d               : in     vl_logic_vector(15 downto 0);
        o               : out    vl_logic_vector(15 downto 0);
        zero_input_flag : out    vl_logic
    );
end sixteen_bit_lod;
