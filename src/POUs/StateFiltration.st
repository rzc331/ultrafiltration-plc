FUNCTION StateFiltration : VOID
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
    
    // Monitoring variables
    FeedPressure : REAL;
    FiltratePressure : REAL;
    TMP : REAL;
    FeedFlow : REAL;
    FiltrateFlow : REAL;
    FeedTurbidity : REAL;
    FiltrateTurbidity : REAL;
    
    // Alarms
    LowFeedPressureAlarm : BOOL;
END_VAR

// Check safety interlocks
IF LowFeedPressureAlarm THEN
    FeedPump := FALSE;
    RETURN;
END_IF;

// Turn feed pump on, other pumps off
FeedPump := TRUE;
BackwashPump := FALSE;
CIPPump := FALSE;

// Open filtration path valves
FeedInletValve := TRUE;
FiltrateOutletValve := TRUE;

// Close all other valves
ConcentrateValve := FALSE;
BackwashTopValve := FALSE;
BackwashBottomValve := FALSE;
AirScourValve := FALSE;
CIPInValve := FALSE;
CIPOutValve := FALSE;
ChemicalInjectionValve := FALSE;

// Turn blower off
AirBlower := FALSE;

END_FUNCTION 