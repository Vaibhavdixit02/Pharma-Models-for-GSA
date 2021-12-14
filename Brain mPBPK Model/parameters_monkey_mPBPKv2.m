% NHP Parameters  

function p=parameters_monkey_mPBPKv2

% Drug-Specific (or hybrid) Parameters
    p.Kdeg_IgG = 26.6;          % First order degradation rate constant of FcRn unbound mAb within the endosomal space (1/h)
    p.kCLUP = 0.55;             % Clearance uptake by the vascular endothelial cells via pinocytosis (L/h/L)
    p.BR_kCLUP = 0.03047;       % Clearance uptake in brain compartment (L/h/L)
    p.BR_BBB_RC = 1;            % Reflection coefficient at BBB
    p.BR_BCSFB_RC = 0.9974;     % Reflection coefficient at BCSFB
 
    % FcRn Parameters
        p.FcRn_Conc = 0.4982E-04;   % Concentration of FcRn in endosomal space (M)
        p.FcRn_Kon = 7.92E+08;      % Association rate constant between mAb-FcRn (1/M/h)
        p.FcRn_Koff = 46.8;         % Dissociation rate constant between mAb-FcRn and mAb- Antigen (1/h)
        p.FR = 0.715;               % Mab-p.FcRn.Conc fraction recycled to plasma space (-)
        p.BR_FR = 0.715;            % Mab-p.FcRn.Conc fraction recycled to plasma space in brain (-)


% Physiological Parameters 
    % Brain parameters
        %p.BR.BBB.PSA                       % (Unknown) Brain surface area(m^2)
        %p.BR.CP.PSA                        % (Unknown) Choroid plexus surface area(m^2)
        p.BR_BBB_BCSFB_FR = 0.9091;         % Calulated as "p.BR.BBB.PSA/(p.BR.CP.PSA+p.BR.BBB.PSA)"; % The fraction of BBB and BCSFB (scale from human)
        p.BR_LV_TFV_FR = 0.5;               % The fraction of area of lateral ventricle (1-p.BR.LV.TFV.FR for thrid-forth ventricle)
        p.BR_EPCL_RC=0;                     % Reflection coefficient from intersitial space to ventricle space          
        p.BR_ISF_RC=0.2;                    % Reflection coefficient to lymph at intersitial space
        p.BR_SAS_RC=0.2;                    % Reflection coefficient to lymph at SAS 
        p.BR_SAS_ISF_RC=0;                  % Reflection coefficient from SAS to intersitial space
        
    % Volumes (L) 

        p.plasma_volume=	0.186813;
        p.bloodcell_volume=	0.152847;

        p.lung_volume_vascular=	0.00196416;
        p.lung_volume_endosomal=	0.00017856;
        p.lung_volume_interstitial=	0.0107136;
        p.lung_volume_bloodcell=	0.00160704;
        p.lung_volume_cell=	0.02124864;

        p.heart_volume_vascular=	0.001090705;
        p.heart_volume_endosomal=	0.00014165;
        p.heart_volume_interstitial=	0.00405119;
        p.heart_volume_bloodcell=	0.000892395;
        p.heart_volume_cell=	0.02215406;

        p.kidney_volume_vascular=	0.00149875;
        p.kidney_volume_endosomal=	0.00013625;
        p.kidney_volume_interstitial=	0.0040875;
        p.kidney_volume_bloodcell=	0.00122625;
        p.kidney_volume_cell=	0.02030125;

        p.muscle_volume_vascular=	0.0720137;
        p.muscle_volume_endosomal=	0.01636675;
        p.muscle_volume_interstitial=	0.4255355;
        p.muscle_volume_bloodcell=	0.0589203;
        p.muscle_volume_cell=	2.70051375;

        p.skin_volume_vascular=	0.025221812;
        p.skin_volume_endosomal=	0.0033719;
        p.skin_volume_interstitial=	0.2225454;
        p.skin_volume_bloodcell=	0.020636028;
        p.skin_volume_cell=	0.40260486;

        %Brain
        p.brain_volume_vascular=	0.00206844;
        p.brain_volume_endosomal=	0.0004701;
        p.brain_volume_interstitial=	0.0169236;
        p.brain_volume_bloodcell=	0.00169236;
        p.brain_volume_cell=	0.0728655;
        p.brain_volume_BBB = p.BR_BBB_BCSFB_FR*p.brain_volume_endosomal;
        p.brain_volume_BCSFB = (1-p.BR_BBB_BCSFB_FR)*p.brain_volume_endosomal;
        p.brain_volume_whole=p.brain_volume_vascular+p.brain_volume_endosomal+p.brain_volume_interstitial+p.brain_volume_bloodcell+p.brain_volume_cell;

        p.CSF_volume_Lventricle =0.001463;
        p.CSF_volume_TFventricle=0.001463;
        p.CSF_volume_cisterna=0.000488;
        p.CSF_volume_SAS=0.00585;
        p.CSF_volume_total=p.CSF_volume_Lventricle+p.CSF_volume_TFventricle+p.CSF_volume_cisterna+p.CSF_volume_SAS;


        p.adipose_volume_vascular=	0.00169873;
        p.adipose_volume_endosomal=	0.00077215;
        p.adipose_volume_interstitial=	0.0262531;
        p.adipose_volume_bloodcell=	0.00138987;
        p.adipose_volume_cell=	0.12431615;

        p.thymus_volume_vascular=	0.00011495;
        p.thymus_volume_endosomal=	0.00001045;
        p.thymus_volume_interstitial=	0.0003553;
        p.thymus_volume_bloodcell=	0.00009405;
        p.thymus_volume_cell=	0.00151525;

        p.Sintestine_volume_vascular=	0.001574744;
        p.Sintestine_volume_endosomal=	0.00049365;
        p.Sintestine_volume_interstitial=	0.01717902;
        p.Sintestine_volume_bloodcell=	0.001288427;
        p.Sintestine_volume_cell=	0.07819416;

        p.Lintestine_volume_vascular=	0.002238184;
        p.Lintestine_volume_endosomal=	0.000701625;
        p.Lintestine_volume_interstitial=	0.02441655;
        p.Lintestine_volume_bloodcell=	0.001831241;
        p.Lintestine_volume_cell=	0.1111374;

        p.spleen_volume_vascular=	0.00071995;
        p.spleen_volume_endosomal=	0.00002975;
        p.spleen_volume_interstitial=	0.00119;
        p.spleen_volume_bloodcell=	0.00058905;
        p.spleen_volume_cell=	0.00342125;

        p.pancreas_volume_vascular=	0.00068475;
        p.pancreas_volume_endosomal=	0.00006225;
        p.pancreas_volume_interstitial=	0.0021663;
        p.pancreas_volume_bloodcell=	0.00056025;
        p.pancreas_volume_cell=	0.00897645;

        p.liver_volume_vascular=	0.015923848;
        p.liver_volume_endosomal=	0.00093395;
        p.liver_volume_interstitial=	0.037358;
        p.liver_volume_bloodcell=	0.013028603;
        p.liver_volume_cell=	0.1195456;

        p.bone_volume_vascular=	0.02094004;
        p.bone_volume_endosomal=	0.0047591;
        p.bone_volume_interstitial=	0.17703852;
        p.bone_volume_bloodcell=	0.01713276;
        p.bone_volume_cell=	0.73194958;

        p.other_volume_vascular=	0.005556914;
        p.other_volume_endosomal=	0.0006618;
        p.other_volume_interstitial=	0.02267768;
        p.other_volume_bloodcell=	0.004546566;
        p.other_volume_cell=	0.09891704;

        p.lymph_volume=	0.02506;

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

        p.tissue_volume_total = (p.tissue_volume_vascular + p.tissue_volume_endosomal...
            + p.tissue_volume_interstitial + p.tissue_volume_bloodcell + p.tissue_volume_cell);

        p.Total_Volume = p.plasma_volume + p.tissue_volume_vascular + p.tissue_volume_endosomal ...
            + p.tissue_volume_interstitial + p.brain_volume_vascular + p.brain_volume_endosomal ...
            + p.brain_volume_interstitial + p.CSF_volume_total + p.lymph_volume;

        p.Total_Volume_Brain = p.brain_volume_vascular + p.brain_volume_endosomal + p.brain_volume_interstitial ...
            + p.CSF_volume_total;

    % Flows (L/h)
        p.brain_flow_plasma=	1.5081;
        p.CSF_flow_total = 0.00246;  
        p.ECF_flow_total = 0.00123; 

        p.lung_flow_plasma=	22.4334;

        p.tissue_flow_plasma = (p.lung_flow_plasma - p.brain_flow_plasma);

        p.tissue_flow_lymph = p.tissue_flow_plasma * 0.002;

        p.brain_flow_lymph=p.CSF_flow_total+p.ECF_flow_total; 


    % Reflection coefficients (-)
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