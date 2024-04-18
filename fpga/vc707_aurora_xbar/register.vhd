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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerif is
    generic (
        C_AXI_DATA_WIDTH : integer := 32;
        C_AXI_ADDR_WIDTH : integer := 32
    );
    Port ( -- AXI4 Lite Interface
           S_AXI_ACLK       : in STD_LOGIC;
           S_AXI_ARESETN    : in STD_LOGIC;
           -- Write Address Channel
           S_AXI_AWVALID    : in STD_LOGIC := '0';
           S_AXI_AWREADY    : out STD_LOGIC := '1'; -- we are always ready to receive an address
           S_AXI_AWADDR     : in STD_LOGIC_VECTOR (C_AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
           S_AXI_AWPROT     : in STD_LOGIC := '0'; -- always use normal access
           -- Write Data Channel
           S_AXI_WVALID     : in STD_LOGIC := '0';
           S_AXI_WREADY     : out STD_LOGIC := '1';
           S_AXI_WDATA      : in STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
           S_AXI_WSTRB      : in STD_LOGIC := '1';
           -- Write Return Channel
           S_AXI_BVALID     : out STD_LOGIC := '0';
           S_AXI_BREADY     : in STD_LOGIC := '1';
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
           S_AXI_RDATA      : out STD_LOGIC_VECTOR (C_AXI_DATA_WIDTH-1 downto 0) := (others => '0')
           );
end registerif;

architecture Behavioral of registerif is

begin


end Behavioral;
