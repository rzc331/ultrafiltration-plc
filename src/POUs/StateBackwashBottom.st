FUNCTION StateBackwashBottom : VOID
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

// Keep backwash pump running
FeedPump := FALSE;
BackwashPump := TRUE;
CIPPump := FALSE;

// Switch from top to bottom backwash
BackwashTopValve := FALSE;
BackwashBottomValve := TRUE;

// Keep concentrate valve open to allow backwash water to exit
ConcentrateValve := TRUE;

// Close all other valves
FeedInletValve := FALSE;
FiltrateOutletValve := FALSE;
AirScourValve := FALSE;
CIPInValve := FALSE;
CIPOutValve := FALSE;
ChemicalInjectionValve := FALSE;

// Turn blower off
AirBlower := FALSE;

END_FUNCTION 