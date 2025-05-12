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