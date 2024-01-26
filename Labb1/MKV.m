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

% calc(3) = A0, calc(4) = A1
calc = A\Td;

%amplitud
% calc(3)^2 + calc(4)^2 = c3^2
c3 = sqrt(calc(3)^2 + calc(4)^2)

%ts
% calc(3) = c3*cos(w*ts)
% acos(calc(3)/c3) = w*ts
% acos(calc(3)/c3) / w = ts
ts = acos(calc(3)/ c3) / w
% calc(4) = -c3*sin(pi - w*ts)
% asin(calc(4) / -c3) = pi - w*ts
% (pi - asin(calc(4) / -c3)) / w = ts
ts1 = (pi - asin(calc(4) / -c3)) / w

c = [calc(1), calc(2), c3]';

% c).
Tmod = Tnew(c, t, ts);
res = norm(Td-Tmod)

hold on 
plot(t, Td, '.')
plot(t, Tori(c, t, ts))
plot(t, Tmod)

% d). Ja, eftersom c2 är ökningen och det är 9.88929693482059e-07 är det en
% liten ökning.


