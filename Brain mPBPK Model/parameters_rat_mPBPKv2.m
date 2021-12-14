% Rat Parameters  

function p=parameters_rat_mPBPKv2

% Drug-Specific (or hybrid) Parameters
    p.Kdeg_IgG = 26.6;          % First order degradation rate constant of FcRn unbound mAb within the endosomal space (1/h)
    p.kCLUP = 0.55;             % Clearance uptake by the vascular endothelial cells via pinocytosis (L/h/L)
    p.BR_kCLUP = 0.03047;       % Clearance uptake in brain compartment (L/h/L)
    p.BR_BBB_RC = 1;            % Reflection coefficient at BBB
    p.BR_BCSFB_RC = 0.9974;     % Reflection coefficient at BCSFB

    % FcRn Parameters
        p.FcRn_Conc = 0.4982E-04;   % Concentration of FcRn in endosomal space (M)
        p.FcRn_Kon = 8E+08;         % Association rate constant between mAb-FcRn (1/M/h)
        p.FcRn_Koff = 144;          % Dissociation rate constant between mAb-FcRn and mAb- Antigen (1/h)
        p.FR = 0.715;               % Mab-p.FcRn.Conc fraction recycled to plasma space (-)
        p.BR_FR = 0.715;            % Mab-p.FcRn.Conc fraction recycled to plasma space in brain (-)
    
        
% Physiological Parameters 
    % Brain parameters
        p.BR_BBB_PSA = 0.0155;              % Brain surface area(m^2)
        p.BR_CP_PSA = 0.0025;               % Choroid plexus surface area(m^2)
        p.BR_BBB_BCSFB_FR = p.BR_BBB_PSA / (p.BR_CP_PSA + p.BR_BBB_PSA);    % The fraction of BBB and BCSFB
        p.BR_LV_TFV_FR = 0.5;               % The fraction of area of lateral ventricle (1-p.BR.LV.TFV.FR for thrid-forth ventricle)
        p.BR_EPCL_RC=0;                     % Reflection coefficient from intersitial space to ventricle space          
        p.BR_ISF_RC=0.2;                    % Reflection coefficient to lymph at intersitial space
        p.BR_SAS_RC=0.2;                    % Reflection coefficient to lymph at SAS 
        p.BR_SAS_ISF_RC=0;                  % Reflection coefficient from SAS to intersitial space

    % Volumes (L)

        p.plasma_volume=	0.00906015;
        p.bloodcell_volume=	0.00741285;

        p.lung_volume_vascular=	0.000231001;
        p.lung_volume_endosomal=	7.00003E-06;
        p.lung_volume_interstitial=	0.000263201;
        p.lung_volume_bloodcell=	0.000189001;
        p.lung_volume_cell=	0.000709803;

        p.heart_volume_vascular=	0.000039424;
        p.heart_volume_endosomal=	0.00000512;
        p.heart_volume_interstitial=	0.000146432;
        p.heart_volume_bloodcell=	0.000032256;
        p.heart_volume_cell=	0.000800768;

        p.kidney_volume_vascular=	0.00013244;
        p.kidney_volume_endosomal=	0.00001204;
        p.kidney_volume_interstitial=	0.0003612;
        p.kidney_volume_bloodcell=	0.00010836;
        p.kidney_volume_cell=	0.00179396;

        p.muscle_volume_vascular=	0.002675508;
        p.muscle_volume_endosomal=	0.00060807;
        p.muscle_volume_interstitial=	0.01580982;
        p.muscle_volume_bloodcell=	0.002189052;
        p.muscle_volume_cell=	0.10033155;

        p.skin_volume_vascular=	0.001865811;
        p.skin_volume_endosomal=	0.00024944;
        p.skin_volume_interstitial=	0.01646304;
        p.skin_volume_bloodcell=	0.001526573;
        p.skin_volume_cell=	0.029783136;

        %Brain
        p.brain_volume_vascular=	0.00005016;
        p.brain_volume_endosomal=	0.0000114;
        p.brain_volume_interstitial=	0.0004104;
        p.brain_volume_bloodcell=	0.00004104;
        p.brain_volume_cell=	0.001767;
        p.brain_volume_BBB = p.BR_BBB_BCSFB_FR*p.brain_volume_endosomal;
        p.brain_volume_BCSFB = (1-p.BR_BBB_BCSFB_FR)*p.brain_volume_endosomal;
        p.brain_volume_whole=p.brain_volume_vascular+p.brain_volume_endosomal+p.brain_volume_interstitial+p.brain_volume_bloodcell+p.brain_volume_cell;

        p.CSF_volume_Lventricle =0.00005;
        p.CSF_volume_TFventricle=0.00005;
        p.CSF_volume_cisterna=0.000017;
        p.CSF_volume_SAS=0.00018;
        p.CSF_volume_total=p.CSF_volume_Lventricle+p.CSF_volume_TFventricle+p.CSF_volume_cisterna+p.CSF_volume_SAS;

        p.adipose_volume_vascular=	0.000364221;
        p.adipose_volume_endosomal=	0.000165555;
        p.adipose_volume_interstitial=	0.00562887;
        p.adipose_volume_bloodcell=	0.000297999;
        p.adipose_volume_cell=	0.026654355;

        p.thymus_volume_vascular=	0.00000528;
        p.thymus_volume_endosomal=	0.00000048;
        p.thymus_volume_interstitial=	0.00001632;
        p.thymus_volume_bloodcell=	0.00000432;
        p.thymus_volume_cell=	0.0000696;

        p.Sintestine_volume_vascular=	7.95108E-05;
        p.Sintestine_volume_endosomal=	0.000024925;
        p.Sintestine_volume_interstitial=	0.00086739;
        p.Sintestine_volume_bloodcell=	6.50543E-05;
        p.Sintestine_volume_cell=	0.00394812;

        p.Lintestine_volume_vascular=	4.58403E-05;
        p.Lintestine_volume_endosomal=	0.00001437;
        p.Lintestine_volume_interstitial=	0.000500076;
        p.Lintestine_volume_bloodcell=	3.75057E-05;
        p.Lintestine_volume_cell=	0.002276208;

        p.spleen_volume_vascular=	0.000334928;
        p.spleen_volume_endosomal=	0.00001384;
        p.spleen_volume_interstitial=	0.0005536;
        p.spleen_volume_bloodcell=	0.000274032;
        p.spleen_volume_cell=	0.0015916;

        p.pancreas_volume_vascular=	0.000054725;
        p.pancreas_volume_endosomal=	0.000004975;
        p.pancreas_volume_interstitial=	0.00017313;
        p.pancreas_volume_bloodcell=	0.000044775;
        p.pancreas_volume_cell=	0.000717395;

        p.liver_volume_vascular=	0.001341153;
        p.liver_volume_endosomal=	0.00007866;
        p.liver_volume_interstitial=	0.002564316;
        p.liver_volume_bloodcell=	0.001097307;
        p.liver_volume_cell=	0.010650564;

        p.bone_volume_vascular=	0.000461714;
        p.bone_volume_endosomal=	0.000104935;
        p.bone_volume_interstitial=	0.003903582;
        p.bone_volume_bloodcell=	0.000377766;
        p.bone_volume_cell=	0.016139003;

        p.other_volume_vascular=	0.000255846;
        p.other_volume_endosomal=	0.00003047;
        p.other_volume_interstitial=	0.001044105;
        p.other_volume_bloodcell=	0.000209329;
        p.other_volume_cell=	0.004554249;

        p.lymph_volume=	0.001152;

    % Total Volumes (L)
        p.tissue_volume_vascular = p.lung_volume_vascular + p.heart_volume_vascular + p.kidney_volume_vascular...
            + p.muscle_volume_vascular + p.skin_volume_vascular + p.adipose_volume_vascular...
            + p.thymus_volume_vascular + p.Sintestine_volume_vascular + p.Lintestine_volume_vascular...
            + p.spleen_volume_vascular + p.pancreas_volume_vascular + p.liver_volume_vascular...
            + p.bone_volume_vascular + p.other_volume_vascular;

        p.tissue_volume_endosomal = p.lung_volume_endosomal + p.heart_volume_endosomal + p.kidney_volume_endosomal...
            + p.muscle_volume_endosomal + p.skin_volume_endosomal + p.adipose_volume_endosomal...
            + p.thymus_volume_endosomal + p.Sintestine_volume_endosomal + p.Lintestine_volume_endosomal...
            + p.spleen_volume_endosomal + p.pancreas_volume_endosomal + p.liver_volume_endosomal...
            + p.bone_volume_endosomal + p.other_volume_endosomal;

        p.tissue_volume_interstitial = p.lung_volume_interstitial + p.heart_volume_interstitial + p.kidney_volume_interstitial...
            + p.muscle_volume_interstitial + p.skin_volume_interstitial + p.adipose_volume_interstitial...
            + p.thymus_volume_interstitial + p.Sintestine_volume_interstitial + p.Lintestine_volume_interstitial...
            + p.spleen_volume_interstitial + p.pancreas_volume_interstitial + p.liver_volume_interstitial...
            + p.bone_volume_interstitial + p.other_volume_interstitial;

        p.tissue_volume_bloodcell = p.lung_volume_bloodcell + p.heart_volume_bloodcell + p.kidney_volume_bloodcell...
            + p.muscle_volume_bloodcell + p.skin_volume_bloodcell + p.adipose_volume_bloodcell...
            + p.thymus_volume_bloodcell + p.Sintestine_volume_bloodcell + p.Lintestine_volume_bloodcell...
            + p.spleen_volume_bloodcell + p.pancreas_volume_bloodcell + p.liver_volume_bloodcell...
            + p.bone_volume_bloodcell + p.other_volume_bloodcell;

        p.tissue_volume_cell = p.lung_volume_cell + p.heart_volume_cell + p.kidney_volume_cell...
            + p.muscle_volume_cell + p.skin_volume_cell + p.adipose_volume_cell...
            + p.thymus_volume_cell + p.Sintestine_volume_cell + p.Lintestine_volume_cell...
            + p.spleen_volume_cell + p.pancreas_volume_cell + p.liver_volume_cell...
            + p.bone_volume_cell + p.other_volume_cell;

        p.tissue_volume_total = p.tissue_volume_vascular + p.tissue_volume_endosomal...
            + p.tissue_volume_interstitial + p.tissue_volume_bloodcell + p.tissue_volume_cell;


        p.Total_Volume = p.plasma_volume + p.tissue_volume_vascular + p.tissue_volume_endosomal ...
            + p.tissue_volume_interstitial + p.brain_volume_vascular + p.brain_volume_endosomal ...
            + p.brain_volume_interstitial + p.CSF_volume_total + p.lymph_volume;

        p.Total_Volume_Brain = p.brain_volume_vascular + p.brain_volume_endosomal + p.brain_volume_interstitial ...
            + p.CSF_volume_total;


    % Flows (L/h)
        p.brain_flow_plasma=0.06534;
        p.CSF_flow_total=2.2*60*1e-6;
        p.ECF_flow_total=0.00003;
    
        p.lung_flow_plasma = 2.95;

        p.brain_flow_lymph=p.CSF_flow_total+p.ECF_flow_total; 

        p.tissue_flow_plasma = p.lung_flow_plasma - p.brain_flow_plasma;

        p.tissue_flow_lymph = p.tissue_flow_plasma * 0.002;

    % Reflection coefficients
        p.physiol_RC_tight=0.95;
        p.physiol_RC_medium=0.9;
        p.physiol_RC_loose=0.85;
        p.heart_RC_vascular=p.physiol_RC_tight;
        p.kidney_RC_vascular=p.physiol_RC_medium;
        p.muscle_RC_vascular=p.physiol_RC_tight;
        p.skin_RC_vascular=p.physiol_RC_tight;
        p.adipose_RC_vascular=p.physiol_RC_tight;
        p.thymus_RC_vascular=p.physiol_RC_medium;
        p.Sintestine_RC_vascular=p.physiol_RC_medium;
        p.Lintestine_RC_vascular=p.physiol_RC_tight;
        p.spleen_RC_vascular=p.physiol_RC_loose;
        p.pancreas_RC_vascular=p.physiol_RC_medium;
        p.liver_RC_vascular=p.physiol_RC_loose;
        p.bone_RC_vascular=p.physiol_RC_loose;
        p.other_RC_vascular=p.physiol_RC_tight;
        p.lung_RC_vascular=p.physiol_RC_tight;

        p.tissue_RC_vascular = (p.lung_RC_vascular*p.lung_volume_vascular...
            + p.heart_RC_vascular*p.heart_volume_vascular...
            + p.kidney_RC_vascular*p.kidney_volume_vascular...
            + p.muscle_RC_vascular*p.muscle_volume_vascular...
            + p.skin_RC_vascular*p.skin_volume_vascular...
            + p.adipose_RC_vascular*p.adipose_volume_vascular...
            + p.thymus_RC_vascular*p.thymus_volume_vascular...
            + p.Sintestine_RC_vascular*p.Sintestine_volume_vascular...
            + p.Lintestine_RC_vascular*p.Lintestine_volume_vascular...
            + p.spleen_RC_vascular*p.spleen_volume_vascular...
            + p.pancreas_RC_vascular*p.pancreas_volume_vascular...
            + p.liver_RC_vascular*p.liver_volume_vascular...
            + p.bone_RC_vascular*p.bone_volume_vascular...
            + p.other_RC_vascular*p.other_volume_vascular)/p.tissue_volume_vascular;

        p.tissue_RC_lymph = 0.2;



end