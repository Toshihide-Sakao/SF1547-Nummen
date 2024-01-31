%{
a).
T(t) = c1 + c2 + c3*sin(w*(t-ts))
T(t) = c1 + c2 + c3*cos(w*ts)*sin(w*t) - c3*sin(w*ts)*cos(w*t)

  c3*sin(w*(t-ts))
= c3*sin(w*t - w*ts)
= c3*(sin(w*t)cos(w*ts) - cos(w*t)*sin(w*ts))
= c3*cos(w*ts)*sin(w*ts) - c3*sin(w*ts)*cos(w*t)

v.s.v
T(t) = c1 + c2 + c3*sin(w*(t-ts))
    ==
T(t) = c1 + c2 + c3*cos(w*ts)*sin(w*t) - c3*sin(w*ts)*cos(w*t)
%}

% b).
load STHLMARLANDA2023.mat

% constant w
w = 2*pi / (365*24);

% functions
Tori = @(c, t, ts) c(1) + c(2)*t + c(3)*sin(w*(t-ts));
Tnew = @(c, t, ts) c(1) + c(2)*t + c(3)*cos(w*ts)*sin(w*t) - c(3)*sin(w*ts)*cos(w*t);

t = [0:size(Td)-1]';                          % t is columnvector (nerråt) from 0 to size(Td) -1
A = [ones(size(t)), t, sin(w*t), cos(w*t)];   % matrix A

% matrix A =
% [
%   [1, t(1), sin(w*t(1)), cos(w*t(1))],
%   [1, t(2), sin(w*t(2)), cos(w*t(2))],
%   [1, t(3), sin(w*t(3)), cos(w*t(3))],
%   ...
% ]


% calc(3) = A0, calc(4) = A1
calc = A\Td;                                  % Solves A*calc = Td (calc and Td are vectors)

%amplitud
% calc(3)^2 + calc(4)^2 = c3^2
c3 = sqrt(calc(3)^2 + calc(4)^2)              % c3 is Amplitude

%ts
% calc(3) = c3*cos(w*ts)
% acos(calc(3)/c3) = w*ts
% acos(calc(3)/c3) / w = ts
ts = acos(calc(3)/ c3) / w                    % rätt
% calc(4) = -c3*sin(pi - w*ts)
% asin(calc(4) / -c3) = pi - w*ts
% (pi - asin(calc(4) / -c3)) / w = ts
ts1 = (pi - asin(calc(4) / -c3)) / w          % rätt
ts2 = asin(calc(4) / -c3) / w                 % fel
ts3 = acos(calc(3)/ c3) / -w                  % fel

% testning eh okej dont know
v0 = (ts) * w
v1 = (ts) * w
v2 = (ts) * w
v3 = (ts) * w

% fixar om c vektorn så den funkar för original function
c = [calc(1), calc(2), c3]';

% c).
Tmod = Tnew(c, t, ts);

% residualen
res = norm(Td-Tmod)

hold on
plot(t, Td, '.')
plot(t, Tori(c, t, ts))
plot(t, Tmod)

% d). Ja, eftersom c2 är ökningen och det är 9.88929693482059e-07 är det en
% liten ökning.


% Trigonometriska identititer
% sin(a + b) = sin(a) cos(b) + cos(a) sin(b)
% sin(a - b) = sin(a) cos(b) - cos(a) sin(b)
% cos(a + b) = cos(a) cos(b) - sin(a) sin(b)
% cos(a - b) = cos(a) cos(b) + sin(a) sin(b)

% sin(a) = cos(pi/2 - a)
% cos(a) = sin(pi/2 - a)

% sin(-x) = - sin(x)
% cos(-x) =   cos(x)

% sin(x) = sin(pi - x)
% cos(x) = cos(- x)

% sin(2*x) = 2*sin(x)cos(x)
% cos(2*x) = cos(x)^2 - sin(x)^2 = 1 - 2sin(x)^2 = 2cos(x)^2 - 1

% tan x = (sin x) / (cos x)