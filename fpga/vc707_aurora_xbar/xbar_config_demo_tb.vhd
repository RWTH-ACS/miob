----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2022 10:31:29 AM
-- Design Name: 
-- Module Name: xbar_config_demo_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity xbar_config_demo_tb is
--  Port ( );
end xbar_config_demo_tb;

architecture Behavioral of xbar_config_demo_tb is
    component xbar_config_demo is
    Port ( -- AXI4 Lite Interface
           M_AXI_ACLK       : in STD_LOGIC;
           M_AXI_ARESETN    : in STD_LOGIC;
           -- Write Address Channel
           M_AXI_AWVALID    : out STD_LOGIC;
           M_AXI_AWREADY    : in STD_LOGIC;
           M_AXI_AWADDR     : out STD_LOGIC_VECTOR (31 downto 0);
           M_AXI_AWPROT     : out STD_LOGIC;
           -- Write Data Channel
           M_AXI_WVALID     : out STD_LOGIC;
           M_AXI_WREADY     : in STD_LOGIC;
           M_AXI_WDATA      : out STD_LOGIC_VECTOR (31 downto 0);
           M_AXI_WSTRB      : out STD_LOGIC;
           -- Write Return Channel
           M_AXI_BVALID     : in STD_LOGIC;
           M_AXI_BREADY     : out STD_LOGIC;
           M_AXI_BRESP      : in STD_LOGIC_VECTOR(1 downto 0);
           -- Read Address Channel
           M_AXI_ARVALID    : out STD_LOGIC;
           M_AXI_ARREADY    : in STD_LOGIC;
           M_AXI_ARADDR     : out STD_LOGIC_VECTOR (31 downto 0);
           M_AXI_ARPROT     : out STD_LOGIC;
           -- Read Data Channel
           M_AXI_RVALID     : in std_logic;
           M_AXI_RREADY     : out STD_LOGIC;
           M_AXI_RRESP      : in STD_LOGIC_VECTOR(1 downto 0);
           M_AXI_RDATA      : in STD_LOGIC_VECTOR (31 downto 0)
           );
    end component;

    signal M_AXI_ACLK       : STD_LOGIC := '0';
    signal M_AXI_ARESETN    : STD_LOGIC := '0';
    signal M_AXI_AWVALID    : STD_LOGIC;
    signal M_AXI_AWREADY    : STD_LOGIC := '0';
    signal M_AXI_AWADDR     : STD_LOGIC_VECTOR (31 downto 0);
    signal M_AXI_AWPROT     : STD_LOGIC;
    -- Write Data Channel
    signal M_AXI_WVALID     : STD_LOGIC;
    signal M_AXI_WREADY     : STD_LOGIC := '0';
    signal M_AXI_WDATA      : STD_LOGIC_VECTOR (31 downto 0);
    signal M_AXI_WSTRB      : STD_LOGIC;
    -- Write Return Channel
    signal M_AXI_BVALID     : STD_LOGIC := '0';
    signal M_AXI_BREADY     : STD_LOGIC;
    signal M_AXI_BRESP      : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
    -- Read Address Channel
    signal M_AXI_ARVALID    : STD_LOGIC;
    signal M_AXI_ARREADY    : STD_LOGIC := '0';
    signal M_AXI_ARADDR     : STD_LOGIC_VECTOR (31 downto 0);
    signal M_AXI_ARPROT     : STD_LOGIC;
    -- Read Data Channel
    signal M_AXI_RVALID     : std_logic := '0';
    signal M_AXI_RREADY     : STD_LOGIC;
    signal M_AXI_RRESP      : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal M_AXI_RDATA      : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
begin
    instance_fifo2axi_converter : component xbar_config_demo port map (
       M_AXI_ACLK => M_AXI_ACLK,
       M_AXI_ARESETN => M_AXI_ARESETN,
       M_AXI_AWVALID => M_AXI_AWVALID,
       M_AXI_AWREADY => M_AXI_AWREADY,
       M_AXI_AWADDR => M_AXI_AWADDR,
       M_AXI_AWPROT => M_AXI_AWPROT,
       M_AXI_WVALID => M_AXI_WVALID,
       M_AXI_WREADY => M_AXI_WREADY,
       M_AXI_WDATA => M_AXI_WDATA,
       M_AXI_WSTRB => M_AXI_WSTRB,
       M_AXI_BVALID => M_AXI_BVALID,
       M_AXI_BREADY => M_AXI_BREADY,
       M_AXI_BRESP => M_AXI_BRESP,
       M_AXI_ARVALID => M_AXI_ARVALID,
       M_AXI_ARREADY => M_AXI_ARREADY,
       M_AXI_ARADDR => M_AXI_ARADDR,
       M_AXI_ARPROT => M_AXI_ARPROT,
       M_AXI_RVALID => M_AXI_RVALID,
       M_AXI_RREADY => M_AXI_RREADY,
       M_AXI_RRESP => M_AXI_RRESP,
       M_AXI_RDATA => M_AXI_RDATA);
        
     -- 100Mhz clock
     process begin  
        M_AXI_ACLK <= not M_AXI_ACLK;
        wait for 10ns;    
     end process;
     
     process begin
        wait for 100ns;       
        wait until rising_edge(M_AXI_ACLK);
        M_AXI_ARESETN <= '1';
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        M_AXI_AWREADY <= '1';
        M_AXI_WREADY <= '1';
        wait until rising_edge(M_AXI_ACLK);
        M_AXI_AWREADY <= '0';
        M_AXI_WREADY <= '0';
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        M_AXI_AWREADY <= '1';
        M_AXI_WREADY <= '1';
        wait until rising_edge(M_AXI_ACLK);
        M_AXI_AWREADY <= '0';
        M_AXI_WREADY <= '0';
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        M_AXI_AWREADY <= '1';
        M_AXI_WREADY <= '1';
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        wait until rising_edge(M_AXI_ACLK);
        
     end process;
end Behavioral;

