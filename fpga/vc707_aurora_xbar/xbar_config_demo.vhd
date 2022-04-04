----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2022 06:11:15 PM
-- Design Name: 
-- Module Name: xbar_config_demo - Behavioral
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

entity xbar_config_demo is
    generic (
        C_AXI_DATA_WIDTH : integer := 32;
        C_AXI_ADDR_WIDTH : integer := 32
    );
    Port ( -- AXI4 Lite Interface
           S_AXI_ACLK       : in STD_LOGIC;
           S_AXI_ARESETN    : in STD_LOGIC;
           -- Write Address Channel
           S_AXI_AWVALID    : out STD_LOGIC := '0';
           S_AXI_AWREADY    : in STD_LOGIC; -- we are always ready to receive an address
           S_AXI_AWADDR     : out STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
           S_AXI_AWPROT     : out STD_LOGIC := '0'; -- always use normal access
           -- Write Data Channel
           S_AXI_WVALID     : out STD_LOGIC := '0';
           S_AXI_WREADY     : in STD_LOGIC;
           S_AXI_WDATA      : out STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
           S_AXI_WSTRB      : out STD_LOGIC := '1';
           -- Write Return Channel
           S_AXI_BVALID     : in STD_LOGIC;
           S_AXI_BREADY     : out STD_LOGIC := '1';
           S_AXI_BRESP      : in STD_LOGIC_VECTOR(1 downto 0); -- 00 means respond OKAY
           -- Read Address Channel
           S_AXI_ARVALID    : out STD_LOGIC := '0';
           S_AXI_ARREADY    : in STD_LOGIC;
           S_AXI_ARADDR     : out STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
           S_AXI_ARPROT     : out STD_LOGIC := '0'; -- always use normal access
           -- Read Data Channel
           S_AXI_RVALID     : in std_logic;
           S_AXI_RREADY     : out STD_LOGIC := '1';
           S_AXI_RRESP      : in STD_LOGIC_VECTOR(1 downto 0) := "00"; -- always respond OKAY
           S_AXI_RDATA      : in STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0')
           );
end xbar_config_demo;

architecture Behavioral of xbar_config_demo is
    constant mi0_config : std_logic_vector(31 downto 0) := x"0000_0001";
    constant mi0_addr : std_logic_vector(31 downto 0) := x"0000_0040";
    constant mi1_config : std_logic_vector(31 downto 0) := x"0000_0000";
    constant mi1_addr : std_logic_vector(31 downto 0) := x"0000_0044";
    constant mi2_config : std_logic_vector(31 downto 0) := x"0000_0003";
    constant mi2_addr : std_logic_vector(31 downto 0) := x"0000_0048";
    constant mi3_config : std_logic_vector(31 downto 0) := x"0000_0002";
    constant mi3_addr : std_logic_vector(31 downto 0) := x"0000_004C";
    
    constant commit_control : std_logic_vector(31 downto 0) := b"00000000_00000000_00000000_00000010";
    constant control_addr : std_logic_vector(31 downto 0) := x"0000_0000";
    
    
    type STATE_T is (INIT, MIx_PROG_ADDR, MIx_PROG_WRITE, COMMIT_ADDR, COMMIT_WRITE, IDLE);
    signal cnt : integer := 0;
    signal state : STATE_T := INIT;
    signal set : boolean := false;
begin
process (S_AXI_ACLK, S_AXI_ARESETN, S_AXI_AWREADY, S_AXI_WREADY, S_AXI_BVALID,
         S_AXI_BRESP, S_AXI_ARREADY, S_AXI_RVALID, S_AXI_RRESP, S_AXI_RDATA, state, cnt) begin
    if rising_edge(S_AXI_ACLK) then
        -- reset registers
        if S_AXI_ARESETN = '0' then
            state <= INIT;
        else
            case state is
            when INIT =>
                S_AXI_AWVALID <= '0';
                S_AXI_AWADDR <= (others => '0');
                S_AXI_WVALID <= '0';
                S_AXI_WDATA <= (others => '0');
                S_AXI_ARVALID <= '0';
                S_AXI_ARADDR <= (others => '0');
                cnt <= 0;
                state <= MIx_PROG_ADDR;
            when MIx_PROG_ADDR =>
                S_AXI_AWVALID <= '1';
                case cnt is
                when 0 =>
                    S_AXI_AWADDR <= MI0_ADDR;
                when 1 =>
                    S_AXI_AWADDR <= MI1_ADDR;
                when 2 =>
                    S_AXI_AWADDR <= MI2_ADDR;
                when 3 =>
                    S_AXI_AWADDR <= MI3_ADDR;
                when others =>
                end case;
                set <= S_AXI_AWREADY = '1';
                if set then
                    state <= MIx_PROG_WRITE;
                    set <= false;
                end if;                
            when MIx_PROG_WRITE =>
                S_AXI_WVALID <= '1';
                case cnt is
                when 0 =>
                    S_AXI_WDATA <= MI0_CONFIG;
                when 1 =>
                    S_AXI_WDATA <= MI1_CONFIG;
                when 2 =>
                    S_AXI_WDATA <= MI2_CONFIG;
                when 3 =>
                    S_AXI_WDATA <= MI3_CONFIG;
                when others =>
                end case;
                set <= S_AXI_WREADY = '1';
                if set then
                    set <= false;
                    S_AXI_WVALID <= '0';
                    S_AXI_AWVALID <= '0';
                    if cnt = 3 then
                        state <= COMMIT_ADDR;
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                    end if;
                end if;
            when COMMIT_ADDR => 
                S_AXI_WVALID <= '1';
                S_AXI_AWADDR <= control_addr;
                set <= S_AXI_AWREADY = '1';
                if set then
                    set <= false;
                    state <= COMMIT_WRITE;
                end if;
            when COMMIT_WRITE =>
                S_AXI_WVALID <= '1';
                S_AXI_WDATA <= commit_control;
                set <= S_AXI_WREADY = '1';
                if set then
                    set <= false;
                    state <= IDLE;
                    S_AXI_WVALID <= '0';
                    S_AXI_WVALID <= '0';
                end if;
            when IDLE =>
                S_AXI_AWVALID <= '0';
                S_AXI_AWADDR <= (others => '0');
                S_AXI_WVALID <= '0';
                S_AXI_WDATA <= (others => '0');
                S_AXI_ARVALID <= '0';
                S_AXI_ARADDR <= (others => '0');
                cnt <= 0;
            end case;
        end if;
     end if;
end process;

           


end Behavioral;

