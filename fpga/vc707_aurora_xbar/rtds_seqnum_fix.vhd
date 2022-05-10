----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2022 03:18:23 PM
-- Design Name: 
-- Module Name: rtds_seqnum_fix - Behavioral
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

entity rtds_seqnum_fix is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           m_axis_tdata : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           m_axis_tlast : out STD_LOGIC := '0';
           m_axis_tvalid : out STD_LOGIC := '0';
           s_axis_tdata : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast : in STD_LOGIC;
           s_axis_tvalid : in STD_LOGIC
           );
end rtds_seqnum_fix;

architecture Behavioral of rtds_seqnum_fix is
    signal first : boolean := true;
    signal last : boolean := false;
    signal tdata : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
process (aclk, aresetn, first, last, s_axis_tdata,  s_axis_tlast, s_axis_tvalid) begin
    if rising_edge(aclk) then
        if aresetn = '0' then
            tdata <= (others => '0');
            m_axis_tdata <= (others => '0');
            m_axis_tlast <= '0';
            m_axis_tvalid <= '0';
            first <= true;
            last <= false;
        else
            if s_axis_tvalid = '1' then
                tdata <= s_axis_tdata;
                first <= false;
                if not first then
                    m_axis_tdata <= tdata;   
                end if;
            end if;
            if s_axis_tlast = '1' then
                m_axis_tlast <= '1';
                last <= true;
            else
                m_axis_tlast <= '0';
            end if;
            if last then
                m_axis_tdata <= tdata;
                last <= false;
                first <= true;
            end if;
            if (s_axis_tvalid = '1' and first = false) then
                m_axis_tvalid <= '1';
            else
                m_axis_tvalid <= '0';
            end if;  
        end if;
    end if;
    
end process;

end Behavioral;
