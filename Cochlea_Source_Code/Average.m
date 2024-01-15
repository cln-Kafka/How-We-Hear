% Power Analysis
x = 0.5; % the determined distance
% the scaled range of distance variation ( 0 ---> 4 ) 
% 0 --> at the base (high frequency), whereas 4--> at the apex (low frequency)
syms A t;

% defining Neely parameters 
m_x = 0.15; % mass (kg/cm^3), the mass for all points is the same
r_x = 200; % damping (dyne*s/cm^3) 
k_x = 10^9 * exp(-2 * x); % stiffness (dyne/cm^3), the stiffness decreases as the distance increases 
F = 1; % dyne 
f = (0:1:12000); % range of frequency 
force = F * exp(1i * 2 * pi * f * t); % single input tone 
y = A * exp(1i * 2 * pi * f * t); % represents the displacement 
theta = atan(((m_x * 2 * pi * f) - (k_x ./ (2 * pi * f))) ./ r_x); % the phase of the impedance 

% the power equation 
P_numerator = F^2;
P_denominator = ((r_x)^2) + ((m_x * 2 * pi * f) - (k_x ./ (2 * pi * f))).^2; 
P_denom = 2 * sqrt(P_denominator);
P = (P_numerator ./ P_denom) .* cosd(theta);

% Plotting with enhanced styling
figure;
plot(f, P, 'LineWidth', 2, 'Color', [0.2, 0.4, 0.6]);
xlabel('Frequency (Hz)', 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Average Power (dyne-cm/s)', 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'k');
title('Power Analysis', 'FontSize', 18, 'FontWeight', 'bold', 'Color', 'k');
grid on;
