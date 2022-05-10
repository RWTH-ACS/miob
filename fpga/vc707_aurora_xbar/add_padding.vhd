----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2022 03:39:38 PM
-- Design Name: 
-- Module Name: add_padding - Behavioral
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

entity add_padding is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           m_axis_tdata : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           m_axis_tlast : out STD_LOGIC := '0';
           m_axis_tvalid : out STD_LOGIC := '0';
           s_axis_tdata : in STD_LOGIC_VECTOR (31 downto 0);
           s_axis_tlast : in STD_LOGIC;
           s_axis_tvalid : in STD_LOGIC
           );
end add_padding;
architecture Behavioral of add_padding is
    signal padding_valid : STD_LOGIC := '0';
    signal cnt : integer := 0;
    constant desired_package_length : integer := 33;
    constant padding_word : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
begin

process (aclk, aresetn, s_axis_tdata,  s_axis_tlast, s_axis_tvalid) begin
    if rising_edge(aclk) then
        if aresetn = '0' then
            padding_valid <= '0';
            cnt <= 0;
        else
            if padding_valid = '0' then
                m_axis_tdata <= s_axis_tdata;
                m_axis_tvalid <= s_axis_tvalid;
            else
                m_axis_tdata <= padding_word;
                m_axis_tvalid <= '1';
            end if;
            if cnt = desired_package_length-1 then
                m_axis_tlast <= '1';
            else
                m_axis_tlast <= '0';
            end if;
            if cnt >= desired_package_length-1 then
                padding_valid <= '0';
                cnt <= 0;
            elsif s_axis_tvalid = '1' or padding_valid = '1' then
                cnt <= cnt + 1;
            end if;
            if s_axis_tlast = '1' and cnt < desired_package_length then
                padding_valid <= '1';
            end if;
        end if;
    end if;
end process;
end Behavioral;