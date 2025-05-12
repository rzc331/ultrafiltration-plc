FUNCTION StateGravityDrain : VOID
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

// Close air scour valve and turn off blower
AirScourValve := FALSE;
AirBlower := FALSE;

// Open concentrate/waste valve for gravity drain
ConcentrateValve := TRUE;

// Keep filtrate valve closed to isolate permeate
FiltrateOutletValve := FALSE;

// Close all other valves
FeedInletValve := FALSE;
BackwashTopValve := FALSE;
BackwashBottomValve := FALSE;
CIPInValve := FALSE;
CIPOutValve := FALSE;
ChemicalInjectionValve := FALSE;

END_FUNCTION 