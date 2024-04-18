----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2024 09:28:15 AM
-- Design Name: 
-- Module Name: axi_read_cache - Behavioral
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity axi_read_cache_tb is
--  Port ( );
end axi_read_cache_tb;

architecture Behavioral of axi_read_cache_tb is
component axi_read_cache is
    generic (
        C_AXI_DATA_WIDTH : natural := 32;
        C_AXI_ADDR_WIDTH : natural := 32;
        WORD_NUM         : natural := 16
    );
Port (
        -- Global Signals
        ACLK                :   in std_logic;
        ARESETN             :   in std_logic;
        INVALIDATE          :   in std_logic;

        -- MASTER CHANNEL
        -- Write address channel signals
        M_AXI_AWADDR        :   out std_logic_vector(C_AXI_ADDR_WIDTH-1 downto 0);
        M_AXI_AWLEN         :   out std_logic_vector(7 downto 0);
        M_AXI_AWSIZE        :   out std_logic_vector(2 downto 0);
        M_AXI_AWBURST       :   out std_logic_vector(1 downto 0);
        M_AXI_AWCACHE       :   out std_logic_vector(3 downto 0);
        M_AXI_AWPROT        :   out std_logic_vector(2 downto 0);
        M_AXI_AWVALID       :   out std_logic;
        M_AXI_AWREADY       :   in  std_logic;
         -- Write data channel signals
        M_AXI_WDATA         :   out std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
        M_AXI_WSTRB         :   out std_logic_vector(integer(ceil(real(C_AXI_DATA_WIDTH)/8))-1 downto 0);
        M_AXI_WLAST         :   out std_logic;
        M_AXI_WVALID        :   out std_logic;
        M_AXI_WREADY        :   in  std_logic;
         --  Write response channel signals
        M_AXI_BRESP         :   in  std_logic_vector(1 downto 0);
        M_AXI_BVALID        :   in  std_logic;
        M_AXI_BREADY        :   out std_logic;
         --  Read address channel signals
        M_AXI_ARADDR        :   out std_logic_vector(C_AXI_ADDR_WIDTH-1 downto 0);
        M_AXI_ARLEN         :   out std_logic_vector(7 downto 0);
        M_AXI_ARSIZE        :   out std_logic_vector(2 downto 0);
        M_AXI_ARBURST       :   out std_logic_vector(1 downto 0);
        M_AXI_ARCACHE       :   out std_logic_vector(3 downto 0);
        M_AXI_ARPROT        :   out std_logic_vector(2 downto 0);
        M_AXI_ARVALID       :   out std_logic;
        M_AXI_ARREADY       :   in  std_logic;
         -- Read data channel signals
        M_AXI_RDATA         :   in  std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
        M_AXI_RRESP         :   in  std_logic_vector(1 downto 0);
        M_AXI_RLAST         :   in  std_logic;
        M_AXI_RVALID        :   in  std_logic;
        M_AXI_RREADY        :   out std_logic;

        -- SLAVE CHANNEL
        -- Write address channel signals
        S_AXI_AWADDR        :   in std_logic_vector(C_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWLEN         :   in std_logic_vector(7 downto 0);
        S_AXI_AWSIZE        :   in std_logic_vector(2 downto 0);
        S_AXI_AWBURST       :   in std_logic_vector(1 downto 0);
        S_AXI_AWCACHE       :   in std_logic_vector(3 downto 0);
        S_AXI_AWPROT        :   in std_logic_vector(2 downto 0);
        S_AXI_AWVALID       :   in std_logic;
        S_AXI_AWREADY       :   out  std_logic;
        -- Write data channel signals
        S_AXI_WDATA         :   in std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB         :   in std_logic_vector(integer(ceil(real(C_AXI_DATA_WIDTH)/8))-1 downto 0);
        S_AXI_WLAST         :   in std_logic;
        S_AXI_WVALID        :   in std_logic;
        S_AXI_WREADY        :   out  std_logic;
        --  Write response channel signals
        S_AXI_BRESP         :   out  std_logic_vector(1 downto 0);
        S_AXI_BVALID        :   out  std_logic;
        S_AXI_BREADY        :   in std_logic;
        --  Read address channel signals
        S_AXI_ARADDR        :   in std_logic_vector(C_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARLEN         :   in std_logic_vector(7 downto 0);
        S_AXI_ARSIZE        :   in std_logic_vector(2 downto 0);
        S_AXI_ARBURST       :   in std_logic_vector(1 downto 0);
        S_AXI_ARCACHE       :   in std_logic_vector(3 downto 0);
        S_AXI_ARPROT        :   in std_logic_vector(2 downto 0);
        S_AXI_ARVALID       :   in std_logic;
        S_AXI_ARREADY       :   out  std_logic;
        -- Read data channel signals
        S_AXI_RDATA         :   out  std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP         :   out  std_logic_vector(1 downto 0);
        S_AXI_RLAST         :   out  std_logic;
        S_AXI_RVALID        :   out  std_logic;
        S_AXI_RREADY        :   in std_logic
);
end component;
 -- Global Signals
signal ACLK                :   std_logic := '0';
signal ARESETN             :   std_logic := '0';
signal INVALIDATE          :   std_logic := '0';

-- MASTER CHANNEL
-- Write address channel signals
signal M_AXI_AWADDR        :   std_logic_vector(31 downto 0);
signal M_AXI_AWLEN         :   std_logic_vector(7 downto 0);
signal M_AXI_AWSIZE        :   std_logic_vector(2 downto 0);
signal M_AXI_AWBURST       :   std_logic_vector(1 downto 0);
signal M_AXI_AWCACHE       :   std_logic_vector(3 downto 0);
signal M_AXI_AWPROT        :   std_logic_vector(2 downto 0);
signal M_AXI_AWVALID       :   std_logic;
signal M_AXI_AWREADY       :   std_logic := '0';
-- Write data channel signals
signal M_AXI_WDATA         :   std_logic_vector(31 downto 0);
signal M_AXI_WSTRB         :   std_logic_vector(3 downto 0);
signal M_AXI_WLAST         :   std_logic;
signal M_AXI_WVALID        :   std_logic;
signal M_AXI_WREADY        :   std_logic := '0';
--  Write response channel signals
signal M_AXI_BRESP         :   std_logic_vector(1 downto 0) := (others => '0');
signal M_AXI_BVALID        :   std_logic := '0';
signal M_AXI_BREADY        :   std_logic;
--  Read address channel signals
signal M_AXI_ARADDR        :   std_logic_vector(31 downto 0);
signal M_AXI_ARLEN         :   std_logic_vector(7 downto 0);
signal M_AXI_ARSIZE        :   std_logic_vector(2 downto 0);
signal M_AXI_ARBURST       :   std_logic_vector(1 downto 0);
signal M_AXI_ARCACHE       :   std_logic_vector(3 downto 0);
signal M_AXI_ARPROT        :   std_logic_vector(2 downto 0);
signal M_AXI_ARVALID       :   std_logic;
signal M_AXI_ARREADY       :   std_logic := '0';
-- Read data channel signals
signal M_AXI_RDATA         :   std_logic_vector(31 downto 0) := (others => '0');
signal M_AXI_RRESP         :   std_logic_vector(1 downto 0) := (others => '0');
signal M_AXI_RLAST         :   std_logic := '0';
signal M_AXI_RVALID        :   std_logic := '0';
signal M_AXI_RREADY        :   std_logic;

-- SLAVE CHANNEL
-- Write address channel signals
signal S_AXI_AWADDR        :   std_logic_vector(31 downto 0) := (others => '0');
signal S_AXI_AWLEN         :   std_logic_vector(7 downto 0) := (others => '0');
signal S_AXI_AWSIZE        :   std_logic_vector(2 downto 0) := (others => '0');
signal S_AXI_AWBURST       :   std_logic_vector(1 downto 0) := (others => '0');
signal S_AXI_AWCACHE       :   std_logic_vector(3 downto 0) := (others => '0');
signal S_AXI_AWPROT        :   std_logic_vector(2 downto 0) := (others => '0');
signal S_AXI_AWVALID       :   std_logic := '0';
signal S_AXI_AWREADY       :   std_logic;
-- Write data channel signals
signal S_AXI_WDATA         :   std_logic_vector(31 downto 0) := (others => '0');
signal S_AXI_WSTRB         :   std_logic_vector(3 downto 0) := (others => '0');
signal S_AXI_WLAST         :   std_logic := '0';
signal S_AXI_WVALID        :   std_logic := '0';
signal S_AXI_WREADY        :   std_logic;
--  Write response channel signals
signal S_AXI_BRESP         :   std_logic_vector(1 downto 0);
signal S_AXI_BVALID        :   std_logic;
signal S_AXI_BREADY        :   std_logic := '0';
--  Read address channel signals
signal S_AXI_ARADDR        :   std_logic_vector(31 downto 0) := (others => '0');
signal S_AXI_ARLEN         :   std_logic_vector(7 downto 0) := (others => '0');
signal S_AXI_ARSIZE        :   std_logic_vector(2 downto 0) := (others => '0');
signal S_AXI_ARBURST       :   std_logic_vector(1 downto 0) := (others => '0');
signal S_AXI_ARCACHE       :   std_logic_vector(3 downto 0) := (others => '0');
signal S_AXI_ARPROT        :   std_logic_vector(2 downto 0) := (others => '0');
signal S_AXI_ARVALID       :   std_logic := '0';
signal S_AXI_ARREADY       :   std_logic;
-- Read data channel signals
signal S_AXI_RDATA         :   std_logic_vector(31 downto 0);
signal S_AXI_RRESP         :   std_logic_vector(1 downto 0);
signal S_AXI_RLAST         :   std_logic;
signal S_AXI_RVALID        :   std_logic;
signal S_AXI_RREADY        :   std_logic := '0';

signal read : boolean := false;
signal read_done : boolean := false;
signal cnt : integer := 0;
begin
instance_registerif : component axi_read_cache port map(
    -- Global Signals
    ACLK            => ACLK            ,
    ARESETN         => ARESETN         ,
    INVALIDATE      => INVALIDATE      ,
    M_AXI_AWADDR    => M_AXI_AWADDR    ,
    M_AXI_AWLEN     => M_AXI_AWLEN     ,
    M_AXI_AWSIZE    => M_AXI_AWSIZE    ,
    M_AXI_AWBURST   => M_AXI_AWBURST   ,
    M_AXI_AWCACHE   => M_AXI_AWCACHE   ,
    M_AXI_AWPROT    => M_AXI_AWPROT    ,
    M_AXI_AWVALID   => M_AXI_AWVALID   ,
    M_AXI_AWREADY   => M_AXI_AWREADY   ,
    M_AXI_WDATA     => M_AXI_WDATA     ,
    M_AXI_WSTRB     => M_AXI_WSTRB     ,
    M_AXI_WLAST     => M_AXI_WLAST     ,
    M_AXI_WVALID    => M_AXI_WVALID    ,
    M_AXI_WREADY    => M_AXI_WREADY    ,
    M_AXI_BRESP     => M_AXI_BRESP     ,
    M_AXI_BVALID    => M_AXI_BVALID    ,
    M_AXI_BREADY    => M_AXI_BREADY    ,
    M_AXI_ARADDR    => M_AXI_ARADDR    ,
    M_AXI_ARLEN     => M_AXI_ARLEN     ,
    M_AXI_ARSIZE    => M_AXI_ARSIZE    ,
    M_AXI_ARBURST   => M_AXI_ARBURST   ,
    M_AXI_ARCACHE   => M_AXI_ARCACHE   ,
    M_AXI_ARPROT    => M_AXI_ARPROT    ,
    M_AXI_ARVALID   => M_AXI_ARVALID   ,
    M_AXI_ARREADY   => M_AXI_ARREADY   ,
    M_AXI_RDATA     => M_AXI_RDATA     ,
    M_AXI_RRESP     => M_AXI_RRESP     ,
    M_AXI_RLAST     => M_AXI_RLAST     ,
    M_AXI_RVALID    => M_AXI_RVALID    ,
    M_AXI_RREADY    => M_AXI_RREADY    ,
    S_AXI_AWADDR    => S_AXI_AWADDR    ,
    S_AXI_AWLEN     => S_AXI_AWLEN     ,
    S_AXI_AWSIZE    => S_AXI_AWSIZE    ,
    S_AXI_AWBURST   => S_AXI_AWBURST   ,
    S_AXI_AWCACHE   => S_AXI_AWCACHE   ,
    S_AXI_AWPROT    => S_AXI_AWPROT    ,
    S_AXI_AWVALID   => S_AXI_AWVALID   ,
    S_AXI_AWREADY   => S_AXI_AWREADY   ,
    S_AXI_WDATA     => S_AXI_WDATA     ,
    S_AXI_WSTRB     => S_AXI_WSTRB     ,
    S_AXI_WLAST     => S_AXI_WLAST     ,
    S_AXI_WVALID    => S_AXI_WVALID    ,
    S_AXI_WREADY    => S_AXI_WREADY    ,
    S_AXI_BRESP     => S_AXI_BRESP     ,
    S_AXI_BVALID    => S_AXI_BVALID    ,
    S_AXI_BREADY    => S_AXI_BREADY    ,
    S_AXI_ARADDR    => S_AXI_ARADDR    ,
    S_AXI_ARLEN     => S_AXI_ARLEN     ,
    S_AXI_ARSIZE    => S_AXI_ARSIZE    ,
    S_AXI_ARBURST   => S_AXI_ARBURST   ,
    S_AXI_ARCACHE   => S_AXI_ARCACHE   ,
    S_AXI_ARPROT    => S_AXI_ARPROT    ,
    S_AXI_ARVALID   => S_AXI_ARVALID   ,
    S_AXI_ARREADY   => S_AXI_ARREADY   ,
    S_AXI_RDATA     => S_AXI_RDATA     ,
    S_AXI_RRESP     => S_AXI_RRESP     ,
    S_AXI_RLAST     => S_AXI_RLAST     ,
    S_AXI_RVALID    => S_AXI_RVALID    ,
    S_AXI_RREADY    => S_AXI_RREADY
);

 -- 100Mhz clock
process begin
    ACLK <= not ACLK;
    wait for 10ns;
end process;

process begin
    wait until rising_edge(ACLK);
    if M_AXI_ARVALID = '1' then
        M_AXI_ARREADY <= '0';
        wait until rising_edge(ACLK);
        wait until rising_edge(ACLK);
        wait until rising_edge(ACLK);
        wait until rising_edge(ACLK);
        wait until rising_edge(ACLK);
        read <= true;
    else
        if read_done then
            read <= false;
        end if;
        M_AXI_ARREADY <= '1';
    end if;
end process;

process begin
    wait until rising_edge(ACLK);
    if read then
        M_AXI_RVALID <= '1';
        M_AXI_RLAST <= '0';
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RDATA <= std_logic_vector(to_unsigned(cnt, 32));
        cnt <= cnt + 1;
        M_AXI_RLAST <= '1';
        wait until M_AXI_RREADY = '1' and rising_edge(ACLK);
        M_AXI_RLAST <= '0';
        M_AXI_RVALID <= '0';
        read_done <= true;
        wait until read = false;
    else
        read_done <= false;
        M_AXI_RVALID <= '0';
        M_AXI_RLAST <= '0';
        M_AXI_RDATA <= x"00000000";
    end if;
end process;

process begin
    wait for 30ns;
    ARESETN <= '1';
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    S_AXI_ARADDR <= x"00000000";
    S_AXI_ARLEN <= x"07";
    S_AXI_ARSIZE <= "011";
    S_AXI_ARCACHE <= "0011";
    S_AXI_ARPROT <= "000";
    S_AXI_RREADY <= '1';
    wait until rising_edge(ACLK);
    S_AXI_ARVALID <= '1';
    wait until S_AXI_ARREADY = '1';
    wait until rising_edge(ACLK);
    S_AXI_ARVALID <= '0';
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    S_AXI_ARADDR <= x"00000000";
    S_AXI_ARLEN <= x"00";
    S_AXI_ARSIZE <= "000";
    S_AXI_ARCACHE <= "0011";
    S_AXI_ARPROT <= "000";
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    S_AXI_ARADDR <= x"00000040";
    S_AXI_ARLEN <= x"07";
    S_AXI_ARSIZE <= "011";
    S_AXI_ARCACHE <= "0011";
    S_AXI_ARPROT <= "000";
    S_AXI_RREADY <= '1';
    wait until rising_edge(ACLK);
    S_AXI_ARVALID <= '1';
    wait until S_AXI_ARREADY = '1';
    wait until rising_edge(ACLK);
    S_AXI_ARVALID <= '0';
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    S_AXI_ARADDR <= x"00000000";
    S_AXI_ARLEN <= x"00";
    S_AXI_ARSIZE <= "000";
    S_AXI_ARCACHE <= "0011";
    S_AXI_ARPROT <= "000";
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
    wait until rising_edge(ACLK);
end process;

end Behavioral;
