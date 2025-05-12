VAR_GLOBAL
    // State machine variables
    CurrentState : INT := 0; // 0=Idle, 1=Filtration, 2=AirScour, 3=GravityDrain, 4=BackwashTop, 5=BackwashBottom, 6=ForwardFlush, 7=CEB, 8=CIP
    PreviousState : INT := 0;
    StateTimer : TIME := T#0S;
    InTransition : BOOL := FALSE;
    
    // Command variables
    StartFiltration : BOOL := FALSE;
    StopSystem : BOOL := FALSE;
    StartCEB : BOOL := FALSE;
    StartCIP : BOOL := FALSE;
    CIPFilterInstalled : BOOL := FALSE;
    
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
    
    // Outputs - Pumps
    FeedPump : BOOL := FALSE;
    BackwashPump : BOOL := FALSE;
    CIPPump : BOOL := FALSE;
    
    // Outputs - Valves
    FeedInletValve : BOOL := FALSE;
    FiltrateOutletValve : BOOL := FALSE;
    ConcentrateValve : BOOL := FALSE;
    BackwashTopValve : BOOL := FALSE;
    BackwashBottomValve : BOOL := FALSE;
    AirScourValve : BOOL := FALSE;
    CIPInValve : BOOL := FALSE;
    CIPOutValve : BOOL := FALSE;
    ChemicalInjectionValve : BOOL := FALSE;
    
    // Outputs - Blower
    AirBlower : BOOL := FALSE;
    
    // System status
    SystemRunning : BOOL := FALSE;
    CurrentCIPStep : INT := 0;
    CIPMessage : STRING := '';
    CEBRunning : BOOL := FALSE;
    CIPRunning : BOOL := FALSE;
END_VAR 