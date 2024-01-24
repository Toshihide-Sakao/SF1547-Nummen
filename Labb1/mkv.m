load STHLMARLANDA2023.mat

w = 2*pi / (365*24);

Tori = @(c, t, ts) c(1) + c(2)*t + c(3)*sin(w*(t-ts));
Tnew = @(c, t, ts) c(1) + c(2)*t + c(3)*cos(w*ts)*sin(w*t) - c(3)*sin(w*ts)*cos(w*t);

ts = 0
t = [0:size(Td)-1]';
A = [ones(size(t)), t, sin(w*t), cos(w*t)];

c = A\ Td

hold on 
plot(t, Td, '.')
plot(t, Tori(c, t, ts))
plot(t, Tnew(c, t, ts))
