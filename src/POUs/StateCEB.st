FUNCTION_BLOCK StateCEB
VAR_EXTERNAL
    // Outputs
    FeedPump : BOOL;
    BackwashPump : BOOL;
    CIPPump : BOOL;
    
    // Valves
    FeedInletValve : BOOL;
    FiltrateOutletValve : BOOL;
    ConcentrateValve : BOOL;
    BackwashTopValve : BOOL;
    BackwashBottomValve : BOOL;
    AirScourValve : BOOL;
    CIPInValve : BOOL;
    CIPOutValve : BOOL;
    ChemicalInjectionValve : BOOL;
    
    // Blower
    AirBlower : BOOL;
    
    // State machine variables
    CurrentState : INT;
    PreviousState : INT;
    StateTimer : TIME;
    InTransition : BOOL;
    
    // Setpoints
    CEBSoakTimeSetpoint : TIME;
    BackwashTopTimeSetpoint : TIME;
    BackwashBottomTimeSetpoint : TIME;
    ForwardFlushTimeSetpoint : TIME;
END_VAR

VAR
    CEBStep : INT := 0;
    TON_CEBTimer : TON;
END_VAR

VAR_INPUT
    Start : BOOL;
    Stop : BOOL;
END_VAR

VAR_OUTPUT
    Done : BOOL;
    Running : BOOL;
END_VAR

// CEB Step Machine
CASE CEBStep OF
    0: // Initialize
        IF Start THEN
            Running := TRUE;
            Done := FALSE;
            CEBStep := 1;
            
            // Stop all pumps
            FeedPump := FALSE;
            BackwashPump := FALSE;
            CIPPump := FALSE;
            
            // Close all valves
            FeedInletValve := FALSE;
            FiltrateOutletValve := FALSE;
            ConcentrateValve := FALSE;
            BackwashTopValve := FALSE;
            BackwashBottomValve := FALSE;
            AirScourValve := FALSE;
            CIPInValve := FALSE;
            CIPOutValve := FALSE;
            
            // Prepare chemical injection
            ChemicalInjectionValve := TRUE;
        END_IF;
        
    1: // Chemical injection and backwash
        // Start backwash pump
        BackwashPump := TRUE;
        FeedPump := FALSE;
        CIPPump := FALSE;
        
        // Set up for backwash with chemicals
        BackwashTopValve := TRUE;
        ConcentrateValve := TRUE;
        ChemicalInjectionValve := TRUE;
        
        // Close other valves
        FeedInletValve := FALSE;
        FiltrateOutletValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        
        // Start timer for chemical soak
        TON_CEBTimer(IN := TRUE, PT := CEBSoakTimeSetpoint);
        
        // Move to next step when timer completes
        IF TON_CEBTimer.Q THEN
            TON_CEBTimer(IN := FALSE);
            CEBStep := 2;
        END_IF;
        
    2: // Normal backwash sequence after chemical soak
        // Turn off chemical injection valve
        ChemicalInjectionValve := FALSE;
        
        // Set next state to Backwash Top
        PreviousState := CurrentState;
        CurrentState := 4; // Backwash Top
        StateTimer := BackwashTopTimeSetpoint;
        InTransition := TRUE;
        CEBStep := 3;
        
    3: // Wait for backwash sequence to complete
        // In this step, we allow the regular state machine to handle
        // the backwash sequence through ForwardFlush
        
        // We check if we've reached filtration again
        IF CurrentState = 1 THEN
            // CEB process is complete
            CEBStep := 4;
        END_IF;
        
    4: // Complete
        Running := FALSE;
        Done := TRUE;
        CEBStep := 0;
END_CASE;

IF Stop THEN
    CEBStep := 0;
    Running := FALSE;
    Done := FALSE;
    TON_CEBTimer(IN := FALSE);
END_IF;

END_FUNCTION_BLOCK 