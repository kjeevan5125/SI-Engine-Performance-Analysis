# Project 2 — Power Transmission System Design and Analysis

## Project Overview
Design and preliminary engineering analysis of a two-stage spur-gear speed reduction gearbox.

**Transmission:** Motor → Input Shaft → Gear Pair 1 → Intermediate Shaft → Gear Pair 2 → Output Shaft

### Design Basis
- Input power: 5.0 kW
- Input speed: 1440 rpm
- Output speed: 360 rpm
- Overall speed reduction: 4.0:1
- Gear type: 20° full-depth involute spur gears
- Stages: 2
- Stage ratio: 2:1 each
- Module: 4 mm
- Face width: 40 mm
- Tooth counts: 20/40 per stage
- Service factor: 1.5
- Assumed stage efficiency: 97%
- Overall estimated efficiency: 94.09%

## Main Results
| Parameter | Result |
|---|---:|
| Input torque | 33.16 N·m |
| Intermediate torque | 64.33 N·m |
| Output torque | 124.80 N·m |
| Design input torque | 49.74 N·m |
| Design intermediate torque | 96.49 N·m |
| Design output torque | 187.20 N·m |
| Stage 1 tangential load | 1243 N |
| Stage 2 tangential load | 2412 N |
| Stage 1 Lewis bending stress | 24.1 MPa |
| Stage 2 Lewis bending stress | 46.8 MPa |
| Gear contact ratio | 1.64 |
| Output power | 4.704 kW |
| Estimated total loss | 0.296 kW |

## Shaft Selection
- Input shaft: 25 mm
- Intermediate shaft: 35 mm
- Output shaft: 35 mm
- Preliminary bearing selection by bore: 6205 / 6307 / 6307

## Files
- `Project_2_Power_Transmission_Report.pdf` — engineering report
- `Project_2_Power_Transmission_Calculations.xlsx` — calculation workbook
- `Project_2_Power_Transmission_Analysis.m` — MATLAB verification script
- `Project_2_Gearbox_Layout.dxf` — AutoCAD-compatible 2D layout
- `README.md` — project documentation

## Methodology
Gear tooth sizing is screened using the Lewis bending equation. The gear geometry uses standard metric spur-gear relationships. Shaft sizing uses a conservative equivalent-twisting-moment approach.

This is a **preliminary academic/portfolio design**, not a certified production gearbox design. A production design would require full AGMA/ISO 6336 calculations, detailed material heat-treatment data, fatigue-life analysis, lubrication/thermal analysis, manufacturing tolerances, and validated bearing life calculations.
