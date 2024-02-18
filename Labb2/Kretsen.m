% a). 
% L*q''(t) + R*q'(t) + (1/C)*q(t) = 0
% i(t) = q'(t)
% 
% q(0) = 1
% q'(0) = i(t) = 0
% 
% i'(t) = - (R*i(t) + (1/C)*q(t)) / L
% q'(t) = - (L*i'(t) + (1/C)*q(t)) / R
% q'(t) = - (1/C)*q(t) / R - (i(t) + (1/C)*q(t))

% y(t) = [q(t) i(t)]
% F(t, y) = - [(R*i(t) + (1/C)*q(t)) / L, (L*i'(t) + (1/C)*q(t)) / R]
% y0 = y(0) = [1, 0]

clear all

% F = @(t, y, R, L, C) - [(R*y(2, t) + (1/C)*y(1, t)) / L, (-(R*y(2, t)) + (1/C)*y(1, t) + (1/C)*y(1, t)) / R]
% F = @(t, y, R, L, C) - [(R*y(2) + (1/C)*y(1)) / L, (-(R*y(2)) + (1/C)*y(1) + (1/C)*y(1)) / R]'
F = @(t, y, R, L, C) - [(R*y(2) + (1/C)*y(1)) / L, - (1/C)*y(1) / R - (y(2) + (1/C)*y(1))]'
y0 = [1, 0]'

% c).
tSpan = [0 20]
[it, iy] = ode45(@(t, y) F(t, y, 1, 2, 0.5), tSpan, y0);
[iit, iiy] = ode45(@(t, y) F(t, y, 0, 2, 0.5), tSpan, y0)

figure()
hold on
plot(it, iy(:, 1), 'r')
plot(iit, iiy(:, 1), 'b')

hold off
