% Resonance Analysis
x = 0.5; % the determined distance
% the scaled range of distance variation ( 0 ---> 4 ) 
% 0 --> at the oval window (high frequency), whereas 4--> at the apex (low frequency)
syms A t;

% defining Neely parameters 
m_x = 0.15; % mass (kg/cm^3), the mass for all points is the same
r_x = 200; % damping (dyne*s/cm^3) 
k_x = 10^9 * exp(-2 * x); % stiffness (dyne/cm^3), the stiffness decreases as the distance increases 
F = 1; % dyne 
f = (0:1:12000); % range of frequency 
force = F * exp(1i * 2 * pi * f * t); % single input tone 
y = A * exp(1i * 2 * pi * f * t); % represents the displacement 

% the function to be plotted 
A_numerator = F / m_x;
A_denominator = ((4 * ((pi)^2) * (f.^2)) - (k_x / m_x)).^2 + (4 * ((pi)^2) * (f.^2) * ((r_x / m_x)^2));
A_denom = sqrt(A_denominator);
A_displacement = A_numerator ./ A_denom;

% Plotting with enhanced styling
figure;
plot(f, A_displacement, 'LineWidth', 2, 'Color', [0.4, 0.6, 0.8]);
xlabel('Frequency (Hz)', 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Amplitude of Displacement (mm)', 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'k');
title('Resonance Analysis', 'FontSize', 18, 'FontWeight', 'bold', 'Color', 'k');
grid on;
