clear all

f = @(x) (1-x).* exp (x); % Anonym funktion for integranden

a = 0; b = 1; % Nedre , ovre integrationsgrans
h = 1/32; % Steglangd
N = (b-a)/h; % Antal intervall

x = 0:h:1 % Vektor med integrationspunkter
% x = linspace (0,1,N +1) ; % Antal punkter = antal intervall + 1

fx = f(x) % Rakna ut funktionen i x- vardena

% Trapetsregeln
Th = h*( sum(fx) -0.5*(fx(1)+fx( end )))
%disp ([ 'I = ', num2str (Th)])

% Felet
err = abs (Th -(-2+ exp (1)))
%disp ([ 'eh = ',num2str (err)])