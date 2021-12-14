% Runfile: Minimal Brain PBPK Model for Antibody Therapeutics

close all
clear all

% Model Inputs
    NumDoses = 1;               % Number of Doses (-)
    Frequency = 100;            % Dosing Interval/Frequency (h)
    DoseIVmgkg = [10 50 100];            % Dose Intravenous (mg/kg)
    BodyWeight = 0.28;          % Body Weight (kg)
    MolecularWeight= 150;       % Molecular Weight (kDa)
    p = parameters_rat_mPBPKv2;   % Set Parameter File
    Stepsize = 0.01;               % DiffEq Solver Stepsize
        
% Calculations: 
    DoseIV = BodyWeight * DoseIVmgkg / MolecularWeight * 1000;  % Dose: mg/kg to nmol

% Execute Model
    for i = 1:size(DoseIV,2)
        [t,y,Conc(i)] = mPBPKv2(DoseIV(i),Frequency,NumDoses,Stepsize,p);
    end

% Figures
    PeterColorMap = [1, 0.06, 0.06; 0.25, 1, 0.06; 0.06, 0.25, 1];
    set(0,'DefaultAxesColorOrder',PeterColorMap);

    % PK Predictions
        figure(100)
            hold on
            semilogy(t, Conc(1).Plasma, t, Conc(2).Plasma, t, Conc(3).Plasma, 'LineWidth', 1.5)
            hold off
            title('Antibody Serum PK in Rats', 'FontWeight','bold');
            xlabel('Time (h)'); ylabel('Antibody Serum Concentration (nM)');
            set(gca,'FontSize',12,'FontWeight','bold','YMinorTick','on','YScale','log','YLim',[100,100000],'XLim',[0,100]);
            xticklabels({0:10:100});
            xticks([0:10:100]);
            legend({'1 mg/kg','10 mg/kg','100 mg/kg'},'Location', 'best');
            grid

    % PK Predictions
        figure(101)
            hold on
            semilogy(t, Conc(1).BrainCSF, t, Conc(2).BrainCSF, t, Conc(3).BrainCSF, 'LineWidth', 1.5)
            hold off
            title('Antibody CSF PK in Rats', 'FontWeight', 'bold');
            xlabel('Time (h)'); ylabel('Antibody CSF Concentration (nM)');
            set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'YMinorTick', 'on', 'YScale', 'log', 'YLim', [0.1, 1000], 'XLim', [0, 100]);
            xticklabels({0:10:100});
            xticks([0:10:100]);
            legend({'1 mg/kg', '10 mg/kg', '100 mg/kg'}, 'Location', 'best');
            grid

    % PK Predictions
        figure(102)
            hold on
            semilogy(t, Conc(1).BrainISF, t, Conc(2).BrainISF, t, Conc(3).BrainISF, 'LineWidth', 1.5)
            hold off
            title('Antibody ISF PK in Rats', 'FontWeight', 'bold');
            xlabel('Time (h)'); ylabel('Antibody ISF Concentration (nM)');
            set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'YMinorTick', 'on', 'YScale', 'log', 'YLim', [0.1, 1000], 'XLim', [0, 100]);
            xticklabels({0:10:100});
            xticks([0:10:100]);
            legend({'1 mg/kg', '10 mg/kg', '100 mg/kg'}, 'Location', 'best');
            grid
                