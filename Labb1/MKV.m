%{
a).
T(t) = c1 + c2 + c3*sin(w*(t-ts))
T(t) = c1 + c2 + c3*cos(w*ts)*sin(w*t) - c3*sin(w*ts)*cos(w*t)

  c3*sin(w*(t-ts))
= c3*sin(w*t - w*ts)
= c3*(sin(w*t)cos(w*ts) - cos(w*t)*sin(w*ts))
= c3*cos(w*ts)*sin(w*ts) - sin(w*ts)*cos(w*t)

v.s.v
T(t) = c1 + c2 + c3*sin(w*(t-ts))
    ==
T(t) = c1 + c2 + c3*cos(w*ts)*sin(w*t) - c3*sin(w*ts)*cos(w*t)
%}

% b).
load STHLMARLANDA2023.mat

% constant w
w = 2*pi / (365*24);

Tori = @(c, t, ts) c(1) + c(2)*t + c(3)*sin(w*(t-ts));
Tnew = @(c, t, ts) c(1) + c(2)*t + c(3)*cos(w*ts)*sin(w*t) - c(3)*sin(w*ts)*cos(w*t);

t = [0:size(Td)-1]';
A = [ones(size(t)), t, sin(w*t), cos(w*t)];

% c(3) = A0, c(4) = A1
calc = A\ Td;

%amplitud
c3 = sqrt(calc(3)^2 + calc(4)^2)

%ts
% calc(3) = c3*cos(w*ts)
% acos(calc(3)/c3) = w*ts
% acos(calc(3)/c3) / w = ts
ts = acos(calc(3)/ -c3) / w

c = [calc(1), calc(2), c3]';

% c).
Tmod = Tnew(c, t, ts);
res = norm(Td-Tmod)^2

hold on 
plot(t, Td, '.')
plot(t, Tori(c, t, ts))
plot(t, Tmod)

% d). Nej?

