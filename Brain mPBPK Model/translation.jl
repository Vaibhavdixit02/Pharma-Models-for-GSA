using ModelingToolkit, OrdinaryDiffEq

p = Dict([      "Kdeg_IgG" => 26.6
          ,"kCLUP" => 0.55
          ,"BR_kCLUP" => 0.03047
          ,"BR_BBB_RC" => 1
          ,"BR_BCSFB_RC" => 0.9974
          ,"FcRn_Conc" => 0.4982E-04
          ,"FcRn_Kon" => 5.59E08
          ,"FcRn_Koff" => 23.85
          ,"FR" => 0.715
          ,"BR_FR" => 0.715
          ,"BR_BBB_PSA" => 17
          ,"BR_CP_PSA" => 1.7
          ,"BR_LV_TFV_FR" => 0.5
          ,"BR_EPCL_RC" => 0
          ,"BR_ISF_RC" => 0.2
          ,"BR_SAS_RC" => 0.2
          ,"BR_SAS_ISF_RC" => 0
          ,"plasma_volume" => 3.1258535
          ,"bloodcell_volume" => 2.5575165
          ,"lung_volume_vascular" => 0.055
          ,"lung_volume_endosomal" => 0.005
          ,"lung_volume_interstitial" => 0.3
          ,"lung_volume_bloodcell" => 0.045
          ,"lung_volume_cell" => 0.595
          ,"heart_volume_vascular" => 0.013141975
          ,"heart_volume_endosomal" => 0.00170675
          ,"heart_volume_interstitial" => 0.04881305
          ,"heart_volume_bloodcell" => 0.010752525
          ,"heart_volume_cell" => 0.2669357
          ,"kidney_volume_vascular" => 0.01824735
          ,"kidney_volume_endosomal" => 0.00165885
          ,"kidney_volume_interstitial" => 0.0497655
          ,"kidney_volume_bloodcell" => 0.01492965
          ,"kidney_volume_cell" => 0.24716865
          ,"muscle_volume_vascular" => 0.66172414
          ,"muscle_volume_endosomal" => 0.15039185
          ,"muscle_volume_interstitial" => 3.9101881
          ,"muscle_volume_bloodcell" => 0.54141066
          ,"muscle_volume_cell" => 24.81465525
          ,"skin_volume_vascular" => 0.127471916
          ,"skin_volume_endosomal" => 0.0170417
          ,"skin_volume_interstitial" => 1.1247522
          ,"skin_volume_bloodcell" => 0.104295204
          ,"skin_volume_cell" => 2.03477898
          ,"brain_volume_vascular" => 0.03189736
          ,"brain_volume_endosomal" => 0.0072494
          ,"brain_volume_interstitial" => 0.2609784
          ,"brain_volume_bloodcell" => 0.02609784
          ,"brain_volume_cell" => 1.123657
          ,"CSF_volume_Lventricle" => 0.0225
          ,"CSF_volume_TFventricle" => 0.0225
          ,"CSF_volume_cisterna" => 0.0075
          ,"CSF_volume_SAS" => 0.09
          ,"adipose_volume_vascular" => 0.14812006
          ,"adipose_volume_endosomal" => 0.0673273
          ,"adipose_volume_interstitial" => 2.2891282
          ,"adipose_volume_bloodcell" => 0.12118914
          ,"adipose_volume_cell" => 10.8396953
          ,"thymus_volume_vascular" => 0.00035255
          ,"thymus_volume_endosomal" => 0.00003205
          ,"thymus_volume_interstitial" => 0.0010897
          ,"thymus_volume_bloodcell" => 0.00028845
          ,"thymus_volume_cell" => 0.00464725
          ,"Sintestine_volume_vascular" => 0.006146492
          ,"Sintestine_volume_endosomal" => 0.0019268
          ,"Sintestine_volume_interstitial" => 0.06705264
          ,"Sintestine_volume_bloodcell" => 0.005028948
          ,"Sintestine_volume_cell" => 0.30520512
          ,"Lintestine_volume_vascular" => 0.008736214
          ,"Lintestine_volume_endosomal" => 0.002738625
          ,"Lintestine_volume_interstitial" => 0.09530415
          ,"Lintestine_volume_bloodcell" => 0.007147811
          ,"Lintestine_volume_cell" => 0.4337982
          ,"spleen_volume_vascular" => 0.02679545
          ,"spleen_volume_endosomal" => 0.00110725
          ,"spleen_volume_interstitial" => 0.04429
          ,"spleen_volume_bloodcell" => 0.02192355
          ,"spleen_volume_cell" => 0.12733375
          ,"pancreas_volume_vascular" => 0.0056969
          ,"pancreas_volume_endosomal" => 0.0005179
          ,"pancreas_volume_interstitial" => 0.01802292
          ,"pancreas_volume_bloodcell" => 0.0046611
          ,"pancreas_volume_cell" => 0.07468118
          ,"liver_volume_vascular" => 0.182669438
          ,"liver_volume_endosomal" => 0.01071375
          ,"liver_volume_interstitial" => 0.42855
          ,"liver_volume_bloodcell" => 0.149456813
          ,"liver_volume_cell" => 1.37136
          ,"bone_volume_vascular" => 0.22361966
          ,"bone_volume_endosomal" => 0.05082265
          ,"bone_volume_interstitial" => 1.89060258
          ,"bone_volume_bloodcell" => 0.18296154
          ,"bone_volume_cell" => 7.81652357
          ,"other_volume_vascular" => 0.203688439
          ,"other_volume_endosomal" => 0.02425825
          ,"other_volume_interstitial" => 0.831249367
          ,"other_volume_bloodcell" => 0.166654178
          ,"other_volume_cell" => 3.625799767
          ,"lymph_volume" => 0.27427
          ,"brain_flow_plasma" => 21.4533
          ,"CSF_flow_total" => 0.024 
          ,"ECF_flow_total" => 0.0105 
          ,"lung_flow_plasma" => 181.9125
          ,"physiol_RC_tight" => 0.95
          ,"physiol_RC_medium" => 0.9
          ,"physiol_RC_loose" => 0.85
          ,"tissue_RC_lymph" => 0.2
])


push!(p, "BR_BBB_BCSFB_FR" => p["BR_BBB_PSA"] / (p["BR_CP_PSA"] + p["BR_BBB_PSA"]))
push!(p,  "brain_volume_BBB" => p["BR_BBB_BCSFB_FR"]*p["brain_volume_endosomal"])
push!(p, "brain_volume_BCSFB" => (1-p["BR_BBB_BCSFB_FR"])*p["brain_volume_endosomal"])
push!(p, "brain_volume_whole" => p["brain_volume_vascular"]+ p["brain_volume_endosomal"]+p["brain_volume_interstitial"]+p["brain_volume_bloodcell"]+p["brain_volume_cell"])
push!(p, "CSF_volume_total" => p["CSF_volume_Lventricle"]+p["CSF_volume_TFventricle"]+p["CSF_volume_cisterna"]+p["CSF_volume_SAS"])
push!(p, "tissue_flow_plasma" => p["lung_flow_plasma"] - p["brain_flow_plasma"])
push!(p, "tissue_flow_lymph" => p["tissue_flow_plasma"] * 0.002)
push!(p, "brain_flow_lymph" => p["CSF_flow_total"] + p["ECF_flow_total"])
push!(p, "tissue_volume_vascular" => p["lung_volume_vascular"] + p["heart_volume_vascular"] + p["kidney_volume_vascular"] + p["muscle_volume_vascular"] + p["skin_volume_vascular"] + p["adipose_volume_vascular"] + p["thymus_volume_vascular"] + p["Sintestine_volume_vascular"] + p["Lintestine_volume_vascular"] + p["spleen_volume_vascular"] + p["pancreas_volume_vascular"] + p["liver_volume_vascular"] + p["bone_volume_vascular"] + p["other_volume_vascular"])
push!(p, "tissue_volume_endosomal" => p["lung_volume_endosomal"] + p["heart_volume_endosomal"] + p["kidney_volume_endosomal"] + p["muscle_volume_endosomal"] + p["skin_volume_endosomal"] + p["adipose_volume_endosomal"] + p["thymus_volume_endosomal"] + p["Sintestine_volume_endosomal"] + p["Lintestine_volume_endosomal"] + p["spleen_volume_endosomal"] + p["pancreas_volume_endosomal"] + p["liver_volume_endosomal"] + p["bone_volume_endosomal"] + p["other_volume_endosomal"])
push!(p, "tissue_volume_interstitial" => p["lung_volume_interstitial"] + p["heart_volume_interstitial"] + p["kidney_volume_interstitial"] + p["muscle_volume_interstitial"] + p["skin_volume_interstitial"] + p["adipose_volume_interstitial"] + p["thymus_volume_interstitial"] + p["Sintestine_volume_interstitial"] + p["Lintestine_volume_interstitial"] + p["spleen_volume_interstitial"] + p["pancreas_volume_interstitial"] + p["liver_volume_interstitial"] + p["bone_volume_interstitial"] + p["other_volume_interstitial"])
push!(p, "tissue_volume_bloodcell" => p["lung_volume_bloodcell"] + p["heart_volume_bloodcell"] + p["kidney_volume_bloodcell"] + p["muscle_volume_bloodcell"] + p["skin_volume_bloodcell"] + p["adipose_volume_bloodcell"] + p["thymus_volume_bloodcell"] + p["Sintestine_volume_bloodcell"] + p["Lintestine_volume_bloodcell"] + p["spleen_volume_bloodcell"] + p["pancreas_volume_bloodcell"] + p["liver_volume_bloodcell"] + p["bone_volume_bloodcell"] + p["other_volume_bloodcell"])
push!(p, "tissue_volume_cell" => p["lung_volume_cell"] + p["heart_volume_cell"] + p["kidney_volume_cell"] + p["muscle_volume_cell"] + p["skin_volume_cell"] + p["adipose_volume_cell"] + p["thymus_volume_cell"] + p["Sintestine_volume_cell"] + p["Lintestine_volume_cell"] + p["spleen_volume_cell"] + p["pancreas_volume_cell"] + p["liver_volume_cell"] + p["bone_volume_cell"] + p["other_volume_cell"])
push!(p, "tissue_volume_total" => p["tissue_volume_vascular"] + p["tissue_volume_endosomal"] + p["tissue_volume_interstitial"] + p["tissue_volume_bloodcell"] + p["tissue_volume_cell"])
push!(p, "Total_Volume" => p["plasma_volume"] + p["tissue_volume_vascular"] + p["tissue_volume_endosomal"] + p["tissue_volume_interstitial"] + p["brain_volume_vascular"] + p["brain_volume_endosomal"] + p["brain_volume_interstitial"] + p["CSF_volume_total"] + p["lymph_volume"])
push!(p, "Total_Volume_Brain" => p["brain_volume_vascular"] + p["brain_volume_endosomal"] + p["brain_volume_interstitial"] + p["CSF_volume_total"])
push!(p, "heart_RC_vascular" => p["physiol_RC_tight"])
push!(p, "kidney_RC_vascular" => p["physiol_RC_medium"])
push!(p, "muscle_RC_vascular" => p["physiol_RC_tight"])
push!(p, "skin_RC_vascular" => p["physiol_RC_tight"])
push!(p, "adipose_RC_vascular" => p["physiol_RC_tight"])
push!(p, "thymus_RC_vascular" => p["physiol_RC_medium"])
push!(p, "Sintestine_RC_vascular" => p["physiol_RC_medium"])
push!(p, "Lintestine_RC_vascular" => p["physiol_RC_tight"])
push!(p, "spleen_RC_vascular" => p["physiol_RC_loose"])
push!(p, "pancreas_RC_vascular" => p["physiol_RC_medium"])
push!(p, "liver_RC_vascular" => p["physiol_RC_loose"])
push!(p, "bone_RC_vascular" => p["physiol_RC_loose"])
push!(p, "other_RC_vascular" => p["physiol_RC_tight"])
push!(p, "lung_RC_vascular" => p["physiol_RC_tight"])
push!(p, "tissue_RC_vascular" => (p["lung_RC_vascular"] * p["lung_volume_vascular"] + p["heart_RC_vascular"] * p["heart_volume_vascular"] + p["kidney_RC_vascular"] * p["kidney_volume_vascular"] + p["muscle_RC_vascular"] * p["muscle_volume_vascular"] + p["skin_RC_vascular"] * p["skin_volume_vascular"] + p["adipose_RC_vascular"] * p["adipose_volume_vascular"] + p["thymus_RC_vascular"] * p["thymus_volume_vascular"] + p["Sintestine_RC_vascular"] * p["Sintestine_volume_vascular"] + p["Lintestine_RC_vascular"] * p["Lintestine_volume_vascular"] + p["spleen_RC_vascular"] * p["spleen_volume_vascular"] + p["pancreas_RC_vascular"] * p["pancreas_volume_vascular"] + p["liver_RC_vascular"] * p["liver_volume_vascular"] + p["bone_RC_vascular"] * p["bone_volume_vascular"] + p["other_RC_vascular"] * p["other_volume_vascular"]) / p["tissue_volume_vascular"])

@parameters t Kdeg FR FR_B Kon_FcRn Koff_FcRn kCLUP BR_kCLUP Vp VTv VTe VTi VBv VBe_BBB VBe_BCSFB VBi VCSF VL VCSF_LV VCSF_TFV VB_total QT QB LT LB QB_ECF QB_CSF RC_Tv RC_TL RC_BBB RC_BCSFB RC_B_ISF RC_B_CSF CLUP_T CLUP_BCSFB CLUP_BBB CLUP_B

param = [
 Kdeg => p["Kdeg_IgG"]
 FR => p["FR"]
 FR_B => p["BR_FR"]
 Kon_FcRn => p["FcRn_Kon"]
 Koff_FcRn => p["FcRn_Koff"]
 kCLUP => p["kCLUP"]
 BR_kCLUP => p["BR_kCLUP"]
 Vp => p["plasma_volume"]
 VTv => p["tissue_volume_vascular"]
 VTe => p["tissue_volume_endosomal"]
 VTi => p["tissue_volume_interstitial"]
 VBv => p["brain_volume_vascular"]
 VBe_BBB => p["brain_volume_BBB"]
 VBe_BCSFB => p["brain_volume_BCSFB"]
 VBi => p["brain_volume_interstitial"]
 VCSF => p["CSF_volume_total"]
 VL => p["lymph_volume"]
 VCSF_LV => p["CSF_volume_Lventricle"]
 VCSF_TFV => p["CSF_volume_TFventricle"]
 VB_total => p["brain_volume_whole"]
 QT => p["tissue_flow_plasma"]
 QB => p["brain_flow_plasma"]
 LT => p["tissue_flow_lymph"]
 LB => p["brain_flow_lymph"]
 QB_ECF => p["ECF_flow_total"]
 QB_CSF => p["CSF_flow_total"]
 RC_Tv => p["tissue_RC_vascular"]
 RC_TL => p["tissue_RC_lymph"]
 RC_BBB => p["BR_BBB_RC"]
 RC_BCSFB => p["BR_BCSFB_RC"]
 RC_B_ISF => p["BR_ISF_RC"]
 RC_B_CSF => p["BR_SAS_RC"]
 CLUP_T => p["kCLUP"]*p["tissue_volume_endosomal"]
 CLUP_BCSFB => p["BR_kCLUP"] * p["brain_volume_endosomal"] * (1 - p["BR_BBB_BCSFB_FR"])
 CLUP_BBB => p["BR_kCLUP"] * p["brain_volume_endosomal"] * p["BR_BBB_BCSFB_FR"]
 CLUP_B => p["BR_kCLUP"] * p["brain_volume_endosomal"]
]

@variables C_P(t) C_T_V(t) C_T_E_U(t) C_T_E_B(t) C_T_I(t) C_B_V(t) C_B_EBBB_U(t) C_B_EBBB_B(t) C_B_I(t) C_B_EBCSFB_U(t) C_B_EBCSFB_B(t) C_B_CSF(t) C_L(t) C_T_FcRn_U(t) C_B_BBB_FcRn_U(t) C_B_BCSFB_FcRn_U(t)

D = Differential(t)

u0 = [
  C_P => 10.0
 ,C_T_V => 0
 ,C_T_E_U => 0
 ,C_T_E_B => 0
 ,C_T_I => 0
 ,C_B_V => 0
 ,C_B_EBBB_U => 0
 ,C_B_EBBB_B => 0
 ,C_B_I => 0
 ,C_B_EBCSFB_U => 0
 ,C_B_EBCSFB_B => 0
 ,C_B_CSF => 0
 ,C_L => 0
 ,C_T_FcRn_U => p["FcRn_Conc"]
 ,C_B_BBB_FcRn_U => p["FcRn_Conc"]
 ,C_B_BCSFB_FcRn_U => p["FcRn_Conc"]
 ]

eqs = [
 # 1. Plasma
 D(C_P) ~ ((QT - LT) * C_T_V + (QB - LB) * C_B_V + (LT + LB) * C_L - QT * C_P - QB * C_P) / Vp
 # 2. Vascular
 D(C_T_V) ~ (QT * C_P - (QT - LT) * C_T_V - ((1-RC_Tv) * LT * C_T_V) - CLUP_T * C_T_V + CLUP_T * FR * C_T_E_B) / VTv
 # 3. Endosomal (Unbound)
 D(C_T_E_U) ~ CLUP_T * (C_T_V + C_T_I) / VTe - Kon_FcRn * C_T_E_U * C_T_FcRn_U + Koff_FcRn * C_T_E_B - Kdeg * C_T_E_U
 # 4. Endosomal (Bound)
 D(C_T_E_B) ~ Kon_FcRn * C_T_E_U * C_T_FcRn_U - Koff_FcRn * C_T_E_B - CLUP_T * C_T_E_B / VTe
 # 5. Interstitial
 D(C_T_I) ~ (((1-RC_Tv) * LT * C_T_V) - ((1-RC_TL) * LT * C_T_I) + (CLUP_T * (1-FR) * C_T_E_B) - CLUP_T * C_T_I) / VTi
 # 6. Vascular
 D(C_B_V) ~ (QB * C_P - (QB-LB) * C_B_V - ((1-RC_BBB) * QB_ECF * C_B_V) - ((1-RC_BCSFB) * QB_CSF * C_B_V) - (CLUP_B * C_B_V) + (CLUP_BBB * FR_B * C_B_EBBB_B) + (CLUP_BCSFB * FR_B * C_B_EBCSFB_B)) / VBv
 # 7. Endosomal BBB (Unbound)
 D(C_B_EBBB_U) ~ ((CLUP_BBB * (C_B_V + C_B_I)) / VBe_BBB) - Kon_FcRn * C_B_EBBB_U * C_B_BBB_FcRn_U + Koff_FcRn * C_B_EBBB_B - Kdeg * C_B_EBBB_U
 # 8. Endosomal BBB (Bound)
 D(C_B_EBBB_B) ~ Kon_FcRn * C_B_EBBB_U * C_B_BBB_FcRn_U - Koff_FcRn * C_B_EBBB_B - (CLUP_BBB * C_B_EBBB_B) / VBe_BBB
 # 9. Interstitial (ISF)
 D(C_B_I) ~ (((1-RC_BBB) * QB_ECF * C_B_V) - ((1-RC_B_ISF) * QB_ECF * C_B_I) + (CLUP_BBB * (1-FR_B) * C_B_EBBB_B) - (CLUP_BBB * C_B_I) - (QB_ECF * C_B_I) + (QB_ECF * C_B_CSF)) / VBi
 # 10. Endosomal BCSFB (Unbound)
 D(C_B_EBCSFB_U) ~ (CLUP_BCSFB * C_B_V + CLUP_BCSFB * C_B_CSF) / VBe_BCSFB - Kon_FcRn * C_B_EBCSFB_U * C_B_BCSFB_FcRn_U + Koff_FcRn * C_B_EBCSFB_B - Kdeg * C_B_EBCSFB_U
 # 11. Endosomal BCSFB (Bound)
 D(C_B_EBCSFB_B) ~ Kon_FcRn * C_B_EBCSFB_U * C_B_BCSFB_FcRn_U - (Koff_FcRn * C_B_EBCSFB_B) - ((CLUP_BCSFB * C_B_EBCSFB_B) / VBe_BCSFB)
 # 12. Cerebrospinal Fluid (CSF)
 D(C_B_CSF) ~ ((1-RC_BCSFB) * QB_CSF * C_B_V - (CLUP_BCSFB) * C_B_CSF + (CLUP_BCSFB) * (1 - FR_B) * C_B_EBCSFB_B + QB_ECF * C_B_I - (1-RC_B_CSF) * QB_CSF * C_B_CSF - QB_ECF * C_B_CSF) / VCSF
 # 13. Lymph Node
 D(C_L) ~ ((1-RC_TL) * LT * C_T_I + (1-RC_B_CSF) * (QB_CSF) * C_B_CSF + (1-RC_B_ISF) * QB_ECF * C_B_I - (LT+LB) * C_L) / VL
 # 14. FcRn Tissue (Unbound)
 D(C_T_FcRn_U) ~ - Kon_FcRn * C_T_E_U * C_T_FcRn_U + Koff_FcRn * C_T_E_B + CLUP_T * C_T_E_B / VTe
 # 15. FcRn BBB (Unbound)
 D(C_B_BBB_FcRn_U) ~ - Kon_FcRn * C_B_EBBB_U * C_B_BBB_FcRn_U + Koff_FcRn * C_B_EBBB_B + (CLUP_BBB * C_B_EBBB_B) / VBe_BBB
 # 16. FcRn BCSFB (Unbound)
 D(C_B_BCSFB_FcRn_U) ~ - Kon_FcRn * C_B_EBCSFB_U * C_B_BCSFB_FcRn_U + Koff_FcRn * C_B_EBCSFB_B + CLUP_BCSFB * C_B_EBCSFB_B / VBe_BCSFB
]

@named sys = ODESystem(eqs)

tspan = (0.0,100.0)
prob = ODEProblem(sys,u0,tspan,param)
sol = solve(prob,Tsit5())
