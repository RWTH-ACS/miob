----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2023 04:06:21 PM
-- Design Name: 
-- Module Name: miob_mux - Behavioral
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
-- 4 Slave interfaces. We will synchronize to slave interface 1. 
-- I.e. when slave 1 was valid a 4 frame package will be send on the next tready signal

entity miob_mux is
    Port ( aclk : in STD_LOGIC;
           aresetn : in STD_LOGIC;
           m_axis_tdata : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           m_axis_tlast : out STD_LOGIC := '0';
           m_axis_tvalid : out STD_LOGIC := '0';
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
end miob_mux;

architecture Behavioral of miob_mux is
    type t_buffer is array (0 to 3) of STD_LOGIC_VECTOR (31 downto 0);
    signal buf : t_buffer := (others => (others => '0'));
begin

process (aclk, aresetn, s_axis_tdata_1,  s_axis_tlast_1, s_axis_tvalid_1) begin
    if rising_edge(aclk) then
        if aresetn = '0' then
            buf <= (others => (others => '0'));
        else
        end if;
    end if;
end process;

end Behavioral;
