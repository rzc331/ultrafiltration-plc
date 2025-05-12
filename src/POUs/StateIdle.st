FUNCTION StateIdle : VOID
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
END_VAR

// Turn all pumps off
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

// Turn blower off
AirBlower := FALSE;

END_FUNCTION 