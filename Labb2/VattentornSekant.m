clear all
format("long")

% beta = 0.2;
% funktion y(b;x)^2
f = @(x, beta) ((exp(beta.*x) + 8) ./ (1 + (x./5).^3)).^2;

a = 0;  %undre
b = 20; % övre
h = 1/64;
N = (b - a)/ h;

x = [a:h:b];

fx = @(beta) f(x, beta);
fxFirst = @(beta) f(x(1), beta);
fxEnd = @(beta) f(x(end), beta);
Th = @(beta) h * (sum(fx(beta)) - 0.5*(fxFirst(beta) + fxEnd(beta)) );
Vt = @(beta) pi * Th(beta) - 1500;

%sekant
tolerance = 10^-8;
maxiter = 100;

% gissningar
bnew = 0.3;
b = 0.25;

i = 0;
diff = 1;
vekofdiffs = [];

while diff > tolerance && i < maxiter
    i = i +1;
    bnew = bnew - Vt(bnew)*(bnew - b)/(Vt(bnew) - Vt(b));
    diff = abs (b - bnew);
    vekofdiffs = [vekofdiffs diff];
    b = bnew;
    bnew = bnew + diff;
end

diff
i
b

semilogy(0:i-1, vekofdiffs, 'b')
hold on