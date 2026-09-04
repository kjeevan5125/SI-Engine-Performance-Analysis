%% PROJECT 1: SI ENGINE PERFORMANCE ANALYSIS
% Performance Analysis of a SI Engine under Different Operating Conditions
% Modeled engineering study - representative data, not physical measurements.
%
% This MATLAB model independently reproduces the engineering calculations
% used in the Excel workbook and generates performance characteristic plots.

clear; clc; close all;

%% 1. ENGINE SPECIFICATIONS
nCyl = 4;                 % Number of cylinders
bore_mm = 80;             % Bore, mm
stroke_mm = 90;           % Stroke, mm
CR = 9.5;                 % Compression ratio
CV_MJkg = 44;             % Fuel calorific value, MJ/kg
rho_air = 1.184;          % Ambient air density, kg/m^3

bore = bore_mm/1000;      % Bore, m
stroke = stroke_mm/1000;  % Stroke, m

% Total engine displacement
Vd = (pi/4)*bore^2*stroke*nCyl;    % m^3
Vd_L = Vd*1000;                    % L

fprintf('=============================================\n');
fprintf(' SI ENGINE PERFORMANCE ANALYSIS\n');
fprintf('=============================================\n');
fprintf('Engine: %d-cylinder, 4-stroke SI\n', nCyl);
fprintf('Bore x Stroke: %.0f x %.0f mm\n', bore_mm, stroke_mm);
fprintf('Compression ratio: %.1f:1\n', CR);
fprintf('Displacement: %.4f L\n\n', Vd_L);

%% 2. REPRESENTATIVE OPERATING INPUT DATA
% Columns:
% RPM | Torque (N-m) | BSFC (g/kWh) | AFR
rpm = [1500 2000 2500 3000 3500 4000 4500 5000]';
torque = [65 82 92 98 100 98 94 88]';
bsfc = [330 295 275 265 270 280 295 315]';
afr = [14.5 14.5 14.4 14.3 14.2 14.0 13.8 13.6]';

%% 3. ENGINE PERFORMANCE CALCULATIONS

% Brake power:
% BP(kW) = 2*pi*N*T / 60000
brakePower_kW = (2*pi.*rpm.*torque)/60000;

% Fuel flow:
% BSFC is g/kWh, so divide by 1000 to obtain kg/h.
fuelFlow_kg_h = brakePower_kW .* bsfc / 1000;

% Air flow from AFR:
airFlow_kg_h = fuelFlow_kg_h .* afr;

% Brake thermal efficiency:
% BTE = Brake Power / Fuel energy input
% 1 kg/h of fuel at CV MJ/kg corresponds to CV/3.6 kW.
bte = brakePower_kW ./ ((fuelFlow_kg_h/3.6).*CV_MJkg) * 100;

% Volumetric efficiency for a 4-stroke engine:
% actual intake volume rate / theoretical displacement rate
% theoretical intake rate = Vd * RPM/(2*60)
volEff = (airFlow_kg_h/3600) ./ ...
         (rho_air .* Vd .* rpm/(2*60)) * 100;

%% 4. RESULTS TABLE
results = table(rpm, torque, brakePower_kW, bsfc, fuelFlow_kg_h, afr, ...
                airFlow_kg_h, bte, volEff, ...
    'VariableNames', {'RPM','Torque_Nm','BrakePower_kW','BSFC_g_kWh', ...
                      'FuelFlow_kg_h','AFR','AirFlow_kg_h', ...
                      'BTE_percent','VolumetricEfficiency_percent'});

disp(' ');
disp('PERFORMANCE RESULTS');
disp(results);

%% 5. IDENTIFY IMPORTANT OPERATING POINTS
[maxTorque, iTorque] = max(torque);
[maxPower, iPower] = max(brakePower_kW);
[minBSFC, iBSFC] = min(bsfc);
[maxBTE, iBTE] = max(bte);
[maxVolEff, iVolEff] = max(volEff);

fprintf('\n=============================================\n');
fprintf(' KEY PERFORMANCE RESULTS\n');
fprintf('=============================================\n');
fprintf('Maximum torque       : %.2f N-m at %d rpm\n', ...
    maxTorque, rpm(iTorque));
fprintf('Maximum brake power  : %.2f kW at %d rpm\n', ...
    maxPower, rpm(iPower));
fprintf('Minimum BSFC         : %.2f g/kWh at %d rpm\n', ...
    minBSFC, rpm(iBSFC));
fprintf('Maximum BTE           : %.2f %% at %d rpm\n', ...
    maxBTE, rpm(iBTE));
fprintf('Maximum volumetric efficiency: %.2f %% at %d rpm\n', ...
    maxVolEff, rpm(iVolEff));

%% 6. ENGINEERING CONSISTENCY CHECKS
% Displacement check
Vd_expected = (pi/4)*(bore_mm/1000)^2*(stroke_mm/1000)*nCyl;
dispError = abs(Vd - Vd_expected);

% Power positivity
powerCheck = all(brakePower_kW > 0);

% Efficiency limits
bteCheck = all(bte > 0 & bte < 100);
volEffCheck = all(volEff > 0 & volEff < 100);

% AFR positivity
afrCheck = all(afr > 0);

fprintf('\n=============================================\n');
fprintf(' ENGINEERING CHECKS\n');
fprintf('=============================================\n');
fprintf('Displacement consistency : %s (error = %.3e m^3)\n', ...
    passFail(dispError < 1e-12), dispError);
fprintf('Brake power positive     : %s\n', passFail(powerCheck));
fprintf('BTE within 0-100%%        : %s\n', passFail(bteCheck));
fprintf('Volumetric efficiency    : %s\n', passFail(volEffCheck));
fprintf('AFR values positive      : %s\n', passFail(afrCheck));

%% 7. PERFORMANCE PLOTS

% Torque vs RPM
figure('Name','Torque vs Engine Speed');
plot(rpm, torque, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('Engine Speed (rpm)');
ylabel('Torque (N-m)');
title('Torque vs Engine Speed');

% Brake Power vs RPM
figure('Name','Brake Power vs Engine Speed');
plot(rpm, brakePower_kW, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('Engine Speed (rpm)');
ylabel('Brake Power (kW)');
title('Brake Power vs Engine Speed');

% BSFC vs RPM
figure('Name','BSFC vs Engine Speed');
plot(rpm, bsfc, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('Engine Speed (rpm)');
ylabel('BSFC (g/kWh)');
title('BSFC vs Engine Speed');

% BTE vs RPM
figure('Name','Brake Thermal Efficiency vs Engine Speed');
plot(rpm, bte, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('Engine Speed (rpm)');
ylabel('Brake Thermal Efficiency (%)');
title('Brake Thermal Efficiency vs Engine Speed');

% AFR vs RPM
figure('Name','AFR vs Engine Speed');
plot(rpm, afr, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('Engine Speed (rpm)');
ylabel('Air-Fuel Ratio');
title('AFR vs Engine Speed');

% Volumetric efficiency vs RPM
figure('Name','Volumetric Efficiency vs Engine Speed');
plot(rpm, volEff, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('Engine Speed (rpm)');
ylabel('Volumetric Efficiency (%)');
title('Volumetric Efficiency vs Engine Speed');

%% 8. SAVE RESULTS
writetable(results, 'SI_Engine_Performance_Results.csv');
save('SI_Engine_Performance_Analysis.mat', ...
     'results','nCyl','bore_mm','stroke_mm','CR','CV_MJkg','rho_air','Vd');

fprintf('\nResults saved to:\n');
fprintf('  SI_Engine_Performance_Results.csv\n');
fprintf('  SI_Engine_Performance_Analysis.mat\n');

%% LOCAL FUNCTION
function status = passFail(condition)
    if condition
        status = 'PASS';
    else
        status = 'CHECK';
    end
end
