clear all
format("long")


beta = 0.2;
% funktion y(b;x)^2
f = @(x) ((exp(beta.*x) + 8) ./ (1 + (x./5).^3)).^2;


a = 0;
b = 20;
h = [1/16 1/32 1/64];
N = (b - a)./ h;

x1 = a:h(1):b;
x2 = [a:h(2):b];
x3 = [a:h(3):b];

fx1 = f(x1);
fx2 = f(x2);
fx3 = f(x3);

% Trapetsregeln
Th1 = h(1) * (sum(fx1) - 0.5*(fx1(1) + fx1(end)) )
Th2 = h(2) * (sum(fx2) - 0.5*(fx2(1) + fx2(end)) )
Th3 = h(3) * (sum(fx3) - 0.5*(fx3(1) + fx3(end)) )

% Simpsons regel
Sh1 = h(1)/3 * ( 4*sum(fx1(1:2:end)) + 2*sum(fx1(2:2:end-2)) + fx1(1) + fx1(end))
Sh2 = h(2)/3 * ( 4*sum(fx2(1:2:end)) + 2*sum(fx2(2:2:end-2)) + fx2(1) + fx2(end))
Sh3 = h(3)/3 * ( 4*sum(fx3(1:2:end)) + 2*sum(fx3(2:2:end-2)) + fx3(1) + fx3(end))

% Volym
% Trapets
Vt1 = pi * Th1
Vt2 = pi * Th2
Vt3 = pi * Th3
% Simpson
Vs1 = pi * Sh1
Vs2 = pi * Sh2
Vs3 = pi * Sh3

% kollar noggranhetsordningen 
% ska ge ungefär 4 för trapets för 2^2
nogTrapets = abs(Th2 - Th1) / abs(Th3 - Th2)
% ska ge ungefär 16 för simpson för 2^4
nogSimpson = abs(Sh2 - Sh1) / abs(Sh3 - Sh2) % eh får 2???

%disp ([ 'h = 1  , I = ', num2str ( Th1 ) ]);
%disp ([ 'h = 1/2, I = ', num2str ( Th2 ) ]);
%disp ([ 'h = 1/4, I = ', num2str ( Th3 ) ]);

