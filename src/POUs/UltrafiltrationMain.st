PROGRAM UltrafiltrationMain
VAR
    // State machine variables
    CurrentState : INT := 0; // 0=Idle, 1=Filtration, 2=AirScour, 3=GravityDrain, 4=BackwashTop, 5=BackwashBottom, 6=ForwardFlush, 7=CEB, 8=CIP
    PreviousState : INT := 0;
    StateTimer : TIME := T#0S;
    
    // Command variables
    StartFiltration : BOOL := FALSE;
    StopSystem : BOOL := FALSE;
    StartCEB : BOOL := FALSE;
    StartCIP : BOOL := FALSE;
    
    // Sensor inputs
    FeedPressure : REAL; // bar
    FiltratePressure : REAL; // bar
    TMP : REAL; // Transmembrane pressure (bar)
    FeedFlow : REAL; // m³/h
    FiltrateFlow : REAL; // m³/h
    FeedTurbidity : REAL; // NTU
    FiltrateTurbidity : REAL; // NTU
    CIPTankLevel : REAL; // %
    CIPTankpH : REAL; // pH units
    
    // Setpoints
    TMPSetpoint : REAL := 2.0; // bar
    FiltrationTimeSetpoint : TIME := T#60M; // 60 minutes default
    AirScourTimeSetpoint : TIME := T#30S;
    GravityDrainTimeSetpoint : TIME := T#45S;
    BackwashTopTimeSetpoint : TIME := T#40S;
    BackwashBottomTimeSetpoint : TIME := T#40S;
    ForwardFlushTimeSetpoint : TIME := T#45S;
    CEBSoakTimeSetpoint : TIME := T#10M;
    
    // Alarms
    HighTMPAlarm : BOOL := FALSE;
    LowFeedPressureAlarm : BOOL := FALSE;
    HighTurbidityAlarm : BOOL := FALSE;
    CIPTankEmptyAlarm : BOOL := FALSE;
    CIPTankOverfillAlarm : BOOL := FALSE;
    
    // Internal variables
    InTransition : BOOL := FALSE;
    CIPStep : INT := 0;
    CIPConfirmed : BOOL := FALSE;
    
    // Function blocks
    TON_StateTimer : TON;
    TON_CEBInterval : TON;
    R_TRIG_StartFiltration : R_TRIG;
    R_TRIG_StopSystem : R_TRIG;
    R_TRIG_StartCEB : R_TRIG;
    R_TRIG_StartCIP : R_TRIG;
END_VAR

// Edge detection for commands
R_TRIG_StartFiltration(CLK := StartFiltration);
R_TRIG_StopSystem(CLK := StopSystem);
R_TRIG_StartCEB(CLK := StartCEB);
R_TRIG_StartCIP(CLK := StartCIP);

// Calculate TMP
TMP := FeedPressure - FiltratePressure;

// Check for alarms
HighTMPAlarm := TMP > (TMPSetpoint * 1.2); // 20% above setpoint
LowFeedPressureAlarm := FeedPressure < 0.5 AND CurrentState > 0; // Only when system running
HighTurbidityAlarm := FiltrateTurbidity > 1.0; // NTU
CIPTankEmptyAlarm := CIPTankLevel < 5.0;
CIPTankOverfillAlarm := CIPTankLevel > 95.0;

// State timer
TON_StateTimer(IN := NOT InTransition, PT := StateTimer);

// State Machine
CASE CurrentState OF
    0: // Idle
        IF R_TRIG_StartFiltration.Q THEN
            PreviousState := CurrentState;
            CurrentState := 1; // Go to Filtration
            InTransition := TRUE;
            StateTimer := FiltrationTimeSetpoint;
        ELSIF R_TRIG_StartCIP.Q THEN
            PreviousState := CurrentState;
            CurrentState := 8; // Go to CIP
            InTransition := TRUE;
            CIPStep := 1; // Start CIP sequence
        END_IF;
        
    1: // Filtration
        IF TON_StateTimer.Q OR TMP >= TMPSetpoint OR R_TRIG_StopSystem.Q THEN
            IF R_TRIG_StopSystem.Q THEN
                PreviousState := CurrentState;
                CurrentState := 0; // Go to Idle
            ELSE
                PreviousState := CurrentState;
                CurrentState := 2; // Go to Air Scour
                StateTimer := AirScourTimeSetpoint;
            END_IF;
            InTransition := TRUE;
        ELSIF R_TRIG_StartCEB.Q THEN
            PreviousState := CurrentState;
            CurrentState := 7; // Go to CEB
            InTransition := TRUE;
        ELSIF HighTMPAlarm THEN
            PreviousState := CurrentState;
            CurrentState := 2; // Go to Air Scour
            StateTimer := AirScourTimeSetpoint;
            InTransition := TRUE;
        END_IF;
        
    2: // Air Scour
        IF TON_StateTimer.Q OR R_TRIG_StopSystem.Q THEN
            IF R_TRIG_StopSystem.Q THEN
                PreviousState := CurrentState;
                CurrentState := 0; // Go to Idle
            ELSE
                PreviousState := CurrentState;
                CurrentState := 3; // Go to Gravity Drain
                StateTimer := GravityDrainTimeSetpoint;
            END_IF;
            InTransition := TRUE;
        END_IF;
        
    3: // Gravity Drain
        IF TON_StateTimer.Q OR R_TRIG_StopSystem.Q THEN
            IF R_TRIG_StopSystem.Q THEN
                PreviousState := CurrentState;
                CurrentState := 0; // Go to Idle
            ELSE
                PreviousState := CurrentState;
                CurrentState := 4; // Go to Backwash Top
                StateTimer := BackwashTopTimeSetpoint;
            END_IF;
            InTransition := TRUE;
        END_IF;
        
    4: // Backwash Top
        IF TON_StateTimer.Q OR R_TRIG_StopSystem.Q THEN
            IF R_TRIG_StopSystem.Q THEN
                PreviousState := CurrentState;
                CurrentState := 0; // Go to Idle
            ELSE
                PreviousState := CurrentState;
                CurrentState := 5; // Go to Backwash Bottom
                StateTimer := BackwashBottomTimeSetpoint;
            END_IF;
            InTransition := TRUE;
        END_IF;
        
    5: // Backwash Bottom
        IF TON_StateTimer.Q OR R_TRIG_StopSystem.Q THEN
            IF R_TRIG_StopSystem.Q THEN
                PreviousState := CurrentState;
                CurrentState := 0; // Go to Idle
            ELSE
                PreviousState := CurrentState;
                CurrentState := 6; // Go to Forward Flush
                StateTimer := ForwardFlushTimeSetpoint;
            END_IF;
            InTransition := TRUE;
        END_IF;
        
    6: // Forward Flush
        IF TON_StateTimer.Q OR R_TRIG_StopSystem.Q THEN
            IF R_TRIG_StopSystem.Q THEN
                PreviousState := CurrentState;
                CurrentState := 0; // Go to Idle
            ELSE
                PreviousState := CurrentState;
                CurrentState := 1; // Go back to Filtration
                StateTimer := FiltrationTimeSetpoint;
            END_IF;
            InTransition := TRUE;
        END_IF;
        
    7: // CEB (Chemically Enhanced Backwash)
        // CEB implementation called via function block
        IF R_TRIG_StopSystem.Q THEN
            PreviousState := CurrentState;
            CurrentState := 0; // Go to Idle
            InTransition := TRUE;
        END_IF;
        // After CEB completes in CEB function block, it should set CurrentState := 1 (Filtration)
        
    8: // CIP (Clean-In-Place)
        // CIP implementation called via function block
        IF R_TRIG_StopSystem.Q THEN
            PreviousState := CurrentState;
            CurrentState := 0; // Go to Idle
            InTransition := TRUE;
        END_IF;
        // After CIP completes in CIP function block, it should set CurrentState := 0 (Idle)
        
END_CASE;

// Call state-specific function blocks
CASE CurrentState OF
    0: StateIdle();
    1: StateFiltration();
    2: StateAirScour();
    3: StateGravityDrain();
    4: StateBackwashTop();
    5: StateBackwashBottom();
    6: StateForwardFlush();
    7: StateCEB();
    8: StateCIP();
END_CASE;

// Reset transition flag
IF InTransition THEN
    InTransition := FALSE;
END_IF;
END_PROGRAM 