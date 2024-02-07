clear all

beta = 0.2;
% funktion y(b;x)
f = @(x)  (exp(x.*beta) + 8) / (1 + (x./5).^3);

a = 0;
b = 20;
h = [1 1/2 1/4];
N = (b - a)./ h;

x1 = [a:h(1):b]
x2 = [a:h(2):b];
x3 = [a:h(3):b];

fx1 = f(x1)
fx2 = f(x2);
fx3 = f(x3);

Th1 = h(1) * (sum(fx1) - 0.5*(fx1(1) + fx1(end)) )
Th2 = h(2) * (sum(fx2) - 0.5*(fx2(1) + fx2(end)) )
Th3 = h(3) * (sum(fx3) - 0.5*(fx3(1) + fx3(end)) )

%disp ([ 'h = 1  , I = ', num2str ( Th1 ) ]);
%disp ([ 'h = 1/2, I = ', num2str ( Th2 ) ]);
%disp ([ 'h = 1/4, I = ', num2str ( Th3 ) ]);

