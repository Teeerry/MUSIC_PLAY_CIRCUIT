library verilog;
use verilog.vl_types.all;
entity CNT138T is
    port(
        CLK             : in     vl_logic;
        STATE           : in     vl_logic_vector(3 downto 0);
        end_addr        : in     vl_logic_vector(9 downto 0);
        start_addr      : in     vl_logic_vector(9 downto 0);
        CNT8            : out    vl_logic_vector(9 downto 0)
    );
end CNT138T;
