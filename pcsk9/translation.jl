using ModelingToolkit, OrdinaryDiffEq, GlobalSensitivity, IfElse, PumasQSP

function SREBP2_reg(SREBP2,Vmax_up, Km_up, Vmax_down, Km_down)
    In = IfElse.ifelse(SREBP2 >= 1,(SREBP2-1), (1-SREBP2)) 
    Yout =  IfElse.ifelse(SREBP2 >= 1, 1 + (Vmax_up-1) * In / (In + (Km_up-1)), 1 - Vmax_down * In / (In + Km_down))
    return Yout
end

function transform(Xin,Yrange,Xic50, Xrange=3, Xscale = "log")
    #; % default is log
    if Xscale == "log"
        expT=3.97865*Xrange^-0.995  #% This is fitted to give 99% output at the extreme of the range specified
        Yout=( Yrange[2] - Yrange[1] ) * (Xin^expT/(Xin^expT+Xic50^expT)) + Yrange[1]
    elseif Xscale == "lin"
        Xmin=Xic50-Xrange/2
        Xmax=Xic50+Xrange/2
        expT=3.97865*2^-0.995 # % optimized for range of -1 to 1;
        Xmod=10^( 2*(Xin-Xmin)/(Xmax-Xmin) -1 )
        Xmodic50=10^( 2*(Xic50-Xmin)/(Xmax-Xmin) -1 )
        Yout=( Yrange[2] - Yrange[1] ) * (Xmod^expT/(Xmod^expT+Xmodic50^expT)) + Yrange[1]
    end
end

@parameters LDLparticleCE circ_volume clearance_hepatic_fraction baseline_hepatic_cholesterol maxSREBP2level minSREBP2level LDLcClearanceRate deciliter_to_liter dilipidemic_index PK_Ka PK_Kel_F  PK_V2_F PK_ComplexClearanceRate PK_kon PK_koff PK_V3 PK_Q Baselinepcsk9 LDLrIndClearanceRate AbsorptionFraction CholesterolIntakeDiet StatinEffectOnCholesterolSynthesis BaselineCholesterolSynthesisRate LDLparticleProdRate LossRate HDLcClearanceRate pcsk9SynthesisRate pcsk9_synthesis_Vm_up pcsk9_synthesis_Km_up pcsk9_synthesis_Vm_down pcsk9_synthesis_Km_down pcsk9ClearanceRate LDLr0 gamma LDLrSynthesis LDLr_expression_Vm_up LDLr_expression_Km_up LDLr_expression_Vm_down LDLr_expression_Km_down LDLrClearance pcsk9_on_LDLr pcsk9_on_LDLr_range SREBP2 circ_pcsk9_ngperml HDLch

p = [LDLparticleCE  =>  0.92
,circ_volume  => 5
,clearance_hepatic_fraction  => 0.8
,baseline_hepatic_cholesterol   => 6000
,maxSREBP2level  => 2
,minSREBP2level => 0
,LDLcClearanceRate =>0.187
,deciliter_to_liter => 10
,dilipidemic_index => 1
,PK_Ka  =>  0.247
,PK_Kel_F  => 0.0443
,PK_V2_F  =>  5640
,PK_ComplexClearanceRate => 0.182
,PK_kon  => 0.84 
,PK_koff  => 1.11
,PK_V3  => 3990
,PK_Q   => 615
,Baselinepcsk9  => 281.94
,LDLrIndClearanceRate => 0.02
,AbsorptionFraction => 0.5
,CholesterolIntakeDiet => 300
,StatinEffectOnCholesterolSynthesis => 1
,BaselineCholesterolSynthesisRate => 800
,LDLparticleProdRate => 0.03
,LossRate => 0.23
,HDLcClearanceRate => 0.3
,pcsk9SynthesisRate => 9.4488
,pcsk9_synthesis_Vm_up => 2
,pcsk9_synthesis_Km_up => 1.5
,pcsk9_synthesis_Vm_down => 0.7
,pcsk9_synthesis_Km_down => 0.5
,pcsk9ClearanceRate => 2.48
,LDLr0 => 1
,gamma => 0
,LDLrSynthesis => 0.5
,LDLr_expression_Vm_up => 3
,LDLr_expression_Km_up => 1.5
,LDLr_expression_Vm_down => 0.7
,LDLr_expression_Km_down => 0.5
,LDLrClearance => 0.5
,pcsk9_on_LDLr => 0.75
,pcsk9_on_LDLr_range => 650
,SREBP2 => 1
,circ_pcsk9_ngperml => 281.94
,HDLch => 50]

@variables t hepatic_cholesterol(t) LDLc(t) circ_pcsk9(t) surface_LDLr(t) antipcsk9(t) antipcsk9_dose(t) complex(t) peripheral(t)

u0 = [hepatic_cholesterol => 6000
,LDLc => 4000
,circ_pcsk9 => 3.81
,surface_LDLr => 1
,antipcsk9 => 0.0001
,antipcsk9_dose => 400000
,complex => 0
,peripheral => 0]

D = Differential(t)

SREBP2 = transform(hepatic_cholesterol, [maxSREBP2level, minSREBP2level], baseline_hepatic_cholesterol, 3)
circ_pcsk9_ngperml = circ_pcsk9 * 74
DietCholesterolAbsorption = AbsorptionFraction * CholesterolIntakeDiet
CholesterolSynthesis = BaselineCholesterolSynthesisRate* StatinEffectOnCholesterolSynthesis
LDLFormation = LDLparticleProdRate * hepatic_cholesterol* circ_volume * LDLparticleCE
LDLcleranceToHepatic = LDLcClearanceRate * dilipidemic_index *LDLc * surface_LDLr * clearance_hepatic_fraction
CholesterolLost = LossRate * hepatic_cholesterol
HDLclerance = HDLcClearanceRate * HDLch * circ_volume * deciliter_to_liter* clearance_hepatic_fraction
LDLcleranceToPeriphery = LDLcClearanceRate * dilipidemic_index * LDLc * (1- clearance_hepatic_fraction) *surface_LDLr
pcsk9_synthesis = pcsk9SynthesisRate * SREBP2_reg(SREBP2,pcsk9_synthesis_Vm_up,pcsk9_synthesis_Km_up,pcsk9_synthesis_Vm_down,pcsk9_synthesis_Km_down)
pcsk9_clearance = pcsk9ClearanceRate * circ_pcsk9 * (surface_LDLr / LDLr0)^gamma
LDLr_expression = LDLrSynthesis * SREBP2_reg(SREBP2, LDLr_expression_Vm_up, LDLr_expression_Km_up, LDLr_expression_Vm_down, LDLr_expression_Km_down)
LDLr_clearance = LDLrClearance * surface_LDLr * transform(circ_pcsk9_ngperml, [(1 - pcsk9_on_LDLr), (1 + pcsk9_on_LDLr)], Baselinepcsk9, pcsk9_on_LDLr_range,"lin")
absorption = ((PK_Ka * antipcsk9_dose / PK_V2_F) * (1000 / 150) )
binding = PK_kon * antipcsk9 * circ_pcsk9 - PK_koff * complex
antipcsk9_clearance = PK_Kel_F * antipcsk9
complex_clearance = PK_ComplexClearanceRate * complex
dose_compartment_clearance = PK_Ka * antipcsk9_dose
distribution = PK_Q / PK_V2_F * (antipcsk9 - peripheral)
redistribution = PK_Q / PK_V3 * (peripheral - antipcsk9)
LDLrIndependentCleranceToHepatic = LDLrIndClearanceRate * clearance_hepatic_fraction * LDLc
LDLrIndependentCleranceToPeriphery = LDLrIndClearanceRate * (1 - clearance_hepatic_fraction) * LDLc


eqs = [D(hepatic_cholesterol) ~ DietCholesterolAbsorption + CholesterolSynthesis - LDLFormation + LDLcleranceToHepatic - CholesterolLost + HDLclerance + LDLrIndependentCleranceToHepatic
    ,D(LDLc) ~ LDLFormation - LDLcleranceToHepatic - LDLcleranceToPeriphery - LDLrIndependentCleranceToHepatic - LDLrIndependentCleranceToPeriphery
    ,D(circ_pcsk9) ~ pcsk9_synthesis - pcsk9_clearance - binding
    ,D(surface_LDLr) ~ (LDLr_expression - LDLr_clearance)
    ,D(antipcsk9) ~ absorption - binding - antipcsk9_clearance - distribution
    ,D(antipcsk9_dose) ~ -dose_compartment_clearance
    ,D(complex) ~ binding - complex_clearance
    ,D(peripheral) ~ -redistribution]


@named sys = ODESystem(eqs, defaults = [u0; p])

tspan = (0.0,100.0)
prob = ODEProblem(sys,u0,tspan,p,jac=true)
sol = solve(prob,Tsit5())
tsteps = range(tspan[1], tspan[2], 1000)
trial = Trial(nothing, sys;
    tspan,
    saveat = tsteps,
    alg = Tsit5(),
    reduction = sol -> sol[150][2]
)

ub = getindex.(p, 2) .* 1.1
lb = getindex.(p, 2) .* 0.9
sens = QSPSensitivity(sys, [trial], parameter_space = [p[i][1] => [lb[i], ub[i]] for i in vcat(1:4,6:7,9:10)])
ms = gsa(sens, RegressionGSA(true);
    batch = false,
    N= 1000
)