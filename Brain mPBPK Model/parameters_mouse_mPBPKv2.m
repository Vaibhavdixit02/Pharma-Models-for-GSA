% Mouse Parameters  

function p=parameters_mouse_mPBPKv2


% Drug-Specific (or hybrid) Parameters
    p.Kdeg_IgG = 26.6;          % First order degradation rate constant of FcRn unbound mAb within the endosomal space (1/h)
    p.kCLUP = 0.55;             % Clearance uptake by the vascular endothelial cells via pinocytosis (L/h/L)
    p.BR_kCLUP = 0.03047;       % Clearance uptake in brain compartment (L/h/L)
    p.BR_BBB_RC = 1;            % Reflection coefficient at BBB
    p.BR_BCSFB_RC = 0.9974;     % Reflection coefficient at BCSFB
  
    % FcRn Parameters
        p.FcRn_Conc = 0.4982E-04;   % Concentration of FcRn in endosomal space (M)
        p.FcRn_Kon = 8.06e+07;      % Association rate constant between mAb-FcRn (1/M/h)
        p.FcRn_Koff = 6.55;         % Dissociation rate constant between mAb-FcRn and mAb- Antigen (1/h)
        p.FR = 0.715;               % Mab-p.FcRn.Conc fraction recycled to plasma space (-)
        p.BR_FR = 0.715;            % Mab-p.FcRn.Conc fraction recycled to plasma space in brain (-)


% Physiological Parameters 
    % Brain parameters
        %p.BR.BBB.PSA                       % (Unknown) Brain surface area(m^2)
        %p.BR.CP.PSA                        % (Unknown) Choroid plexus surface area(m^2)
        p.BR_BBB_BCSFB_FR = 0.861111;       % Calulated as "p.BR.BBB.PSA/(p.BR.CP.PSA+p.BR.BBB.PSA)"; % The fraction of BBB and BCSFB
        p.BR_LV_TFV_FR = 0.5;               % The fraction of area of lateral ventricle (1-p.BR.LV.TFV.FR for thrid-forth ventricle)
        p.BR_EPCL_RC=0;                     % Reflection coefficient from intersitial space to ventricle space          
        p.BR_ISF_RC=0.2;                    % Reflection coefficient to lymph at intersitial space
        p.BR_SAS_RC=0.2;                    % Reflection coefficient to lymph at SAS 
        p.BR_SAS_ISF_RC=0;                  % Reflection coefficient from SAS to intersitial space

    % Volume (L) 

        p.plasma_volume=	0.00094435;
        p.bloodcell_volume=	0.00077265;

        p.lung_volume_vascular=	0.00002945509193;
        p.lung_volume_endosomal=	0.0000010220365;
        p.lung_volume_interstitial=	0.0000384285724;
        p.lung_volume_bloodcell=	0.00002409962067;
        p.lung_volume_cell=	0.000111402;

        p.heart_volume_vascular=	0.000005852;
        p.heart_volume_endosomal=	0.00000076;
        p.heart_volume_interstitial=	0.000021736;
        p.heart_volume_bloodcell=	0.000004788;
        p.heart_volume_cell=	0.000118864;

        p.kidney_volume_vascular=	0.000028875;
        p.kidney_volume_endosomal=	0.000002625;
        p.kidney_volume_interstitial=	0.00007875;
        p.kidney_volume_bloodcell=	0.000023625;
        p.kidney_volume_cell=	0.000391125;

        p.muscle_volume_vascular=	0.000249018;
        p.muscle_volume_endosomal=	0.000056595;
        p.muscle_volume_interstitial=	0.00147147;
        p.muscle_volume_bloodcell=	0.000203742;
        p.muscle_volume_cell=	0.009338175;

        p.skin_volume_vascular=	0.0001877106;
        p.skin_volume_endosomal=	0.000025095;
        p.skin_volume_interstitial=	0.00165627;
        p.skin_volume_bloodcell=	0.0001535814;
        p.skin_volume_cell=	0.002996343;

    % Brain
        p.brain_volume_vascular=	0.00001067;
        p.brain_volume_endosomal=	0.000002425;
        p.brain_volume_interstitial=	0.0000873;
        p.brain_volume_bloodcell=	0.00000873;
        p.brain_volume_cell=	0.000375875;
        p.brain_volume_BBB = p.BR_BBB_BCSFB_FR*p.brain_volume_endosomal;
        p.brain_volume_BCSFB = (1-p.BR_BBB_BCSFB_FR)*p.brain_volume_endosomal;
        p.brain_volume_whole=p.brain_volume_vascular+p.brain_volume_endosomal+p.brain_volume_interstitial+p.brain_volume_bloodcell+p.brain_volume_cell;

        p.CSF_volume_Lventricle =0.000004;
        p.CSF_volume_TFventricle=0.00000245;
        p.CSF_volume_cisterna=0.0000011;
        p.CSF_volume_SAS=0.0000117;
        p.CSF_volume_total=p.CSF_volume_Lventricle+p.CSF_volume_TFventricle+p.CSF_volume_cisterna+p.CSF_volume_SAS;

        p.adipose_volume_vascular=	0.000021802;
        p.adipose_volume_endosomal=	0.00000991;
        p.adipose_volume_interstitial=	0.00033694;
        p.adipose_volume_bloodcell=	0.000017838;
        p.adipose_volume_cell=	0.00159551;

        p.thymus_volume_vascular=	0.000000495;
        p.thymus_volume_endosomal=	0.000000045;
        p.thymus_volume_interstitial=	0.00000153;
        p.thymus_volume_bloodcell=	0.000000405;
        p.thymus_volume_cell=	0.000006525;

        p.Sintestine_volume_vascular=	0.0000116116;
        p.Sintestine_volume_endosomal=	0.00000364;
        p.Sintestine_volume_interstitial=	0.000126672;
        p.Sintestine_volume_bloodcell=	0.0000095004;
        p.Sintestine_volume_cell=	0.000576576;

        p.Lintestine_volume_vascular=	0.000005000325;
        p.Lintestine_volume_endosomal=	0.0000015675;
        p.Lintestine_volume_interstitial=	0.000054549;
        p.Lintestine_volume_bloodcell=	0.000004091175;
        p.Lintestine_volume_cell=	0.000248292;

        p.spleen_volume_vascular=	0.000015367;
        p.spleen_volume_endosomal=	0.000000635;
        p.spleen_volume_interstitial=	0.0000254;
        p.spleen_volume_bloodcell=	0.000012573;
        p.spleen_volume_cell=	0.000073025;

        p.pancreas_volume_vascular=	0.000005335;
        p.pancreas_volume_endosomal=	0.000000485;
        p.pancreas_volume_interstitial=	0.000016878;
        p.pancreas_volume_bloodcell=	0.000004365;
        p.pancreas_volume_cell=	0.000069937;

        p.liver_volume_vascular=	0.00016410625;
        p.liver_volume_endosomal=	0.000009625;
        p.liver_volume_interstitial=	0.000384595163;
        p.liver_volume_bloodcell=	0.00013426875;
        p.liver_volume_cell=	0.001232405;

        p.bone_volume_vascular=	0.000062128;
        p.bone_volume_endosomal=	0.00001412;
        p.bone_volume_interstitial=	0.000525264;
        p.bone_volume_bloodcell=	0.000050832;
        p.bone_volume_cell=	0.002171656;

        p.other_volume_vascular=	0.000019535609097;
        p.other_volume_endosomal=	0.000002326591;
        p.other_volume_interstitial=	0.0000797245183;
        p.other_volume_bloodcell=	0.0000159837;
        p.other_volume_cell=	0.000347748;

        p.lymph_volume = 0.000113;


    % Total Volumes (L)
        p.tissue_volume_vascular = p.lung_volume_vascular + p.heart_volume_vascular + p.kidney_volume_vascular ...
            + p.muscle_volume_vascular + p.skin_volume_vascular + p.adipose_volume_vascular ...
            + p.thymus_volume_vascular + p.Sintestine_volume_vascular + p.Lintestine_volume_vascular ...
            + p.spleen_volume_vascular + p.pancreas_volume_vascular + p.liver_volume_vascular ...
            + p.bone_volume_vascular + p.other_volume_vascular;

        p.tissue_volume_endosomal = p.lung_volume_endosomal + p.heart_volume_endosomal + p.kidney_volume_endosomal ...
            + p.muscle_volume_endosomal + p.skin_volume_endosomal + p.adipose_volume_endosomal ...
            + p.thymus_volume_endosomal + p.Sintestine_volume_endosomal + p.Lintestine_volume_endosomal ...
            + p.spleen_volume_endosomal + p.pancreas_volume_endosomal + p.liver_volume_endosomal ...
            + p.bone_volume_endosomal + p.other_volume_endosomal;

        p.tissue_volume_interstitial = p.lung_volume_interstitial + p.heart_volume_interstitial + p.kidney_volume_interstitial ...
            + p.muscle_volume_interstitial + p.skin_volume_interstitial + p.adipose_volume_interstitial ...
            + p.thymus_volume_interstitial + p.Sintestine_volume_interstitial + p.Lintestine_volume_interstitial ...
            + p.spleen_volume_interstitial + p.pancreas_volume_interstitial + p.liver_volume_interstitial ...
            + p.bone_volume_interstitial + p.other_volume_interstitial;

        p.tissue_volume_bloodcell = p.lung_volume_bloodcell + p.heart_volume_bloodcell + p.kidney_volume_bloodcell ...
            + p.muscle_volume_bloodcell + p.skin_volume_bloodcell + p.adipose_volume_bloodcell ...
            + p.thymus_volume_bloodcell + p.Sintestine_volume_bloodcell + p.Lintestine_volume_bloodcell ...
            + p.spleen_volume_bloodcell + p.pancreas_volume_bloodcell + p.liver_volume_bloodcell ...
            + p.bone_volume_bloodcell + p.other_volume_bloodcell;

        p.tissue_volume_cell = p.lung_volume_cell + p.heart_volume_cell + p.kidney_volume_cell ...
            + p.muscle_volume_cell + p.skin_volume_cell + p.adipose_volume_cell ...
            + p.thymus_volume_cell + p.Sintestine_volume_cell + p.Lintestine_volume_cell ...
            + p.spleen_volume_cell + p.pancreas_volume_cell + p.liver_volume_cell ...
            + p.bone_volume_cell + p.other_volume_cell;

        p.tissue_volume_total = (p.tissue_volume_vascular + p.tissue_volume_endosomal ...
            + p.tissue_volume_interstitial + p.tissue_volume_bloodcell + p.tissue_volume_cell);

        p.Total_Volume = p.plasma_volume + p.tissue_volume_vascular + p.tissue_volume_endosomal ...
            + p.tissue_volume_interstitial + p.brain_volume_vascular + p.brain_volume_endosomal ...
            + p.brain_volume_interstitial + p.CSF_volume_total + p.lymph_volume;

        p.Total_Volume_Brain = p.brain_volume_vascular + p.brain_volume_endosomal + p.brain_volume_interstitial ...
            + p.CSF_volume_total;


    % Flows (L/h) 
        p.brain_flow_plasma = 0.011781;
        p.CSF_flow_total = 0.0000198;
        p.ECF_flow_total = 0.0000018;

        p.lung_flow_plasma = 0.373131;

        p.tissue_flow_plasma = (p.lung_flow_plasma - p.brain_flow_plasma);

        p.tissue_flow_lymph = p.tissue_flow_plasma * 0.002;

        p.brain_flow_lymph = p.CSF_flow_total + p.ECF_flow_total;



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

        p.tissue_RC_vascular = (p.lung_RC_vascular * p.lung_volume_vascular ...
            + p.heart_RC_vascular * p.heart_volume_vascular ...
            + p.kidney_RC_vascular * p.kidney_volume_vascular ...
            + p.muscle_RC_vascular * p.muscle_volume_vascular ...
            + p.skin_RC_vascular * p.skin_volume_vascular ...
            + p.adipose_RC_vascular * p.adipose_volume_vascular ...
            + p.thymus_RC_vascular * p.thymus_volume_vascular ...
            + p.Sintestine_RC_vascular * p.Sintestine_volume_vascular ...
            + p.Lintestine_RC_vascular * p.Lintestine_volume_vascular ...
            + p.spleen_RC_vascular * p.spleen_volume_vascular ...
            + p.pancreas_RC_vascular * p.pancreas_volume_vascular ...
            + p.liver_RC_vascular * p.liver_volume_vascular ...
            + p.bone_RC_vascular * p.bone_volume_vascular ...
            + p.other_RC_vascular * p.other_volume_vascular) / p.tissue_volume_vascular;

        p.tissue_RC_lymph = 0.2;

end