----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2024 11:45:23 AM
-- Design Name: 
-- Module Name: registerif_tb - Behavioral
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

entity registerif_tb is
--  Port ( );
end registerif_tb;

architecture Behavioral of registerif_tb is
component registerif is 
    Port ( -- AXI4 Lite Interface
       S_AXI_ACLK       : in STD_LOGIC;
       S_AXI_ARESETN    : in STD_LOGIC;
       -- Write Address Channel
       S_AXI_AWVALID    : in STD_LOGIC;
       S_AXI_AWREADY    : out STD_LOGIC;
       S_AXI_AWADDR     : in STD_LOGIC_VECTOR (31 downto 0);
       S_AXI_AWPROT     : in STD_LOGIC;
       -- Write Data Channel
       S_AXI_WVALID     : in STD_LOGIC;
       S_AXI_WREADY     : out STD_LOGIC;
       S_AXI_WDATA      : in STD_LOGIC_VECTOR (31 downto 0);
       S_AXI_WSTRB      : in STD_LOGIC;
       -- Write Return Channel
       S_AXI_BVALID     : out STD_LOGIC;
       S_AXI_BREADY     : in STD_LOGIC;
       S_AXI_BRESP      : out STD_LOGIC_VECTOR(1 downto 0);
       -- Read Address Channel
       S_AXI_ARVALID    : in STD_LOGIC;
       S_AXI_ARREADY    : out STD_LOGIC;
       S_AXI_ARADDR     : in STD_LOGIC_VECTOR (31 downto 0);
       S_AXI_ARPROT     : in STD_LOGIC;
       -- Read Data Channel
       S_AXI_RVALID     : out STD_LOGIC := '0';
       S_AXI_RREADY     : in STD_LOGIC := '1';
       S_AXI_RRESP      : out STD_LOGIC_VECTOR(1 downto 0);
       S_AXI_RDATA      : out STD_LOGIC_VECTOR (31 downto 0);
       
       -- output ports
       out1             : out STD_LOGIC_VECTOR(31 downto 0);
       out2             : out STD_LOGIC_VECTOR(31 downto 0);
       out3             : out STD_LOGIC_VECTOR(31 downto 0);
       out4             : out STD_LOGIC_VECTOR(31 downto 0)
       );
end component;
   signal S_AXI_ACLK       :  STD_LOGIC := '0';
   signal S_AXI_ARESETN    :  STD_LOGIC := '0';
   -- Write Address Channel
   signal S_AXI_AWVALID    :  STD_LOGIC := '0';
   signal S_AXI_AWREADY    :  STD_LOGIC; -- we are always ready to receive an address
   signal S_AXI_AWADDR     :  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
   signal S_AXI_AWPROT     :  STD_LOGIC := '0'; -- always use normal access
   -- Write Data Channel
   signal S_AXI_WVALID     :  STD_LOGIC := '0';
   signal S_AXI_WREADY     :  STD_LOGIC;
   signal S_AXI_WDATA      :  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
   signal S_AXI_WSTRB      :  STD_LOGIC := '1';
   -- Write Return Channel
   signal S_AXI_BVALID     :  STD_LOGIC;
   signal S_AXI_BREADY     :  STD_LOGIC := '0';
   signal S_AXI_BRESP      :  STD_LOGIC_VECTOR(1 downto 0); -- 00 means respond OKAY
   -- Read Address Channel
   signal S_AXI_ARVALID    :  STD_LOGIC := '0';
   signal S_AXI_ARREADY    :  STD_LOGIC;
   signal S_AXI_ARADDR     :  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
   signal S_AXI_ARPROT     :  STD_LOGIC := '0'; -- always use normal access
   -- Read Data Channel
   signal S_AXI_RVALID     :  STD_LOGIC;
   signal S_AXI_RREADY     :  STD_LOGIC := '0';
   signal S_AXI_RRESP      :  STD_LOGIC_VECTOR(1 downto 0); -- always respond OKAY
   signal S_AXI_RDATA      :  STD_LOGIC_VECTOR (31 downto 0);
   
   -- output ports
   signal out1             :  STD_LOGIC_VECTOR(31 downto 0);
   signal out2             :  STD_LOGIC_VECTOR(31 downto 0);
   signal out3             :  STD_LOGIC_VECTOR(31 downto 0);
   signal out4             :  STD_LOGIC_VECTOR(31 downto 0);
begin
instance_registerif : component registerif port map(
    S_AXI_ACLK => S_AXI_ACLK,
    S_AXI_ARESETN => S_AXI_ARESETN,
    S_AXI_AWVALID => S_AXI_AWVALID,
    S_AXI_AWREADY => S_AXI_AWREADY,
    S_AXI_AWADDR => S_AXI_AWADDR,
    S_AXI_AWPROT => S_AXI_AWPROT,
    S_AXI_WVALID => S_AXI_WVALID,
    S_AXI_WREADY => S_AXI_WREADY,
    S_AXI_WDATA => S_AXI_WDATA,
    S_AXI_WSTRB => S_AXI_WSTRB,
    S_AXI_BVALID => S_AXI_BVALID,
    S_AXI_BREADY => S_AXI_BREADY,
    S_AXI_BRESP => S_AXI_BRESP,
    S_AXI_ARVALID => S_AXI_ARVALID,
    S_AXI_ARREADY => S_AXI_ARREADY,
    S_AXI_ARADDR => S_AXI_ARADDR,
    S_AXI_ARPROT => S_AXI_ARPROT,
    S_AXI_RVALID => S_AXI_RVALID,
    S_AXI_RREADY => S_AXI_RREADY,
    S_AXI_RRESP => S_AXI_RRESP,
    S_AXI_RDATA => S_AXI_RDATA,
    out1 => out1,
    out2 => out2,
    out3 => out3,
    out4 => out4
);

 -- 100Mhz clock
process begin  
    S_AXI_ACLK <= not S_AXI_ACLK;
    wait for 10ns;    
end process;

process begin
    wait for 30ns;
    S_AXI_ARESETN <= '1';
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_BREADY <= '1';
    S_AXI_AWVALID <= '1';
    S_AXI_AWADDR <= x"0000_5004";
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_WVALID <= '1';
    S_AXI_WDATA <= x"1001_1001";
    wait until S_AXI_WREADY = '1' and S_AXI_AWREADY = '1';
    wait until S_AXI_BVALID = '1';
    S_AXI_AWADDR <= x"0000_5008";
    S_AXI_WDATA <= x"0110_0110";
    wait until S_AXI_WREADY = '1' and S_AXI_AWREADY = '1';
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_BREADY <= '0';
    S_AXI_AWADDR <= x"0000_500C";
    S_AXI_WDATA <= x"0FF0_0FF0";
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_BREADY <= '1';
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_AWADDR <= x"0000_5000";
    S_AXI_WDATA <= x"F00F_F00F";
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_AWADDR <= x"0000_0000";
    S_AXI_WDATA <= x"0000_0000";
    S_AXI_AWVALID <= '0';
    S_AXI_WVALID <= '0';
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_BREADY <= '0';
    
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_ARVALID <= '1';
    S_AXI_RREADY <= '1';
    S_AXI_ARADDR <= x"0000_5004";
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_ARADDR <= x"0000_5008";
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_RREADY <= '0';
    S_AXI_ARADDR <= x"0000_500C";
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_RREADY <= '1';
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_ARADDR <= x"0000_5000";
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_ARVALID <= '0';
    wait until rising_edge(S_AXI_ACLK);
    wait until rising_edge(S_AXI_ACLK);
    S_AXI_RREADY <= '0';
    S_AXI_ARADDR <= (others => '0');
    wait until rising_edge(S_AXI_ACLK);
    
end process;   

end Behavioral;
