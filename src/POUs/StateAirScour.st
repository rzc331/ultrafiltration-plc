FUNCTION StateAirScour : VOID
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

// Close filtrate valve to isolate permeate
FiltrateOutletValve := FALSE;

// Close feed inlet
FeedInletValve := FALSE;

// Open air scour valve and run blower
AirScourValve := TRUE;
AirBlower := TRUE;

// Close all other valves
ConcentrateValve := FALSE;
BackwashTopValve := FALSE;
BackwashBottomValve := FALSE;
CIPInValve := FALSE;
CIPOutValve := FALSE;
ChemicalInjectionValve := FALSE;

END_FUNCTION 