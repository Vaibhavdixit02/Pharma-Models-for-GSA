% Minimal Brain PBPK Model: Equations and Solver 

function [t,y,Conc]=mPBPKv2(DoseIV,Frequency,NumDoses,Stepsize,p)

% Redefine Parameter Names for Equation Simplicity
    Kdeg = p.Kdeg_IgG;              % First order degradation rate of antibody in endosome (1/h)
    FR = p.FR;                      % Fraction of antibody recycled to plasma space (-)
    FR_B = p.BR_FR;                 % Fraction of antibody recycled to plasma space from brain (-)
    Kon_FcRn = p.FcRn_Kon;          % Association rate constant between antibody and FcRn (1/M/h)
    Koff_FcRn = p.FcRn_Koff;        % Dissociation rate constant of antibody_FcRn complex (1/M/h)
    kCLUP = p.kCLUP;                % Tissue clearance uptake rate by the vascular endothelial cells (1/h)
    BR_kCLUP = p.BR_kCLUP;          % Brain clearance uptake rate by the vascular endothelial cells (1/h)

    Vp = p.plasma_volume;                   % Plasma Volume (L)
    VTv = p.tissue_volume_vascular;         % Tissue Vascular Volume (L)
    VTe = p.tissue_volume_endosomal;        % Tissue Endosomal Volume (L)
    VTi = p.tissue_volume_interstitial;     % Tissue Interstitial Volume (L)
    VBv = p.brain_volume_vascular;          % Brain Vascualr Volume (L)
    VBe_BBB = p.brain_volume_BBB;           % Brain Endosomal Volume of BBB (L)
    VBe_BCSFB = p.brain_volume_BCSFB;       % Brain Endosomal Volume of BCSFB (L)
    VBi = p.brain_volume_interstitial;      % Brian Interstitial Volume (L)
    VCSF = p.CSF_volume_total ;             % Brain CSF Volume (L)
    VL = p.lymph_volume;                    % Lymph Volume
    VCSF_LV = p.CSF_volume_Lventricle;      % Lateral Ventricle CSF Volume (L)    
    VCSF_TFV = p.CSF_volume_TFventricle;    % Third + Fourth Ventricle CSF Volume (L) 
    VB_total = p.brain_volume_whole;        % Total Brain Volume (L) 

    QT = p.tissue_flow_plasma;      % Tissue Flow (L/h)
    QB = p.brain_flow_plasma;       % Brain Flow (L/h)
    LT = p.tissue_flow_lymph;       % Lymph Flow from Tissues (L/h)
    LB = p.brain_flow_lymph;        % Lymph Flow from Brain (L/h) * Note: LB = QB_ECF + QB_CSF
    QB_ECF = p.ECF_flow_total;      % Brain Interstitial Fluid (or Extracellular Fluid) Flow (L/h)
    QB_CSF = p.CSF_flow_total;      % Brain CSF Flow (L/h)

    RC_Tv = p.tissue_RC_vascular;   % Tissue Vascular Reflection Coefficient (-)
    RC_TL = p.tissue_RC_lymph;      % Tissue Lymphatic Reflection Coefficient (-)
    RC_BBB = p.BR_BBB_RC;           % BBB Reflection Coefficient (-)
    RC_BCSFB = p.BR_BCSFB_RC;       % BBB Reflection Coefficient (-)
    RC_B_ISF = p.BR_ISF_RC;         % ISF Glymphatic Reflection Coefficient (-)
    RC_B_CSF = p.BR_SAS_RC;         % CSF Glymphatic Reflection Coefficient (-)

    CLUP_T = p.kCLUP*p.tissue_volume_endosomal;                                     % Tissue clearance uptake by the vascular endothelial cells (L/h)
    CLUP_BCSFB = p.BR_kCLUP * p.brain_volume_endosomal * (1 - p.BR_BBB_BCSFB_FR);   % BCSFB clearance uptake by epithelial cells (L/h)
    CLUP_BBB = p.BR_kCLUP * p.brain_volume_endosomal * p.BR_BBB_BCSFB_FR;           % BBB clearance uptake by the vascular endothelial cells (L/h)
    CLUP_B = p.BR_kCLUP * p.brain_volume_endosomal;                                 % Total brain clearance uptake by the vascular endothelial cells (L/h)


%Introduce dose into the initial condition
    yIV=DoseIV/Vp/(1e9); %(Convert amount initial condition(nmol) to Conc (M))

% Set Initial Conditions
    yinitial = zeros(1,16);
    yinitial(1,14) = p.FcRn_Conc; % Tissue
    yinitial(1,15) = p.FcRn_Conc; % BBB
    yinitial(1,16) = p.FcRn_Conc; % BCSFB

 
% Differential Equation Solver
    t=[];
    y=[];
    for n=1:NumDoses
        yinitial=yinitial+[yIV, zeros(1,15)];
        tstart=(n-1)*Frequency;
        tend=n*Frequency;
        opts = odeset('RelTol',2.3e-14,'AbsTol',1e-22);
        [tint,yint]=ode15s(@modelODE,[tstart:Stepsize:tend],yinitial,opts,p);
        t=[t;tint];
        y=[y;yint];
        yinitial=y(end,:);
    end
 

% Model Output (nM)
    Conc.Plasma = y(:,1) * 1e9;         
    Conc.BrainISF = y(:,9) * 1e9;  
    Conc.BrainCSF = y(:,12) * 1e9;
    Conc.BrainHomo = (y(:,7) * VBe_BBB + y(:,8) * VBe_BBB + y(:,9) * VBi + y(:,10) * VBe_BCSFB + y(:,11) * VBe_BCSFB...
        + (y(:, 12) * (VCSF_LV + VCSF_TFV))) / (VB_total + VCSF_LV + VCSF_TFV) * 1e9;   % Note: For CSF, only the ventricles are in brain homogenate

  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
%           Model Equations         %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

function dydt = modelODE(t,y,p)

% Compartments
    C_P = y(1);
    C_T_V = y(2);
    C_T_E_U = y(3);
    C_T_E_B = y(4);
    C_T_I = y(5);
    C_B_V = y(6);
    C_B_EBBB_U = y(7);
    C_B_EBBB_B = y(8);
    C_B_I = y(9);
    C_B_EBCSFB_U = y(10);
    C_B_EBCSFB_B = y(11);
    C_B_CSF = y(12);
    C_L = y(13);
    C_T_FcRn_U = y(14);
    C_B_BBB_FcRn_U = y(15);
    C_B_BCSFB_FcRn_U = y(16);



%%%%% Differential Equations %%%%%

% Plasma
    % 1. Plasma
    dC_Pdt = ((QT - LT) * C_T_V + (QB - LB) * C_B_V + (LT + LB) * C_L - QT * C_P - QB * C_P) / Vp;

% Tissue
    % 2. Vascular
    dC_T_Vdt = (QT * C_P - (QT - LT) * C_T_V - ((1-RC_Tv) * LT * C_T_V) - CLUP_T * C_T_V + CLUP_T * FR * C_T_E_B) / VTv;

    % 3. Endosomal (Unbound)
    dC_T_E_Udt = CLUP_T * (C_T_V + C_T_I) / VTe - Kon_FcRn * C_T_E_U * C_T_FcRn_U + Koff_FcRn * C_T_E_B - Kdeg * C_T_E_U;

    % 4. Endosomal (Bound)
    dC_T_E_Bdt = Kon_FcRn * C_T_E_U * C_T_FcRn_U - Koff_FcRn * C_T_E_B - CLUP_T * C_T_E_B / VTe;

    % 5. Interstitial
    dC_T_Idt = (((1-RC_Tv) * LT * C_T_V) - ((1-RC_TL) * LT * C_T_I) + (CLUP_T * (1-FR) * C_T_E_B) - CLUP_T * C_T_I) / VTi;

% Brain
    % 6. Vascular
    dC_B_Vdt = (QB * C_P - (QB-LB) * C_B_V - ((1-RC_BBB) * QB_ECF * C_B_V) - ((1-RC_BCSFB) * QB_CSF * C_B_V)...
            - (CLUP_B * C_B_V) + (CLUP_BBB * FR_B * C_B_EBBB_B) + (CLUP_BCSFB * FR_B * C_B_EBCSFB_B)) / VBv;

    % 7. Endosomal BBB (Unbound)
    dC_B_EBBB_Udt = ((CLUP_BBB * (C_B_V + C_B_I)) / VBe_BBB) - Kon_FcRn * C_B_EBBB_U * C_B_BBB_FcRn_U + Koff_FcRn * C_B_EBBB_B - Kdeg * C_B_EBBB_U;

    % 8. Endosomal BBB (Bound)
    dC_B_EBBB_Bdt = Kon_FcRn * C_B_EBBB_U * C_B_BBB_FcRn_U - Koff_FcRn * C_B_EBBB_B - (CLUP_BBB * C_B_EBBB_B) / VBe_BBB;

    % 9. Interstitial (ISF)
    dC_B_Idt = (((1-RC_BBB) * QB_ECF * C_B_V) - ((1-RC_B_ISF) * QB_ECF * C_B_I) + (CLUP_BBB * (1-FR_B) * C_B_EBBB_B)...
            - (CLUP_BBB * C_B_I) - (QB_ECF * C_B_I) + (QB_ECF * C_B_CSF)) / VBi;

    % 10. Endosomal BCSFB (Unbound)
    dC_B_EBCSFB_Udt = (CLUP_BCSFB * C_B_V + CLUP_BCSFB * C_B_CSF) / VBe_BCSFB...
        - Kon_FcRn * C_B_EBCSFB_U * C_B_BCSFB_FcRn_U + Koff_FcRn * C_B_EBCSFB_B - Kdeg * C_B_EBCSFB_U;

    % 11. Endosomal BCSFB (Bound)
    dC_B_EBCSFB_Bdt = Kon_FcRn * C_B_EBCSFB_U * C_B_BCSFB_FcRn_U - (Koff_FcRn * C_B_EBCSFB_B) - ((CLUP_BCSFB * C_B_EBCSFB_B) / VBe_BCSFB);

    % 12. Cerebrospinal Fluid (CSF)
    dC_B_CSFdt = ((1-RC_BCSFB) * QB_CSF * C_B_V - (CLUP_BCSFB)  * C_B_CSF + (CLUP_BCSFB) * (1 - FR_B) * C_B_EBCSFB_B...
        + QB_ECF * C_B_I - (1-RC_B_CSF) * QB_CSF * C_B_CSF - QB_ECF * C_B_CSF) / VCSF;

    % 13. Lymph Node
    dC_Ldt = ((1-RC_TL) * LT * C_T_I + (1-RC_B_CSF) * (QB_CSF) * C_B_CSF + (1-RC_B_ISF) * QB_ECF * C_B_I - (LT+LB) * C_L) / VL;

% FcRn
    % 14. FcRn Tissue (Unbound)
    dC_T_FcRn_Udt = - Kon_FcRn * C_T_E_U * C_T_FcRn_U + Koff_FcRn * C_T_E_B + CLUP_T * C_T_E_B / VTe;

    % 15. FcRn BBB (Unbound)
    dC_B_BBB_FcRn_Udt = - Kon_FcRn * C_B_EBBB_U * C_B_BBB_FcRn_U + Koff_FcRn * C_B_EBBB_B + (CLUP_BBB * C_B_EBBB_B) / VBe_BBB;

    % 16. FcRn BCSFB (Unbound)
    dC_B_BCSFB_FcRn_Udt = - Kon_FcRn * C_B_EBCSFB_U * C_B_BCSFB_FcRn_U + Koff_FcRn * C_B_EBCSFB_B + CLUP_BCSFB * C_B_EBCSFB_B / VBe_BCSFB;

% dydt vector
    dydt = [dC_Pdt
    dC_T_Vdt
    dC_T_E_Udt
    dC_T_E_Bdt
    dC_T_Idt
    dC_B_Vdt
    dC_B_EBBB_Udt
    dC_B_EBBB_Bdt
    dC_B_Idt
    dC_B_EBCSFB_Udt
    dC_B_EBCSFB_Bdt
    dC_B_CSFdt
    dC_Ldt
    dC_T_FcRn_Udt
    dC_B_BBB_FcRn_Udt
    dC_B_BCSFB_FcRn_Udt
    ];

end  
end

