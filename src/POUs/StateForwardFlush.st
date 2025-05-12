FUNCTION StateForwardFlush : VOID
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
    
    // Alarms
    LowFeedPressureAlarm : BOOL;
END_VAR

// Check safety interlocks
IF LowFeedPressureAlarm THEN
    FeedPump := FALSE;
    RETURN;
END_IF;

// Switch from backwash pump to feed pump
FeedPump := TRUE;
BackwashPump := FALSE;
CIPPump := FALSE;

// Open feed and filtrate valves
FeedInletValve := TRUE;
FiltrateOutletValve := TRUE;

// Keep concentrate valve open to ensure purging of residuals and air
ConcentrateValve := TRUE;

// Close all backwash valves
BackwashTopValve := FALSE;
BackwashBottomValve := FALSE;
AirScourValve := FALSE;
CIPInValve := FALSE;
CIPOutValve := FALSE;
ChemicalInjectionValve := FALSE;

// Turn blower off
AirBlower := FALSE;

END_FUNCTION 