FUNCTION StateBackwashTop : VOID
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

// Turn feed pump off, backwash pump on, CIP pump off
FeedPump := FALSE;
BackwashPump := TRUE;
CIPPump := FALSE;

// Open backwash top valve
BackwashTopValve := TRUE;

// Open concentrate valve to allow backwash water to exit
ConcentrateValve := TRUE;

// Close all other valves
FeedInletValve := FALSE;
FiltrateOutletValve := FALSE;
BackwashBottomValve := FALSE;
AirScourValve := FALSE;
CIPInValve := FALSE;
CIPOutValve := FALSE;
ChemicalInjectionValve := FALSE;

// Turn blower off
AirBlower := FALSE;

END_FUNCTION 