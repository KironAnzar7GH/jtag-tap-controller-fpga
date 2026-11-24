library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jtag_boundaryscan is
    Port ( 
           TMS: in STD_LOGIC;
           TCK: in STD_LOGIC;
           TDO: out STD_LOGIC;
           TRST: in STD_LOGIC;
           state_out: out STD_LOGIC_VECTOR(3 downto 0)
    );
end jtag_boundaryscan;

architecture Behavioral of jtag_boundaryscan is
    type t_state is (TEST_LOGIC_RESET, RUN_TEST_IDLE, SELECT_DR_SCAN, CAPTURE_DR, SHIFT_DR, EXIT1_DR, PAUSE_DR, EXIT2_DR, UPDATE_DR, SELECT_IR_SCAN, CAPTURE_IR, SHIFT_IR, EXIT1_IR, PAUSE_IR, EXIT2_IR, UPDATE_IR);
    signal cstate, nstate : t_state;
begin
    process (TCK, TRST)
    begin
        if (TRST = '1') then 
            cstate <= TEST_LOGIC_RESET;
        elsif (rising_edge(TCK)) then
            cstate <= nstate;
        end if;
    end process;
    
    with cstate select 
    state_out <= "0000" when test_logic_reset, 
                 "0001" when run_test_idle, 
                 "0010" when select_dr_scan, 
                 "0011" when select_ir_scan,  
                 "0100" when capture_ir,
                 "0101" when shift_ir,
                 "0110" when exit1_ir,
                 "0111" when pause_ir,
                 "1000" when exit2_ir,
                 "1001" when update_ir,
                 "1010" when capture_dr,
                 "1011" when shift_dr,
                 "1100" when exit1_dr,
                 "1101" when pause_dr,
                 "1110" when exit2_dr,
                 "1111" when update_dr;
                 
    Jtag_boundaryscan_fsm: process (TMS, cstate)
    begin
        case cstate is
            when TEST_LOGIC_RESET =>
                if TMS = '1' then nstate <= TEST_LOGIC_RESET; else nstate <= RUN_TEST_IDLE; end if;
            when RUN_TEST_IDLE => 
                if TMS = '1' then nstate <= SELECT_DR_SCAN; else nstate <= RUN_TEST_IDLE; end if;
            when SELECT_DR_SCAN => 
                if TMS = '1' then nstate <= SELECT_IR_SCAN; else nstate <= CAPTURE_DR; end if;
            when CAPTURE_DR => 
                if TMS = '1' then nstate <= EXIT1_DR; else nstate <= SHIFT_DR; end if;
            when SHIFT_DR => 
                if TMS = '1' then nstate <= EXIT1_DR; else nstate <= SHIFT_DR; end if;
            when EXIT1_DR => 
                if TMS = '1' then nstate <= UPDATE_DR; else nstate <= PAUSE_DR; end if;
            when PAUSE_DR => 
                if TMS = '1' then nstate <= EXIT2_DR; else nstate <= PAUSE_DR; end if;
            when EXIT2_DR => 
                if TMS = '1' then nstate <= UPDATE_DR; else nstate <= SHIFT_DR; end if;
            when UPDATE_DR => 
                if TMS = '1' then nstate <= SELECT_DR_SCAN; else nstate <= RUN_TEST_IDLE; end if;
            when SELECT_IR_SCAN => 
                if TMS = '1' then nstate <= TEST_LOGIC_RESET; else nstate <= CAPTURE_IR; end if;
            when CAPTURE_IR => 
                if TMS = '1' then nstate <= EXIT1_IR; else nstate <= SHIFT_IR; end if;
            when SHIFT_IR => 
                if TMS = '1' then nstate <= EXIT1_IR; else nstate <= SHIFT_IR; end if;
            when EXIT1_IR => 
                if TMS = '1' then nstate <= UPDATE_IR; else nstate <= PAUSE_IR; end if;
            when PAUSE_IR => 
                if TMS = '1' then nstate <= EXIT2_IR; else nstate <= PAUSE_IR; end if;
            when EXIT2_IR => 
                if TMS = '1' then nstate <= UPDATE_IR; else nstate <= SHIFT_IR; end if;
            when UPDATE_IR => 
                if TMS = '1' then nstate <= SELECT_DR_SCAN; else nstate <= RUN_TEST_IDLE; end if;
            when others =>
                nstate <= TEST_LOGIC_RESET; 
        end case;
    end process;
end Behavioral;
