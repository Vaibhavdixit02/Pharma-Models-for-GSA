Brain mPBPK model is available in MATLAB and SimBiology (MATLAB version 2020b).

MATLAB Files:
(1) mPBPKv2.m - Model equations and solver. This function requires inputs various inputs (e.g. dose) and outputs time/concentrations. Note that the equations are solved in units of M, whereas model outputs are in units of nM. 
(2) Run_mPBPKv2.m - Model executable file. This script calls the 'mPBPKv2' function. Model inputs need to be defined here and different parameter files can be called depending upon the species of interest.
(3) parameters_SPECIES_mPBPKv2.m - Model parameters, where SPECIES can be mouse, rat, monkey, and human.