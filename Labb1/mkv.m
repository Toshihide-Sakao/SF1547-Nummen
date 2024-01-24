load STHLMARLANDA2023.mat

T = @(c, t, ts) c(1) + c(2)*t + c(3)*cos(w*ts)*sin(w*t) - c(3)*sin(w*ts)*cos(w*t);

ettor = ones(size(x))
Td
