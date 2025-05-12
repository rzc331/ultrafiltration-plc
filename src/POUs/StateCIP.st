FUNCTION_BLOCK StateCIP
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
    
    // Monitoring variables
    CIPTankLevel : REAL;
    CIPTankpH : REAL;
    FiltrateTurbidity : REAL;
    
    // Alarms
    CIPTankEmptyAlarm : BOOL;
    CIPTankOverfillAlarm : BOOL;
END_VAR

VAR
    CIPStep : INT := 0;
    TON_CIPTimer : TON;
    CIPInstalled : BOOL := FALSE;
    SoakTime : TIME := T#30M; // Default 30 minutes
    RinseTime : TIME := T#5M; // Default 5 minutes
END_VAR

VAR_INPUT
    Start : BOOL;
    Stop : BOOL;
    CIPFilterInstalled : BOOL;
END_VAR

VAR_OUTPUT
    Done : BOOL;
    Running : BOOL;
    RequestOperatorConfirmation : BOOL;
    CurrentCIPStep : INT;
    Message : STRING;
END_VAR

// Update the CIP step description for HMI
Message := CASE CIPStep OF
    0: 'CIP Ready',
    1: 'Install CIP filter element and confirm',
    2: 'Fill & pre-rinse',
    3: 'Circulate chemical solution',
    4: 'Soak (static)',
    5: 'Drain CIP solution',
    6: 'Recirculate rinse',
    7: 'Final forward flush',
    8: 'Return to service',
    9: 'CIP Complete',
    ELSE 'Unknown CIP step'
END_CASE;

CurrentCIPStep := CIPStep;

// CIP Step Machine
CASE CIPStep OF
    0: // Initialize
        IF Start THEN
            Running := TRUE;
            Done := FALSE;
            CIPStep := 1;
            
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
            ChemicalInjectionValve := FALSE;
            
            // Reset CIP installed flag
            CIPInstalled := FALSE;
            
            // Request operator confirmation
            RequestOperatorConfirmation := TRUE;
        END_IF;
        
    1: // Install CIP filter element
        // Waiting for operator confirmation
        IF CIPFilterInstalled OR CIPInstalled THEN
            CIPInstalled := TRUE;
            RequestOperatorConfirmation := FALSE;
            CIPStep := 2;
        END_IF;
        
    2: // Fill & pre-rinse
        // Check for tank level alarms
        IF CIPTankEmptyAlarm THEN
            // Cannot proceed if tank is empty
            RETURN;
        END_IF;
        
        // Start feed pump
        FeedPump := TRUE;
        BackwashPump := FALSE;
        CIPPump := FALSE;
        
        // Open feed and filtrate valves for pre-rinse
        FeedInletValve := TRUE;
        FiltrateOutletValve := TRUE;
        
        // Close other valves
        ConcentrateValve := FALSE;
        BackwashTopValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        ChemicalInjectionValve := FALSE;
        
        // Start timer for pre-rinse
        TON_CIPTimer(IN := TRUE, PT := RinseTime);
        
        // Move to next step when timer completes
        IF TON_CIPTimer.Q AND FiltrateTurbidity < 1.0 THEN
            TON_CIPTimer(IN := FALSE);
            CIPStep := 3;
        END_IF;
        
    3: // Circulate chemical solution
        // Check for tank level alarms
        IF CIPTankEmptyAlarm THEN
            // Cannot proceed if tank is empty
            RETURN;
        END_IF;
        
        // Stop feed pump, start CIP pump
        FeedPump := FALSE;
        BackwashPump := FALSE;
        CIPPump := TRUE;
        
        // Close filtrate valve, open CIP valves
        FiltrateOutletValve := FALSE;
        CIPInValve := TRUE;
        CIPOutValve := TRUE;
        
        // Close other valves
        FeedInletValve := FALSE;
        ConcentrateValve := FALSE;
        BackwashTopValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        ChemicalInjectionValve := FALSE;
        
        // Start timer for circulation
        TON_CIPTimer(IN := TRUE, PT := T#5M);
        
        // Move to next step when timer completes
        IF TON_CIPTimer.Q THEN
            TON_CIPTimer(IN := FALSE);
            CIPStep := 4;
        END_IF;
        
    4: // Soak (static)
        // Turn all pumps off for soak
        FeedPump := FALSE;
        BackwashPump := FALSE;
        CIPPump := FALSE;
        
        // Keep CIP valves closed for isolation
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        
        // Make sure all other valves are closed
        FeedInletValve := FALSE;
        FiltrateOutletValve := FALSE;
        ConcentrateValve := FALSE;
        BackwashTopValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        ChemicalInjectionValve := FALSE;
        
        // Start timer for soak
        TON_CIPTimer(IN := TRUE, PT := SoakTime);
        
        // Move to next step when timer completes
        IF TON_CIPTimer.Q THEN
            TON_CIPTimer(IN := FALSE);
            CIPStep := 5;
        END_IF;
        
    5: // Drain CIP solution
        // All pumps remain off
        FeedPump := FALSE;
        BackwashPump := FALSE;
        CIPPump := FALSE;
        
        // Open concentrate valve to drain
        ConcentrateValve := TRUE;
        
        // Close all other valves
        FeedInletValve := FALSE;
        FiltrateOutletValve := FALSE;
        BackwashTopValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        ChemicalInjectionValve := FALSE;
        
        // Start timer for drain
        TON_CIPTimer(IN := TRUE, PT := T#2M);
        
        // Move to next step when timer completes
        IF TON_CIPTimer.Q THEN
            TON_CIPTimer(IN := FALSE);
            CIPStep := 6;
        END_IF;
        
    6: // Recirculate rinse
        // Start feed pump
        FeedPump := TRUE;
        BackwashPump := FALSE;
        CIPPump := FALSE;
        
        // Open feed and filtrate valves for rinse
        FeedInletValve := TRUE;
        FiltrateOutletValve := TRUE;
        
        // Open concentrate valve to ensure flushing
        ConcentrateValve := TRUE;
        
        // Close other valves
        BackwashTopValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        ChemicalInjectionValve := FALSE;
        
        // Start timer for rinse
        TON_CIPTimer(IN := TRUE, PT := RinseTime);
        
        // Move to next step when timer completes and effluent is clear
        IF TON_CIPTimer.Q AND FiltrateTurbidity < 0.5 THEN
            TON_CIPTimer(IN := FALSE);
            CIPStep := 7;
        END_IF;
        
    7: // Final forward flush
        // Keep feed pump running
        FeedPump := TRUE;
        BackwashPump := FALSE;
        CIPPump := FALSE;
        
        // Keep filtration path open
        FeedInletValve := TRUE;
        FiltrateOutletValve := TRUE;
        ConcentrateValve := TRUE;
        
        // Close all other valves
        BackwashTopValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        ChemicalInjectionValve := FALSE;
        
        // Start timer for final flush
        TON_CIPTimer(IN := TRUE, PT := T#3M);
        
        // Move to next step when timer completes
        IF TON_CIPTimer.Q THEN
            TON_CIPTimer(IN := FALSE);
            CIPStep := 8;
        END_IF;
        
    8: // Return to service
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
        ChemicalInjectionValve := FALSE;
        
        // Request operator to remove CIP filter
        RequestOperatorConfirmation := TRUE;
        Message := 'Remove CIP filter and confirm to return to service';
        
        // Wait for operator confirmation
        IF CIPFilterInstalled = FALSE THEN
            RequestOperatorConfirmation := FALSE;
            CIPStep := 9;
        END_IF;
        
    9: // Complete
        Running := FALSE;
        Done := TRUE;
        RequestOperatorConfirmation := FALSE;
        
        // Return to idle state
        CurrentState := 0; // Go to Idle
        
        CIPStep := 0;
END_CASE;

IF Stop THEN
    CIPStep := 0;
    Running := FALSE;
    Done := FALSE;
    RequestOperatorConfirmation := FALSE;
    TON_CIPTimer(IN := FALSE);
END_IF;

END_FUNCTION_BLOCK 