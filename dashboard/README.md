# Tableau Dashboard Build Guide

Use `patient_360_dashboard.csv` as the Tableau data source.

## Suggested KPI cards
- Total Patients
- Total Encounters
- Trauma Patients
- Burn Patients
- Total Claims
- Total Billed
- Total Paid
- Total Outstanding

## Suggested charts
1. Encounters by Facility
2. Claims by Status
3. Burn Patients by Severity
4. Trauma Patients by Trauma Level
5. Patient 360 detail table

## Suggested dashboard title
**Healthcare Patient 360 Dashboard**

## Story
This dashboard is the reporting layer built on top of the SQL transformation. The SQL controls the grain at one row per patient; Tableau then turns that trusted dataset into an analytical view.
