----------------------------------------------------------------------------------
-- Engineer: Niklas Eiling
-- 
-- Create Date: 03/18/2024 09:28:15 AM
-- Design Name: 
-- Module Name: axi_read_cache - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 2021.1
-- Description: this is a cache for the AXI read channel. Reads on the slave interface
-- are cached using a 1-associativity. The cache is only invalidate when the invalidate
-- or reset signals are set. It is NOT invalidated when a write to a cached location occurs.
-- Only reads with burst length shorter or equal the original read burst can benefit from the
-- cache.
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


entity axi_read_cache is
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
        M_AXI_WSTRB         :   out std_logic_vector(C_AXI_DATA_WIDTH/8-1 downto 0);
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
        S_AXI_WSTRB         :   in std_logic_vector(C_AXI_DATA_WIDTH/8-1 downto 0);
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
end axi_read_cache;

architecture Behavioral of axi_read_cache is
constant offset_len : natural := natural(ceil(log2(real(C_AXI_DATA_WIDTH/8))))+1;
constant slot_lsb : natural := offset_len;
constant slot_len : natural := natural(ceil(log2(real(WORD_NUM))));
constant tag_lsb : natural := offset_len+slot_len;
constant tag_len : natural := natural(C_AXI_ADDR_WIDTH)-tag_lsb;
constant xferlen_len : natural := slot_len;
type Cache_Data_t is array (0 to WORD_NUM-1) of std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
type Cache_Tag_t is array (0 to WORD_NUM-1) of unsigned(tag_len-1 downto 0);
type Cache_Xferlen_t is array (0 to WORD_NUM-1) of unsigned(xferlen_len-1 downto 0);

signal cache_data    : Cache_Data_t := (others => (others => '0'));
signal cache_tag     : Cache_Tag_t := (others => (others => '0'));
signal cache_xferlen : Cache_Xferlen_t := (others => (others => '0'));

signal ar_offset  : std_logic_vector(offset_len-1 downto 0) := (others => '0');
signal ar_slot    : natural := 0;
signal ar_tag     : unsigned(tag_len-1 downto 0) := (others => '0');
signal ar_len     : unsigned(7 downto 0) := (others => '0');
signal ar_ready   : std_logic := '0';

-- signals for reading tag infos from AR channel
signal slot  : natural := 0;
signal tag   : unsigned(tag_len-1 downto 0) := (others => '0');
signal len   : unsigned(7 downto 0) := (others => '0');
signal read_slot_valid : boolean := false;

-- signals for writing cache data to R Channel
signal r_last       : std_logic := '0';

type State_t is (ADDRESS, CACHE_READ, BACK_READ);
signal state : State_t := ADDRESS;

--signal cache_address_base : unsigned(addr_len-1 downto 0) := (others => '0');
--constant cache_size : natural := WORD_NUM * C_AXI_DATA_WIDTH;
--signal read_wrapped : boolean := false;

begin
    M_AXI_AWADDR  <= S_AXI_AWADDR;
    M_AXI_AWLEN   <= S_AXI_AWLEN;
    M_AXI_AWSIZE  <= S_AXI_AWSIZE;
    M_AXI_AWBURST <= S_AXI_AWBURST;
    M_AXI_AWCACHE <= S_AXI_AWCACHE;
    M_AXI_AWPROT  <= S_AXI_AWPROT;
    M_AXI_AWVALID <= S_AXI_AWVALID;
    S_AXI_AWREADY <= M_AXI_AWREADY;
    -- Write data channel signals
    M_AXI_WDATA   <= S_AXI_WDATA;
    M_AXI_WSTRB   <= S_AXI_WSTRB;
    M_AXI_WLAST   <= S_AXI_WLAST;
    M_AXI_WVALID  <= S_AXI_WVALID;
    S_AXI_WREADY  <= M_AXI_WREADY;
    --  Write response channel signals
    S_AXI_BRESP   <= M_AXI_BRESP;
    S_AXI_BVALID  <= M_AXI_BVALID;
    M_AXI_BREADY  <= S_AXI_BREADY;

    S_AXI_RRESP   <= "00";
    S_AXI_ARREADY <= ar_ready;
    S_AXI_RLAST <= r_last;
    
    -- split ARADDR into index, slot, and offset
    ar_offset <= S_AXI_ARADDR(offset_len-1 downto 0);
    ar_slot   <= to_integer(unsigned(S_AXI_ARADDR(slot_len+offset_len-1 downto offset_len)));
    ar_tag    <= unsigned(S_AXI_ARADDR(C_AXI_DATA_WIDTH-1 downto offset_len+slot_len));
    ar_len    <= unsigned(S_AXI_ARLEN);
    
    process(ACLK, ARESETN, INVALIDATE,
        S_AXI_ARADDR, S_AXI_ARLEN, S_AXI_ARSIZE, S_AXI_ARBURST, S_AXI_ARCACHE, S_AXI_ARPROT, S_AXI_ARVALID, M_AXI_ARREADY, 
        M_AXI_RDATA, M_AXI_RRESP, M_AXI_RLAST, M_AXI_RVALID, S_AXI_RREADY) begin
        if rising_edge(ACLK) then
            if ARESETN = '0' or INVALIDATE = '1' then
                cache_data <= (others => (others => '0'));
                cache_tag <= (others => (others => '0'));
                cache_xferlen <= (others => (others => '0'));
                ar_ready <= '0';
                slot <= 0;
                tag <= (others => '0');
                len <= (others => '0');
                read_slot_valid <= false;
                r_last <= '0';
            else
                if S_AXI_ARVALID = '1' and ar_ready = '1' then
                    slot <= ar_slot;
                    tag <= ar_tag;
                    len <= ar_len;
                end if;
                
                if S_AXI_ARVALID = '1' and ar_ready = '0' then
                    if cache_tag(ar_slot) = ar_tag and ar_len <= cache_xferlen(ar_slot) then
                        state <= CACHE_READ;
                        ar_ready <= '1';
                    else
                        state <= BACK_READ;
                        ar_ready <= '0';
                    end if;
                else
                    ar_ready <= '0';
                end if;

 
                case state is
                when ADDRESS =>
                    if S_AXI_RREADY = '1' or S_AXI_ARVALID = '1' then
                        r_last <= '0';
                        S_AXI_RVALID <= '0';
                        S_AXI_RDATA <= (others => '0');
                    end if;
                when CACHE_READ =>
                    ar_ready <= '0';
                    -- Output cache slot
                    if S_AXI_ARVALID = '0' and r_last = '0' then
                        S_AXI_RDATA <= cache_data(slot);
                        S_AXI_RVALID <= '1';
                        if len <= 0 then
                            r_last <= '1';
                            state <= ADDRESS;
                        elsif S_AXI_RREADY = '1' then
                            slot <= slot + 1;
                            len <= len - 1;
                            r_last <= '0';
                        end if;
                    elsif S_AXI_RREADY = '1' or S_AXI_ARVALID = '1' then
                        r_last <= '0';
                        S_AXI_RVALID <= '0';
                    end if;
                when BACK_READ =>
                    if M_AXI_RVALID = '1' and S_AXI_RREADY = '1' and M_AXI_RRESP = "00" then
                        -- one more word has been read

                        -- if cache is too small for new data only accept the most recent
                        -- by overwriting the oldest data
                        if slot >= WORD_NUM-1 then
                            slot <= 0;
                        else
                            slot <= slot + 1;
                        end if;
                        if len > 0 then
                            len <= len - 1;
                        else
                            len <= (others => '0');
                        end if;
                        -- last word has been read. go back to valid state    
                        if M_AXI_RLAST = '1' then
                            state <= ADDRESS;
                        end if;
                        cache_data(slot) <= M_AXI_RDATA;
                        cache_tag(slot) <= tag;
                        if to_integer(len(7 downto xferlen_len)) > 0 then
                            cache_xferlen(slot) <= (others => '1');
                        else                           
                            cache_xferlen(slot) <= len(xferlen_len-1 downto 0);
                        end if;
                    end if;
                    --  Read address channel signals
                    M_AXI_ARADDR  <= S_AXI_ARADDR;
                    M_AXI_ARLEN   <= S_AXI_ARLEN;
                    M_AXI_ARSIZE  <= S_AXI_ARSIZE;
                    M_AXI_ARBURST <= S_AXI_ARBURST;
                    M_AXI_ARCACHE <= S_AXI_ARCACHE;
                    M_AXI_ARPROT  <= S_AXI_ARPROT;
                    M_AXI_ARVALID <= S_AXI_ARVALID;
                    ar_ready      <= M_AXI_ARREADY;
                    -- Read data channel signals
                    S_AXI_RDATA   <= M_AXI_RDATA;
                    S_AXI_RRESP   <= M_AXI_RRESP;
                    r_last        <= M_AXI_RLAST;
                    S_AXI_RVALID  <= M_AXI_RVALID;
                    M_AXI_RREADY  <= S_AXI_RREADY;
                end case;
            end if;
        end if;
    end process;
--    process(ACLK, ARESETN, INVALIDATE,
--        S_AXI_ARADDR, S_AXI_ARLEN, S_AXI_ARSIZE, S_AXI_ARBURST, S_AXI_ARCACHE, S_AXI_ARPROT, S_AXI_ARVALID, M_AXI_ARREADY, 
--        M_AXI_RDATA, M_AXI_RRESP, M_AXI_RLAST, M_AXI_RVALID, S_AXI_RREADY,
--        cache_address_base, read_wrapped, cur_slot, state, cache_data, cache_index, rlast, arready) begin
--        if rising_edge(ACLK) then
--            if ARESETN = '0' or INVALIDATE = '1' then
--                cache_data <= (others => (others => '0'));
--                cache_index <= (others => (others => '0'));
--                state <= INVALID;
--                cur_slot <= (others => '0');
--                read_wrapped <= false;
--                arready <= '0';
--                write_count <= 0;
--                read_addr_valid <= false;
--            else
--                case state is
--                when VALID =>
--                    if S_AXI_ARVALID = '1' and arready = '0' then
--                        if (araddr >= cache_address_base) and 
--                            (araddr < cache_address_base + WORD_NUM) and
--                            (unsigned(S_AXI_ARLEN) < WORD_NUM) then
--                            -- cache hit
--                            read_addr <= araddr
--                            read_len <= unsigned(S_AXI_ARLEN) + 1;
--                            arready <= '1';
--                            write_count <= 0;
--                            read_addr_valid <= true;
--                        else
--                            -- cache miss
--                            state <= INVALID;
--                            cache_address_base <= araddr;
--                            cur_slot <= unsigned(S_AXI_ARADDR(cacheslot_msb downto 0));
--                            read_wrapped <= false;
--                            arready <= '0';
--                        end if;
--                    else
--                       arready <= '0';
--                    end if;
--                    if read_addr_valid and S_AXI_ARVALID = '0' and rlast = '0' then
--                        S_AXI_RDATA <= cache(to_integer((read_addr-cache_address_base)+write_count));
--                        S_AXI_RVALID <= '1';
--                        if write_count >= read_len - 1 or write_count >= WORD_NUM - 1 then
--                            rlast <= '1';
--                            read_addr_valid <= false;
--                        elsif S_AXI_RREADY = '1' then
--                            write_count <= write_count + 1;
--                            rlast <= '0';
--                        end if;
--                    else
--                        rlast <= '0';
--                        S_AXI_RVALID <= '0';
--                    end if;
--                when INVALID =>
--                    if S_AXI_ARVALID = '1' then
--                        cache_address_base <= araddr;
--                        cur_slot <= unsigned(S_AXI_ARADDR(cacheslot_msb downto 0));
--                        read_wrapped <= false;
--                        arready <= '0';
--                    end if;
--                    if M_AXI_RVALID = '1' and S_AXI_RREADY = '1' and M_AXI_RRESP = "00" then
--                        -- one more word has been read

--                        -- if we overwrote old data we have to update the base address
--                        if read_wrapped then
--                            cache_address_base <= cache_address_base + cache_size;
--                        end if;
--                        -- if cache is too small for new data only accept the most recent
--                        -- by overwriting the oldest data
--                        if cur_slot >= cache_size-1 then
--                            cur_slot <= 0;
--                            read_wrapped <= true;
--                        else
--                            cur_slot <= cur_slot + 1;
--                            read_wrapped <= false;
--                        end if;
--                        -- last word has been read. go back to valid state    
--                        if M_AXI_RLAST = '1' then
--                            state <= VALID;
--                        end if;
--                        cache(cur_slot) <= M_AXI_RDATA;
--                    end if;
--                    --  Read address channel signals
--                    M_AXI_ARADDR  <= S_AXI_ARADDR;
--                    M_AXI_ARLEN   <= S_AXI_ARLEN;
--                    M_AXI_ARSIZE  <= S_AXI_ARSIZE;
--                    M_AXI_ARBURST <= S_AXI_ARBURST;
--                    M_AXI_ARCACHE <= S_AXI_ARCACHE;
--                    M_AXI_ARPROT  <= S_AXI_ARPROT;
--                    M_AXI_ARVALID <= S_AXI_ARVALID;
--                    arready       <= M_AXI_ARREADY;
--                    -- Read data channel signals
--                    S_AXI_RDATA   <= M_AXI_RDATA;
--                    S_AXI_RRESP   <= M_AXI_RRESP;
--                    rlast         <= M_AXI_RLAST;
--                    S_AXI_RVALID  <= M_AXI_RVALID;
--                    M_AXI_RREADY  <= S_AXI_RREADY;
--                end case;
--            end if;
--        end if;
--    end process;



end Behavioral;
