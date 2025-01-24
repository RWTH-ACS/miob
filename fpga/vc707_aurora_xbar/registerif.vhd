----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2024 11:02:57 AM
-- Design Name: 
-- Module Name: register - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerif is
    generic (
        C_AXI_DATA_WIDTH : integer := 32;
        C_AXI_ADDR_WIDTH : integer := 32;
        REG_ADDR_WIDTH   : integer := 10 -- 1024 words
    );
    Port ( -- AXI4 Lite Interface
       S_AXI_ACLK       : in STD_LOGIC;
       S_AXI_ARESETN    : in STD_LOGIC;
       -- Write Address Channel
       S_AXI_AWVALID    : in STD_LOGIC := '0';
       S_AXI_AWREADY    : out STD_LOGIC := '1';
       S_AXI_AWADDR     : in STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
       S_AXI_AWPROT     : in STD_LOGIC := '0'; -- always use normal access
       -- Write Data Channel
       S_AXI_WVALID     : in STD_LOGIC := '0';
       S_AXI_WREADY     : out STD_LOGIC := '0';
       S_AXI_WDATA      : in STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       S_AXI_WSTRB      : in STD_LOGIC := '1';
       -- Write Return Channel
       S_AXI_BVALID     : out STD_LOGIC := '0';
       S_AXI_BREADY     : in STD_LOGIC := '0';
       S_AXI_BRESP      : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0'); -- 00 means respond OKAY
       -- Read Address Channel
       S_AXI_ARVALID    : in STD_LOGIC := '0';
       S_AXI_ARREADY    : out STD_LOGIC := '1';
       S_AXI_ARADDR     : in STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
       S_AXI_ARPROT     : in STD_LOGIC := '0'; -- always use normal access
       -- Read Data Channel
       S_AXI_RVALID     : out STD_LOGIC := '0';
       S_AXI_RREADY     : in STD_LOGIC := '1';
       S_AXI_RRESP      : out STD_LOGIC_VECTOR(1 downto 0) := "00"; -- always respond OKAY
       S_AXI_RDATA      : out STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       
       -- output ports
       out1             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out2             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out3             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out4             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out5             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out6             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out7             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out8             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out9             : out STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       
       out1_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out2_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out3_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out4_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out5_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out6_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out7_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out8_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
       out9_default     : in STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0')
       );
end registerif;

architecture Behavioral of registerif is
    signal awready : STD_LOGIC := '1';
    signal bvalid : STD_LOGIC := '0';
    signal rvalid : STD_LOGIC := '0';
    signal arready : STD_LOGIC := '0';
    signal init_done : STD_LOGIC := '0';
    signal out1_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out2_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out3_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out4_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out5_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out6_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out7_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out8_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
    signal out9_reg : STD_LOGIC_VECTOR(C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
begin

-- read channel
S_AXI_RVALID <= rvalid;
arready <= not rvalid;      
S_AXI_ARREADY <= arready;
process (S_AXI_ACLK, S_AXI_ARESETN, rvalid, S_AXI_ARVALID, S_AXI_RREADY, arready, S_AXI_ARADDR, out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg, out7_reg, out8_reg, out9_reg) begin
    if rising_edge(S_AXI_ACLK) then
        if S_AXI_ARESETN = '0' then
            rvalid <= '0';
            S_AXI_RRESP <= (others => '0');
            S_AXI_RDATA <= (others => '0');
        else
            if S_AXI_ARVALID = '1' and arready = '1' then
                rvalid <= '1';
            elsif S_AXI_RREADY = '1' then
                rvalid <= '0';
            end if;
            if (rvalid = '0' or S_AXI_RREADY = '1') then 
                case S_AXI_ARADDR(REG_ADDR_WIDTH-1 downto 0) is
                    when std_logic_vector(to_unsigned(0, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out1_reg;
                    when std_logic_vector(to_unsigned(4, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out2_reg;
                    when std_logic_vector(to_unsigned(8, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out3_reg;
                    when std_logic_vector(to_unsigned(12, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out4_reg;
                    when std_logic_vector(to_unsigned(16, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out5_reg;
                    when std_logic_vector(to_unsigned(20, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out6_reg;
                    when std_logic_vector(to_unsigned(24, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out7_reg;
                    when std_logic_vector(to_unsigned(28, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out8_reg;
                    when std_logic_vector(to_unsigned(32, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= out9_reg;
                    when std_logic_vector(to_unsigned(512, REG_ADDR_WIDTH)) =>
                        S_AXI_RDATA <= (others => '0');
                    when others =>
                        S_AXI_RDATA <= x"DEAD_BEEF";
                end case;
            end if;
        end if;
    end if;
end process;
-- write channel
S_AXI_AWREADY <= awready;
S_AXI_WREADY <= awready;
S_AXI_BVALID <= bvalid;
process (S_AXI_ACLK, S_AXI_ARESETN, awready, out1_reg, out2_reg, out3_reg, out4_reg,
         out5_reg, out6_reg, out7_reg, out8_reg,
         S_AXI_AWVALID, S_AXI_WVALID, bvalid, S_AXI_BREADY, S_AXI_AWADDR, S_AXI_WDATA, 
         S_AXI_BREADY, out1_default, out2_default, out3_default, out4_default, out5_default, out6_default, out7_default, out8_default, out9_default) begin
    if rising_edge(S_AXI_ACLK) then
        out1 <= out1_reg;
        out2 <= out2_reg;
        out3 <= out3_reg;
        out4 <= out4_reg;
        out5 <= out5_reg;
        out6 <= out6_reg;
        out7 <= out7_reg;
        out8 <= out8_reg;
        out9 <= out9_reg;
        if S_AXI_ARESETN = '0' or init_done = '0' then
            out1_reg <= out1_default;
            out2_reg <= out2_default;
            out3_reg <= out3_default;
            out4_reg <= out4_default;
            out5_reg <= out5_default;
            out6_reg <= out6_default;
            out7_reg <= out7_default;
            out8_reg <= out8_default;
            out9_reg <= out9_default;
            init_done <= '1';
            awready <= '1';
            bvalid <= '0';
            S_AXI_BRESP <= (others => '0');
        else
            awready <= init_done and not awready and 
                (S_AXI_AWVALID and S_AXI_WVALID) and
                (not bvalid or S_AXI_BREADY);
            
            if awready = '1' then
                bvalid <= '1'; -- always respond okay to avoid bus errors
                case S_AXI_AWADDR(REG_ADDR_WIDTH-1 downto 0) is
                    when std_logic_vector(to_unsigned(0, REG_ADDR_WIDTH)) =>
                        out1_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(4, REG_ADDR_WIDTH)) =>
                        out2_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(8, REG_ADDR_WIDTH)) =>
                        out3_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(12, REG_ADDR_WIDTH)) =>
                        out4_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(16, REG_ADDR_WIDTH)) =>
                        out5_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(20, REG_ADDR_WIDTH)) =>
                        out6_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(24, REG_ADDR_WIDTH)) =>
                        out7_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(28, REG_ADDR_WIDTH)) =>
                        out8_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(32, REG_ADDR_WIDTH)) =>
                        out9_reg <= S_AXI_WDATA;
                    when std_logic_vector(to_unsigned(512, REG_ADDR_WIDTH)) =>
                        if S_AXI_WDATA(0) = '1' then
                            out1_reg <= out1_default;
                        end if;
                        if S_AXI_WDATA(1) = '1' then
                            out2_reg <= out2_default;
                        end if;
                        if S_AXI_WDATA(2) = '1' then
                            out3_reg <= out3_default;
                        end if;
                        if S_AXI_WDATA(3) = '1' then
                            out4_reg <= out4_default;
                        end if;
                        if S_AXI_WDATA(4) = '1' then
                            out5_reg <= out5_default;
                        end if;
                        if S_AXI_WDATA(5) = '1' then
                            out6_reg <= out6_default;
                        end if;
                        if S_AXI_WDATA(6) = '1' then
                            out7_reg <= out7_default;
                        end if;
                        if S_AXI_WDATA(7) = '1' then
                            out8_reg <= out8_default;
                        end if;
                        if S_AXI_WDATA(8) = '1' then
                            out9_reg <= out9_default;
                        end if;
                    when others =>
                end case;
            elsif S_AXI_BREADY = '1' then
                bvalid <= '0';
            end if;
        end if;
    end if;
end process;

end Behavioral;
