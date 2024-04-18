----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2023 04:07:02 PM
-- Design Name: 
-- Module Name: miob_mux_tb - Behavioral
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

entity miob_mux_tb is
--  Port ( );
end miob_mux_tb;

architecture Behavioral of miob_mux_tb is
component miob_mux is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           m_axis_tdata : out STD_LOGIC_VECTOR (31 downto 0);
           m_axis_tlast : out STD_LOGIC;
           m_axis_tvalid : out STD_LOGIC;
           m_axis_tready : in STD_LOGIC;
           s_axis_tdata_1 : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast_1 : in STD_LOGIC;
           s_axis_tvalid_1 : in STD_LOGIC;
           s_axis_tdata_2 : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast_2 : in STD_LOGIC;
           s_axis_tvalid_2 : in STD_LOGIC;
           s_axis_tdata_3 : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast_3 : in STD_LOGIC;
           s_axis_tvalid_3 : in STD_LOGIC;
           s_axis_tdata_4 : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast_4 : in STD_LOGIC;
           s_axis_tvalid_4 : in STD_LOGIC
           );
end component;
signal aclk : STD_LOGIC := '0';
signal aresetn : STD_LOGIC := '0';
signal m_axis_tdata : STD_LOGIC_VECTOR (31 downto 0);
signal m_axis_tlast : STD_LOGIC;
signal m_axis_tvalid : STD_LOGIC;
signal m_axis_tready : STD_LOGIC := '0';
signal s_axis_tdata_1 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal s_axis_tlast_1 : STD_LOGIC := '0';
signal s_axis_tvalid_1 : STD_LOGIC := '0';
signal s_axis_tdata_2 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal s_axis_tlast_2 : STD_LOGIC := '0';
signal s_axis_tvalid_2 : STD_LOGIC := '0';
signal s_axis_tdata_3 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal s_axis_tlast_3 : STD_LOGIC := '0';
signal s_axis_tvalid_3 : STD_LOGIC := '0';
signal s_axis_tdata_4 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal s_axis_tlast_4 : STD_LOGIC := '0';
signal s_axis_tvalid_4 : STD_LOGIC := '0';
begin
    instance_miob_mux : component miob_mux port map(
        aclk => aclk,
        aresetn => aresetn,
        m_axis_tdata => m_axis_tdata,
        m_axis_tlast => m_axis_tlast,
        m_axis_tvalid => m_axis_tvalid,
        m_axis_tready => m_axis_tready,
        s_axis_tdata_1 => s_axis_tdata_1,
        s_axis_tlast_1 => s_axis_tlast_1,
        s_axis_tvalid_1 => s_axis_tvalid_1,
        s_axis_tdata_2 => s_axis_tdata_2,
        s_axis_tlast_2 => s_axis_tlast_2,
        s_axis_tvalid_2 => s_axis_tvalid_2,
        s_axis_tdata_3 => s_axis_tdata_3,
        s_axis_tlast_3 => s_axis_tlast_3,
        s_axis_tvalid_3 => s_axis_tvalid_3,
        s_axis_tdata_4 => s_axis_tdata_4,
        s_axis_tlast_4 => s_axis_tlast_4,
        s_axis_tvalid_4 => s_axis_tvalid_4
    );
 -- 100Mhz clock
process begin  
    aclk <= not aclk;
    wait for 10ns;    
end process;
 
process begin
    wait for 100ns;
    aresetn <= '1';
end process;   

end Behavioral;
