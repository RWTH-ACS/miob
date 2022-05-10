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
           M_AXI_ACLK       : in STD_LOGIC;
           M_AXI_ARESETN    : in STD_LOGIC;
           -- Write Address Channel
           M_AXI_AWVALID    : out STD_LOGIC := '0';
           M_AXI_AWREADY    : in STD_LOGIC; -- we are always ready to receive an address
           M_AXI_AWADDR     : out STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
           M_AXI_AWPROT     : out STD_LOGIC := '0'; -- always use normal access
           -- Write Data Channel
           M_AXI_WVALID     : out STD_LOGIC := '0';
           M_AXI_WREADY     : in STD_LOGIC;
           M_AXI_WDATA      : out STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
           M_AXI_WSTRB      : out STD_LOGIC := '1';
           -- Write Return Channel
           M_AXI_BVALID     : in STD_LOGIC;
           M_AXI_BREADY     : out STD_LOGIC := '1';
           M_AXI_BRESP      : in STD_LOGIC_VECTOR(1 downto 0); -- 00 means respond OKAY
           -- Read Address Channel
           M_AXI_ARVALID    : out STD_LOGIC := '0';
           M_AXI_ARREADY    : in STD_LOGIC;
           M_AXI_ARADDR     : out STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
           M_AXI_ARPROT     : out STD_LOGIC := '0'; -- always use normal access
           -- Read Data Channel
           M_AXI_RVALID     : in std_logic;
           M_AXI_RREADY     : out STD_LOGIC := '1';
           M_AXI_RRESP      : in STD_LOGIC_VECTOR(1 downto 0) := "00"; -- always respond OKAY
           M_AXI_RDATA      : in STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0')
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
    constant mi4_config : std_logic_vector(31 downto 0) := x"0000_0005"; --add padding
    constant mi4_addr : std_logic_vector(31 downto 0) := x"0000_0050";
    constant mi5_config : std_logic_vector(31 downto 0) := x"0000_0004"; --remove last word
    constant mi5_addr : std_logic_vector(31 downto 0) := x"0000_0054";
    constant mi6_config : std_logic_vector(31 downto 0) := x"0000_0002";
    constant mi6_addr : std_logic_vector(31 downto 0) := x"0000_0058";
    constant mi7_config : std_logic_vector(31 downto 0) := x"0000_0003";
    constant mi7_addr : std_logic_vector(31 downto 0) := x"0000_005C";
    
    constant commit_control : std_logic_vector(31 downto 0) := b"00000000_00000000_00000000_00000010";
    constant control_addr : std_logic_vector(31 downto 0) := x"0000_0000";
    
    
    type STATE_T is (INIT, MIx_PROG, COMMIT, IDLE);
    signal cnt : integer := 0;
    signal state : STATE_T := INIT;
begin
process (M_AXI_ACLK, M_AXI_ARESETN, M_AXI_AWREADY, M_AXI_WREADY, M_AXI_BVALID,
         M_AXI_BRESP, M_AXI_ARREADY, M_AXI_RVALID, M_AXI_RRESP, M_AXI_RDATA, state, cnt) begin
    if rising_edge(M_AXI_ACLK) then
        -- reset registers
        if M_AXI_ARESETN = '0' then
            state <= INIT;
        else
            case state is
            when INIT =>
                M_AXI_AWVALID <= '0';
                M_AXI_AWADDR <= (others => '0');
                M_AXI_WVALID <= '0';
                M_AXI_WDATA <= (others => '0');
                M_AXI_ARVALID <= '0';
                M_AXI_ARADDR <= (others => '0');
                cnt <= 0;
                state <= MIx_PROG;
            when MIx_PROG =>
                M_AXI_WVALID <= '1';
                M_AXI_AWVALID <= '1';
                case cnt is
                when 0 =>
                    M_AXI_AWADDR <= MI0_ADDR;
                    M_AXI_WDATA <= MI0_CONFIG;
                when 1 =>
                    M_AXI_AWADDR <= MI1_ADDR;
                    M_AXI_WDATA <= MI1_CONFIG;
                when 2 =>
                    M_AXI_AWADDR <= MI2_ADDR;
                    M_AXI_WDATA <= MI2_CONFIG;
                when 3 =>
                    M_AXI_AWADDR <= MI3_ADDR;
                    M_AXI_WDATA <= MI3_CONFIG;
                when 4 =>
                    M_AXI_AWADDR <= MI4_ADDR;
                    M_AXI_WDATA <= MI4_CONFIG;
                when 5 =>
                    M_AXI_AWADDR <= MI5_ADDR;
                    M_AXI_WDATA <= MI5_CONFIG;
                when 6 =>
                    M_AXI_AWADDR <= MI6_ADDR;
                    M_AXI_WDATA <= MI6_CONFIG;
                when 7 =>
                    M_AXI_AWADDR <= MI7_ADDR;
                    M_AXI_WDATA <= MI7_CONFIG;
                when others =>
                end case;
                if M_AXI_AWREADY = '1' and M_AXI_WREADY = '1' then
                    if cnt = 7 then
                        state <= COMMIT;
                        cnt <= 0;
                    else
                        cnt <= cnt + 1;
                        state <= MIx_PROG;
                    end if;
                end if;
            when COMMIT =>
                M_AXI_WVALID <= '1'; 
                M_AXI_AWVALID <= '1';
                M_AXI_AWADDR <= control_addr;
                M_AXI_WDATA <= commit_control;
                if M_AXI_AWREADY = '1' and M_AXI_WREADY = '1' then
                    state <= IDLE;
                end if;
            when IDLE =>
                M_AXI_AWVALID <= '0';
                M_AXI_AWADDR <= (others => '0');
                M_AXI_WVALID <= '0';
                M_AXI_WDATA <= (others => '0');
                M_AXI_ARVALID <= '0';
                M_AXI_ARADDR <= (others => '0');           
                cnt <= 0;
            end case;
        end if;
     end if;
end process;

           


end Behavioral;

