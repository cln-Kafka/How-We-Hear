% Analytical Solution 

sigma = 1/35; % ratio between the depth of the membrane and length of membrane

x = 0:0.0001:1; % mm
y = 0:0.0001:sigma; % mm
[X, Y] = meshgrid(x, y);
f = 7000; % input frequency 
omega = 2 * pi * f;

m_x = 0.15 * ones(1, length(x)); % mass (kg/cm^3), the mass for all points is the same
r_x = 200 * ones(1, length(x)); % damping (dyne*s/cm^3) 
k_x = 10^9 * exp(-2 * x); % stiffness (dyne/cm^3), the stiffness decreases as the distance increases 

z_x_omega = 1i * omega * m_x + r_x + k_x / (1i * omega); % impedance of the membrane for each point of the membrane ( Z = miW + r + k/iw )

n = 0:100;
m = n;
[N, M, X2] = meshgrid(n, m, x);
Z = permute(repmat(z_x_omega', 1, 101, 101), [3 2 1]);

[M2, X3] = meshgrid(x, m);
Z2 = repmat(z_x_omega, 101, 1);

alpha_nm = cosh(N(:,:,1) * pi * sigma) .* sum((cos(pi * N .* X2) .* cos(pi * M .* X2)) ./ Z, 3) + ...
    (1/4) * pi * N(:,:,1) .* (M(:,:,1) == N(:,:,1));
f_m = sum(X3 .* (1 - 1/2 * X3) .* cos(pi * M2 .* X3) ./ Z2, 2);
f_m(1) = f_m(1) + 1/2 * sigma;

An = inv(alpha_nm) * f_m;

sum_term = zeros(size(X));

third_term = zeros(size(X));
for i = 1:length(n)
    third_term = third_term + An(i) * cosh(i * pi * (sigma - Y)) .* cos(i * pi * X);
end
phi = X .* (1 - 1/2 * X) - sigma * Y .* (1 - 1/(2 * sigma) .* Y) + third_term;

t = 0.001:0.2:1;
phasor = exp(1i * omega * t);
i = 1;
phi_t = phi * phasor(i);  % the phasor form of the phi (flow potential)
disp = real(phi_t(1, :)) - real(phi_t(2, :));

% Plotting with enhanced styling
figure;
plot(disp, 'LineWidth', 2, 'Color', [0.4, 0.6, 0.8]);
xlabel('Distance from the oval window (in mm)', 'FontSize', 15, 'Color', 'k');
ylabel('Amplitude (in mm)', 'FontSize', 15, 'Color', 'k');
title('Membrane Response', 'FontSize', 18, 'Color', 'k');
grid on;
