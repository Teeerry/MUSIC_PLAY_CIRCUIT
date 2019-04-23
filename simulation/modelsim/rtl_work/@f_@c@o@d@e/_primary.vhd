library verilog;
use verilog.vl_types.all;
entity F_CODE is
    port(
        INX             : in     vl_logic_vector(3 downto 0);
        CODE            : out    vl_logic_vector(3 downto 0);
        H               : out    vl_logic;
        \TO\            : out    vl_logic_vector(10 downto 0)
    );
end F_CODE;
