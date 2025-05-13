# Ultrafiltration PLC Project Documentation

This file contains all structured text (.st), XML, and Markdown files from the project.


## DuPont_Ultrafiltration.xml

Source: `./DuPont_Ultrafiltration.xml`

```
<?xml version="1.0" encoding="utf-8"?>
<project xmlns="http://www.plcopen.org/xml/tc6_0200">
  <fileHeader companyName="DuPont" productName="Ultrafiltration Skid Control" productVersion="1.0" creationDateTime="2023-06-01T12:00:00"/>
  <contentHeader name="DuPont_Ultrafiltration_Control" modificationDateTime="2023-06-01T12:00:00">
    <coordinateInfo>
      <fbd><scaling x="1" y="1"/></fbd>
      <ld><scaling x="1" y="1"/></ld>
      <sfc><scaling x="1" y="1"/></sfc>
    </coordinateInfo>
  </contentHeader>
  <types>
    <dataTypes/>
    <pous>
      <pou name="UltrafiltrationMain" pouType="program">
        <interface>
          <localVars>
            <variable name="TON_StateTimer">
              <type><derived name="TON"/></type>
            </variable>
            <variable name="TON_CEBInterval">
              <type><derived name="TON"/></type>
            </variable>
            <variable name="R_TRIG_StartFiltration">
              <type><derived name="R_TRIG"/></type>
            </variable>
            <variable name="R_TRIG_StopSystem">
              <type><derived name="R_TRIG"/></type>
            </variable>
            <variable name="R_TRIG_StartCEB">
              <type><derived name="R_TRIG"/></type>
            </variable>
            <variable name="R_TRIG_StartCIP">
              <type><derived name="R_TRIG"/></type>
            </variable>
          </localVars>
        </interface>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/UltrafiltrationMain.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateIdle" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateIdle.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateFiltration" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateFiltration.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateAirScour" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateAirScour.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateGravityDrain" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateGravityDrain.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateBackwashTop" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateBackwashTop.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateBackwashBottom" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateBackwashBottom.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateForwardFlush" pouType="function">
        <interface/>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateForwardFlush.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateCEB" pouType="functionBlock">
        <interface>
          <inputVars>
            <variable name="Start">
              <type><BOOL/></type>
            </variable>
            <variable name="Stop">
              <type><BOOL/></type>
            </variable>
          </inputVars>
          <outputVars>
            <variable name="Done">
              <type><BOOL/></type>
            </variable>
            <variable name="Running">
              <type><BOOL/></type>
            </variable>
          </outputVars>
          <localVars>
            <variable name="CEBStep">
              <type><INT/></type>
              <initialValue>0</initialValue>
            </variable>
            <variable name="TON_CEBTimer">
              <type><derived name="TON"/></type>
            </variable>
          </localVars>
        </interface>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateCEB.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
      <pou name="StateCIP" pouType="functionBlock">
        <interface>
          <inputVars>
            <variable name="Start">
              <type><BOOL/></type>
            </variable>
            <variable name="Stop">
              <type><BOOL/></type>
            </variable>
            <variable name="CIPFilterInstalled">
              <type><BOOL/></type>
            </variable>
          </inputVars>
          <outputVars>
            <variable name="Done">
              <type><BOOL/></type>
            </variable>
            <variable name="Running">
              <type><BOOL/></type>
            </variable>
            <variable name="RequestOperatorConfirmation">
              <type><BOOL/></type>
            </variable>
            <variable name="CurrentCIPStep">
              <type><INT/></type>
            </variable>
            <variable name="Message">
              <type><string/></type>
            </variable>
          </outputVars>
          <localVars>
            <variable name="CIPStep">
              <type><INT/></type>
              <initialValue>0</initialValue>
            </variable>
            <variable name="TON_CIPTimer">
              <type><derived name="TON"/></type>
            </variable>
            <variable name="CIPInstalled">
              <type><BOOL/></type>
              <initialValue>FALSE</initialValue>
            </variable>
            <variable name="SoakTime">
              <type><time/></type>
              <initialValue>T#30M</initialValue>
            </variable>
            <variable name="RinseTime">
              <type><time/></type>
              <initialValue>T#5M</initialValue>
            </variable>
          </localVars>
        </interface>
        <body>
          <ST>
            <xhtml xmlns="http://www.w3.org/1999/xhtml">
              <p>INCLUDE "src/POUs/StateCIP.st"</p>
            </xhtml>
          </ST>
        </body>
      </pou>
    </pous>
  </types>
  <instances>
    <configurations>
      <configuration name="DuPont_UF_Config">
        <resource name="PLC_Logic">
          <globalVars>
            <file>src/Global/Global_Variables.st</file>
          </globalVars>
          <task name="MainTask" interval="T#50ms" priority="1">
            <pouInstance name="MainProgram" typeName="UltrafiltrationMain"/>
          </task>
        </resource>
      </configuration>
    </configurations>
  </instances>
</project> 
```


## README.md

Source: `./README.md`

```
# DuPont Ultrafiltration Skid Control System

This PLCopen XML project implements the control logic for a DuPont ultrafiltration skid system. The control system manages a complete cycle of filtration, cleaning, and maintenance operations for the ultrafiltration membranes.

## Project Structure

- `DuPont_Ultrafiltration.xml` - Main PLCopen XML project file
- `src/POUs/` - Program Organization Units containing Structured Text files
  - `UltrafiltrationMain.st` - Main program with state machine implementation
  - `StateIdle.st` - Idle/Standby state implementation
  - `StateFiltration.st` - Filtration state implementation
  - `StateAirScour.st` - Air Scour state implementation
  - `StateGravityDrain.st` - Gravity Drain state implementation
  - `StateBackwashTop.st` - Backwash Top state implementation
  - `StateBackwashBottom.st` - Backwash Bottom state implementation
  - `StateForwardFlush.st` - Forward Flush state implementation
  - `StateCEB.st` - Chemically Enhanced Backwash function block
  - `StateCIP.st` - Clean-In-Place function block
- `src/Global/` - Global variable definitions
  - `Global_Variables.st` - Global variables for the entire system

## State Machine Overview

The ultrafiltration system operates through the following states:

1. **Idle/Standby** - System awaiting "Start Filtration" command
2. **Filtration** - Normal operation, membranes filtering water
3. **Air Scour** - Air scouring to loosen fouling from membranes
4. **Gravity Drain** - Draining of system by gravity
5. **Backwash Top** - Backwashing from the top of membrane modules
6. **Backwash Bottom** - Backwashing from the bottom of membrane modules
7. **Forward Flush** - Flushing system of residuals and air
8. **CEB** - Chemically Enhanced Backwash for more intense cleaning
9. **CIP** - Clean-In-Place for comprehensive chemical cleaning

## Instrumentation

The system utilizes the following instrumentation for monitoring and control:
- Pressure transmitters on feed, filtrate, and concentrate lines
- Flow transmitters on feed, backwash, CEB, and CIP lines
- Turbidity meters on feed and filtrate
- Level and pH sensors in CIP/chemical tanks

## Implementation Notes

- The control system uses a state machine architecture to manage operation sequences
- Transitions between states are driven by time, TMP (transmembrane pressure), flow, and operator commands
- Safety interlocks are implemented to prevent unsafe equipment operation
- CEB and CIP sequences follow defined step-by-step procedures with operator confirmation points
- All setpoints are configurable for process optimization

## Prerequisites

This project is designed to be imported into a PLCopen-compatible development environment. The specific PLC hardware should support Structured Text programming and must have sufficient I/O to interface with all sensors and actuators.

## Import Instructions

1. Import the main XML file into your PLCopen-compatible development environment
2. Verify that all Structured Text files are properly linked
3. Configure hardware-specific I/O mapping according to your installation
4. Set up appropriate HMI screens for operator interaction
5. Adjust setpoints for your specific process requirements
```


## Global_Variables.st

Source: `./src/Global/Global_Variables.st`

```
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
```


## StateAirScour.st

Source: `./src/POUs/StateAirScour.st`

```
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
```


## StateBackwashBottom.st

Source: `./src/POUs/StateBackwashBottom.st`

```
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
```


## StateBackwashTop.st

Source: `./src/POUs/StateBackwashTop.st`

```
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
```


## StateCEB.st

Source: `./src/POUs/StateCEB.st`

```
FUNCTION_BLOCK StateCEB
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
    StateTimer : TIME;
    InTransition : BOOL;
    
    // Setpoints
    CEBSoakTimeSetpoint : TIME;
    BackwashTopTimeSetpoint : TIME;
    BackwashBottomTimeSetpoint : TIME;
    ForwardFlushTimeSetpoint : TIME;
END_VAR

VAR
    CEBStep : INT := 0;
    TON_CEBTimer : TON;
END_VAR

VAR_INPUT
    Start : BOOL;
    Stop : BOOL;
END_VAR

VAR_OUTPUT
    Done : BOOL;
    Running : BOOL;
END_VAR

// CEB Step Machine
CASE CEBStep OF
    0: // Initialize
        IF Start THEN
            Running := TRUE;
            Done := FALSE;
            CEBStep := 1;
            
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
            
            // Prepare chemical injection
            ChemicalInjectionValve := TRUE;
        END_IF;
        
    1: // Chemical injection and backwash
        // Start backwash pump
        BackwashPump := TRUE;
        FeedPump := FALSE;
        CIPPump := FALSE;
        
        // Set up for backwash with chemicals
        BackwashTopValve := TRUE;
        ConcentrateValve := TRUE;
        ChemicalInjectionValve := TRUE;
        
        // Close other valves
        FeedInletValve := FALSE;
        FiltrateOutletValve := FALSE;
        BackwashBottomValve := FALSE;
        AirScourValve := FALSE;
        CIPInValve := FALSE;
        CIPOutValve := FALSE;
        
        // Start timer for chemical soak
        TON_CEBTimer(IN := TRUE, PT := CEBSoakTimeSetpoint);
        
        // Move to next step when timer completes
        IF TON_CEBTimer.Q THEN
            TON_CEBTimer(IN := FALSE);
            CEBStep := 2;
        END_IF;
        
    2: // Normal backwash sequence after chemical soak
        // Turn off chemical injection valve
        ChemicalInjectionValve := FALSE;
        
        // Set next state to Backwash Top
        PreviousState := CurrentState;
        CurrentState := 4; // Backwash Top
        StateTimer := BackwashTopTimeSetpoint;
        InTransition := TRUE;
        CEBStep := 3;
        
    3: // Wait for backwash sequence to complete
        // In this step, we allow the regular state machine to handle
        // the backwash sequence through ForwardFlush
        
        // We check if we've reached filtration again
        IF CurrentState = 1 THEN
            // CEB process is complete
            CEBStep := 4;
        END_IF;
        
    4: // Complete
        Running := FALSE;
        Done := TRUE;
        CEBStep := 0;
END_CASE;

IF Stop THEN
    CEBStep := 0;
    Running := FALSE;
    Done := FALSE;
    TON_CEBTimer(IN := FALSE);
END_IF;

END_FUNCTION_BLOCK 
```


## StateCIP.st

Source: `./src/POUs/StateCIP.st`

```
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
```


## StateFiltration.st

Source: `./src/POUs/StateFiltration.st`

```
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
```


## StateForwardFlush.st

Source: `./src/POUs/StateForwardFlush.st`

```
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
```


## StateGravityDrain.st

Source: `./src/POUs/StateGravityDrain.st`

```
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
```


## StateIdle.st

Source: `./src/POUs/StateIdle.st`

```
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
```


## UltrafiltrationMain.st

Source: `./src/POUs/UltrafiltrationMain.st`

```
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
```


