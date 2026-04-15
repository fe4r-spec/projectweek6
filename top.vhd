----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:36:46 04/15/2026 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port(
    clk  : in std_logic;
    rx   : in std_logic;

    seg0 : out std_logic_vector(6 downto 0);
    seg1 : out std_logic_vector(6 downto 0)
);
end top;

architecture Behavioral of top is

signal tick     : std_logic;
signal rx_byte  : std_logic_vector(7 downto 0);
signal ready    : std_logic;

signal digit0   : std_logic_vector(3 downto 0);
signal digit1   : std_logic_vector(3 downto 0);

begin

-- uart receiver
uart_rx_inst: entity work.uart_rx
port map(
    clk => clk,
    tick => tick,
    rx => rx,
    data_out => rx_byte,
    ready => ready
);

-- split BCD
digit0 <= rx_byte(7 downto 4);
digit1 <= rx_byte(3 downto 0);

-- 7-seg drivers
seg0_inst: entity work.seven_seg
port map(
    bcd => digit0,
    seg => seg0
);

seg1_inst: entity work.seven_seg
port map(
    bcd => digit1,
    seg => seg1
);


end Behavioral;

