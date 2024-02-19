% a). 
% 
% r*T''(r) + T'(r) = 0
% T(1) = Ti = 450, r = 1
% k*T'(2) = -a(T-Te)
% (Tn+1 - Tn) / h = T'(2)
% Tn+1 / h - Tn / h = -a(T-Te) / k
% Tn+1 = -a*h*(Tn-Te) / k + Tn
% Tn+1 = -a*h*Tn/k + Tn = (-a*h/k + 1) * Tn 
% 
% (Tn+1 - 2Tn + Tn-1) /2h = T''(r)
% 
% 
% r*(Tn+1 - 2Tn + Tn-1) / h^2 + (Tn+1 - Tn-1) / 2h = 0
% (r/h^2 + 1/2h) * Tn+1 + (- 2/h^2) * Tn + (r/h^2 - 1/2h) * Tn-1 = 0
% 
% (r/h^2 + 1/2h) * Tn+1 + (- 2/h^2) * Tn + (r/h^2 - 1/2h) * Tn-1 = 0
% ((r/h^2 + 1/2h) * (-a*h/k + 1) + (- 2/h^2)) * Tn + (r/h^2 - 1/2h) * Tn-1 = 0
% 
% 
% 
% .

Ti = 450;
Te = 20;
N = 25;
r0 = 1; rN1 = 2;
u0 = Ti;
h =( xN1 - x0 ) / (N +1); % Steglangd
ri = [r0 + h:h: rN1 -h]';

A = zeros(N, N);

A(1, 1:2) = [-2/h^2, ri(1)/h^2 + 1/(2*h)]; % vid r = 1

for i = 2:N-1
    A(i, i - 1) = ri(i)/h^2 - 1/(2*h);
    A(i, i)     = -2/h^2;
    A(i, i + 1) = ri(i)/h^2 + 1/(2*h);
end

a = 1;
k = 1;

A(N, N-1:N) = [ri(N)/h^2 - 1/(2*h), ((ri(N)/h^2 + 1/2*h) * (-a*h/k + 1) + (- 2/h^2))]; % vid r = N

A = sparse(A);

b = zeros(N, 1);
b(1) = - u0*(ri(1)/h^2 - 1/(2*h));

u = A\b;

u(N)


