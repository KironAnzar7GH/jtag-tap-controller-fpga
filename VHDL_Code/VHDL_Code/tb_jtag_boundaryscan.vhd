LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_jtag_boundaryscan IS
    generic (TCLK : time := 10 ns);
END tb_jtag_boundaryscan;
 
ARCHITECTURE behavior OF tb_jtag_boundaryscan IS 
 
    COMPONENT jtag_boundaryscan
    PORT(
         TMS : IN  std_logic;
         TCK : IN  std_logic;
         TDO : OUT std_logic;
         TRST : IN std_logic;
         state_out : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
   signal TMS : std_logic := '0';
   signal TCK : std_logic := '0';
   signal TRST : std_logic := '0';
   signal TDO : std_logic;
   signal state_out : std_logic_vector(3 downto 0);
 
BEGIN
   uut: jtag_boundaryscan PORT MAP (
          TMS => TMS,
          TCK => TCK,
          TDO => TDO,
          TRST => TRST,
          state_out => state_out
        );

   -- Clock process definitions
   TCK <= not TCK after TCLK/2;
   TRST <= '0', '1' after TCLK, '0' after 2*TCLK;

   -- Stimulus process
   stimulus: process
   variable state_out_var : std_logic_vector(15 downto 0);
   begin
       wait until (TRST'event and TRST = '1');
       wait until (TRST'event and TRST = '0');
       TMS <= '1';
       wait until (TCK'event and TCK = '1');
       TMS <= '0';
       wait until (TCK'event and TCK = '1');
       TMS <= '1';
       wait until (TCK'event and TCK = '1');
       TMS <= '1';
       wait until (TCK'event and TCK = '1');
       TMS <= '0';
       wait until (TCK'event and TCK = '1');
       TMS <= '0';
       wait until (TCK'event and TCK = '1');
       TMS <= '0';
       wait until (TCK'event and TCK = '1');
       TMS <= '1';
       wait until (TCK'event and TCK = '1');
       TMS <= '1';
       wait until (TCK'event and TCK = '1');
       TMS <= '1';
       wait;
   end process;
END behavior;
