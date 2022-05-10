----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2022 08:12:13 PM
-- Design Name: 
-- Module Name: rtds_seqnum_fix_incoming - Behavioral
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

entity rtds_seqnum_fix_incoming is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           m_axis_tdata : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           m_axis_tlast : out STD_LOGIC := '0';
           m_axis_tvalid : out STD_LOGIC := '0';
           s_axis_tdata : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast : in STD_LOGIC;
           s_axis_tvalid : in STD_LOGIC
           );
end rtds_seqnum_fix_incoming;
architecture Behavioral of rtds_seqnum_fix_incoming is
    signal seqnum : STD_LOGIC := '0';
begin

m_axis_tdata <= s_axis_tdata;
m_axis_tvalid <= s_axis_tvalid or seqnum;
m_axis_tlast <= seqnum;

process (aclk, aresetn, s_axis_tdata,  s_axis_tlast, s_axis_tvalid) begin
    if rising_edge(aclk) then
        if aresetn = '0' then
            seqnum <= '0';
        else
            if s_axis_tlast = '1' then
                seqnum <= '1';
            else
                seqnum <= '0';
            end if;
        end if;
    end if;
end process;
end Behavioral;
