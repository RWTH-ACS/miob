-- Wrapper around axi_intc to be used with pcie_axi Bridge
--
-- Author: Steffen Vogel <stvogel@eonerc.rwth-aachen.de>
-- Copyright: 2016, Steffen Vogel
-- License: LGPLv2.1

library ieee;
use ieee.std_logic_1164.all;

entity axi_pcie_intc is
  port (
    s_axi_aclk                          : in    std_logic;
    s_axi_aresetn                       : in    std_logic;
    s_axi_awaddr                        : in    std_logic_vector(8 downto 0);
    s_axi_awvalid                       : in    std_logic;
    s_axi_awready                       : out   std_logic;
    s_axi_wdata                         : in    std_logic_vector(31 downto 0);
    s_axi_wstrb                         : in    std_logic_vector(3 downto 0);
    s_axi_wvalid                        : in    std_logic;
    s_axi_wready                        : out   std_logic;
    s_axi_bresp                         : out   std_logic_vector(1 downto 0);
    s_axi_bvalid                        : out   std_logic;
    s_axi_bready                        : in    std_logic;
    s_axi_araddr                        : in    std_logic_vector(8 downto 0);
    s_axi_arvalid                       : in    std_logic;
    s_axi_arready                       : out   std_logic;
    s_axi_rdata                         : out   std_logic_vector(31 downto 0);
    s_axi_rresp                         : out   std_logic_vector(1 downto 0);
    s_axi_rvalid                        : out   std_logic;
    s_axi_rready                        : in    std_logic;

    intr                                : in    std_logic_vector(3 downto 0);
    INTX_MSI_Request                    : out   std_logic;
    INTX_MSI_Grant                      : in    std_logic;
    MSI_Vector_Num                      : out   std_logic_vector(4 downto 0);
    MSI_Enable                          : in    std_logic;
    MSI_Vector_Width                    : in    std_logic_vector(2 downto 0)
    );
end entity;

architecture structural of axi_pcie_intc is
  signal ack                            : std_logic_vector(1 downto 0);
  signal address                        : std_logic_vector(31 downto 0);

  component axi_intc_0
    port (
      s_axi_aclk                : in    std_logic;
      s_axi_aresetn             : in    std_logic;
      s_axi_awaddr              : in    std_logic_vector(8 downto 0);
      s_axi_awvalid             : in    std_logic;
      s_axi_awready             : out   std_logic;
      s_axi_wdata               : in    std_logic_vector(31 downto 0);
      s_axi_wstrb               : in    std_logic_vector(3 downto 0);
      s_axi_wvalid              : in    std_logic;
      s_axi_wready              : out   std_logic;
      s_axi_bresp               : out   std_logic_vector(1 downto 0);
      s_axi_bvalid              : out   std_logic;
      s_axi_bready              : in    std_logic;
      s_axi_araddr              : in    std_logic_vector(8 downto 0);
      s_axi_arvalid             : in    std_logic;
      s_axi_arready             : out   std_logic;
      s_axi_rdata               : out   std_logic_vector(31 downto 0);
      s_axi_rresp               : out   std_logic_vector(1 downto 0);
      s_axi_rvalid              : out   std_logic;
      s_axi_rready              : in    std_logic;

      intr                      : in    std_logic_vector(3 downto 0);
      processor_clk             : in    std_logic;
      processor_rst             : in    std_logic;
      irq                       : out   std_logic;
      processor_ack             : in    std_logic_vector(1 downto 0);
      interrupt_address         : out   std_logic_vector(31 downto 0)
      );
  end component;
begin
  INTC : axi_intc_0
    port map (
      s_axi_aclk                => s_axi_aclk,
      s_axi_aresetn             => s_axi_aresetn,
      s_axi_awaddr              => s_axi_awaddr,
      s_axi_awvalid             => s_axi_awvalid,
      s_axi_awready             => s_axi_awready,
      s_axi_wdata               => s_axi_wdata,
      s_axi_wstrb               => s_axi_wstrb,
      s_axi_wvalid              => s_axi_wvalid,
      s_axi_wready              => s_axi_wready,
      s_axi_bresp               => s_axi_bresp,
      s_axi_bvalid              => s_axi_bvalid,
      s_axi_bready              => s_axi_bready,
      s_axi_araddr              => s_axi_araddr,
      s_axi_arvalid             => s_axi_arvalid,
      s_axi_arready             => s_axi_arready,
      s_axi_rdata               => s_axi_rdata,
      s_axi_rresp               => s_axi_rresp,
      s_axi_rvalid              => s_axi_rvalid,
      s_axi_rready              => s_axi_rready,

      intr                      => intr,
      processor_clk             => s_axi_aclk,
      processor_rst             => s_axi_aresetn,
      irq                       => INTX_MSI_Request,
      processor_ack             => ack,
      interrupt_address         => address
      );
  
  MSI_Vector_Num <= address(4 downto 0);

  GEN_PROCESSOR_ACK : process (s_axi_aclk, s_axi_aresetn)
  begin
    if s_axi_aresetn = '0' then
      ack                       <= "00";
    elsif rising_edge(s_axi_aclk) then
      -- Fast acknowledgement of interrupts
      -- is only supported if MSI vectors are registerd
      if MSI_Enable = '1' then
        if INTX_MSI_Grant = '1' then
          ack   <= "01"; -- first ack
        elsif ack = "01" then
          ack   <= "11"; -- second ack
        elsif ack = "11" then
          ack   <= "00"; -- Interrupts are re-enabled
        else
          ack   <= ack;
        end if;
      else
        ack     <= "00";
      end if;
    end if;
  end process;
end architecture;
