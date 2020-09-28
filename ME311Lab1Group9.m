%% Data Input
%Setup
thickness = 6.1E-3 * 39.3701; % Thickness (m->in)
width = 18.24E-3 * 39.3701; % Width (m->in)
area = thickness*width; % Area (in2)

%Import and Sort Data
rawdata = readmatrix('LAB1DATA.xlsx', 'Range', 'A2:E27'); % folder-dependent

force = rawdata(:,1) ; % Force F (lb -> N)
long_strain = rawdata(:,2).*(10^-6) ; % epsilon_long (micro -> base)
trans_strain = rawdata(:,3).*(10^-6) ; % epsilon_trans (micro -> base)
ang1_strain = rawdata(:,4).*(10^-6) ; % gamma_1 (micro -> base)
ang2_strain = rawdata(:,5).*(10^-6) ; % gamme_2 (micro -> base)

%% Preliminary Computations

N = length(force) ;

long_stress = force./area ; % sigma_long


%% (1) Young's Modulus
% (a) Statistical Mean
E = long_stress ./ long_strain ; % values of E from every datapoint

E_mean = (1/N) * sum(abs(E)) ; % Statistical Mean of Young's Modulus (psi)
E_mean_ksi = E_mean / (10^3) ; % Statistical Mean of Young's Modulus (ksi)

% (b) Linear Regression
E_LR = ( N*sum(long_stress.*long_strain) - sum(long_stress)*sum(long_strain) ) / ( N*sum(long_strain.^2) - sum(long_strain)^2 ) ; % Linear Regression for E (psi)
E_LR_ksi = E_LR / (10^3) ; % Linear Regression for E (ksi)
long_zero_offset_stress = (sum(long_stress)*sum(long_strain.^2)-sum(long_stress)*sum(long_stress.*long_strain))/(N*sum(long_strain.^2)-(sum(long_strain))^2) ; %Linear Regression Zero Offset Stress

%% (2) Poissons Ratio
% (a) Statistical Mean
nu=1/N*sum(abs(trans_strain./long_strain)); % Statistical Mean Poisson's Ratio

%(b) Linear Regression
nu_LR=(sum(trans_strain)*sum(long_strain)-N*(sum(long_strain.*trans_strain)))/(N*sum(long_strain.*2)-(sum(long_strain))^2) ; %Linear Regression for Poisson's Ratio
zero_offset_trans_strain=(sum(trans_strain)*sum(long_strain.^2)-sum(long_strain.*trans_strain))/(N*sum(long_strain.^2)-(sum(long_strain))^2); %Linear Regression For Zero Offset Transverse Strain
