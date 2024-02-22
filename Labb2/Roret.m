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

% konstanter
Ti = 450;
Te = 20;

N = 25;
r0 = 1; rN1 = 2;
T0 = Ti;
h =( rN1 - r0 ) / (N); % Steglangd
ri = [r0 + h:h: rN1]';

A = zeros(N, N);

tolerance = 10^-2 / 3;
oldRes = 0;
fel = 1;

a = 1;
k = 1;

T = [];
TN1 = a*h*Te/k;

% -----------------------------------------------------------------------------------------
% c) för att hitta ett N med litet fel
while fel > tolerance
    % setup
    A = zeros(N, N);
    h =( rN1 - r0 ) / (N); % Steglangd
    ri = [r0 + h:h: rN1]';
    TN1 = a*h*Te/k;

    % värdet vid r=2 för att verifiera
    T = calcT(A, h, ri, T0, TN1, N, a, k);
    
    fel = abs(oldRes - T(N));

    % reseta saker
    oldRes = T(N);
    N = N*2;
end

N = N/2
oldRes

% svar för c) blev N = 12800

figure()
hold on
plot([r0;ri;rN1], [T0;T;TN1], '--o')
hold off
% ------------------------------------------------------------------------------------------

% -----------------------------------------------------------------------------------------
% % d).
%setup
N = 12800;
A = zeros(N, N);
h =( rN1 - r0 ) / (N); % Steglangd
ri = [r0 + h:h: rN1]';
TN1 = a*h*Te/k;

as = [0:0.5:10];
k = 1;

TNs = zeros(20, 1);

for i = 1:size(as, 2)
    T = calcT(A, h, ri, T0, TN1, N, as(i), k);

    % spara T där r=2
    TNs(i) = T(N);
end

figure()
hold on
plot(as, TNs, 'r')
hold off

% ---------------------------------------------------------------------------------

% funktion för att lösa ut T
function t = calcT(A, h, ri, T0, TN1, N, a, k)
    % första raden görs separat
    A(1, 1:2) = [-2*ri(1)/h^2, ri(1)/h^2 + 1/(2*h)]; % vid r = 1

    % andra till näst sista raden
    for i = 2:N-1
        A(i, i - 1) = ri(i)/h^2 - 1/(2*h);
        A(i, i)     = -2*ri(i)/h^2;
        A(i, i + 1) = ri(i)/h^2 + 1/(2*h);
    end

    % sista raden görs också separat
    A(N, N-1:N) = [ri(N)/h^2 - 1/(2*h), ((ri(N)/h^2 + 1/(2*h)) * (1 - a*h/k) - 2*ri(N)/h^2)]; % vid r = 2

    A = sparse(A);

    % högerled
    b = zeros(N, 1);
    b(1) = - T0*(ri(1)/h^2 - 1/(2*h));
    b(N) = - TN1*(ri(N)/h^2 + 1/(2*h) );

    % löser ut T och returnar
    t = A\b;
end

