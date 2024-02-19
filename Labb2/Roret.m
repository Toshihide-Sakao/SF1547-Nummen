% a). 
% r*T''(r) + T'(r) = 0
% T(1) = Ti = 450, r = 1
% 
% uppdelning:
% r*(Tn+1 - 2Tn + Tn-1) / h^2 + (Tn+1 - Tn-1) / 2h = 0
% (r/h^2 - 1/2h) * Tn-1 + (- 2*r/h^2) * Tn + (r/h^2 + 1/2h) * Tn+1 = 0
% 
% vid r = 1:
% (- 2*r/h^2) * T1 + (r/h^2 + 1/2h) * T2 = - (r/h^2 - 1/2h) * T0
% 
% vid r = 2:
% (använder randvilkor för att eliminera Tn+1)
% k*(Tn+1 - Tn) / h = -a(Tn-Te)
% Tn+1 - Tn = -h*a/k*(Tn-Te)
% Tn+1 = (1- h*a/k)*Tn + h*a*Te/k
% 
% (insätter Tn+1)
% (r/h^2 - 1/2h) * Tn-1 + (- 2*r/h^2) * Tn + (r/h^2 + 1/2h) * ((1- h*a/k)*Tn + h*a*Te/k) = 0
% (r/h^2 - 1/2h) * Tn-1 + ((r/h^2 + 1/2h) * (1- h*a/k) - 2*r/h^2) * Tn + (r/h^2 + 1/2h)*h*a*Te/k = 0
% (r/h^2 - 1/2h) * Tn-1 + ((r/h^2 + 1/2h) * (1- h*a/k) - 2*r/h^2) * Tn = - (r/h^2 + 1/2h)*h*a*Te/k
% 
% TN = h*a*Te/k
% .
clear all

Ti = 450;
Te = 20;
N = 25;
r0 = 1; rN1 = 2;
u0 = Ti;
h =( rN1 - r0 ) / (N); % Steglangd
ri = [r0 + h:h: rN1]';

A = zeros(N, N);

A(1, 1:2) = [-2*ri(1)/h^2, ri(1)/h^2 + 1/(2*h)]; % vid r = 1

for i = 2:N-1
    A(i, i - 1) = ri(i)/h^2 - 1/(2*h);
    A(i, i)     = -2*ri(i)/h^2;
    A(i, i + 1) = ri(i)/h^2 + 1/(2*h);
end

a = 1;
k = 1;

A(N, N-1:N) = [ri(N)/h^2 - 1/(2*h), ((ri(N)/h^2 + 1/(2*h)) * (1 - a*h/k) - 2*ri(N)/h^2)] % vid r = 2

A = sparse(A);

uN1 = a*h*Te/k;

b = zeros(N, 1);
b(1) = - u0*(ri(1)/h^2 - 1/(2*h));
b(N) = - uN1*(ri(N)/h^2 + 1/(2*h) );

T = A\b

ri(N)
T(N)


