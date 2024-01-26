clear all

% syms y(t)
%y(t) = 8*exp(-t/2)*cos(3*t) - 0.5;
%Df = diff(y,t)

% H = 0.5;

H = 2.864405473;

y = @(t) 8*exp(-t/2).*cos(3*t) - H;
yp = @(t) - 4*cos(3*t)*exp(-t/2) - 24*sin(3*t)*exp(-t/2);

% a). 
t = 2;
i = 0;
tolerance = 10^(-8);
diff = 1;
maxiter = 100;
vekofdiffs = [];
vekofis = [];

% testing
vekofts = [t];

% y(t) - tolerance < H < y(t) + tolerance
while  diff > tolerance && i < maxiter
    i = i + 1;
    tnew = t - y(t)/yp(t);
    diff = abs(tnew - t);
    t = tnew;
    vekofdiffs = [vekofdiffs diff];
    vekofis = [vekofis i];
    vekofts = [vekofts tnew];
    disp([i t diff])
end
diff
i
t
y(t)

figure()
plot([0:0.1:6]', y([0:0.1:6]'))
plot(vekofts, '-o')
figure()

semilogy(vekofis, vekofdiffs, 'r')
hold on
grid on

% a). t = 4.50, i = 14, startvärde 4.8 

%b).
tnew = 5;
t = 4;
isek = 0;
diff = 1;
vekofdiffssek = [];

while diff > tolerance && isek < maxiter
    isek = isek +1;
    tnew = tnew - y(tnew)*(tnew - t)/(y(tnew) - y(t));
    diff = abs (t - tnew);
    vekofdiffssek = [vekofdiffssek diff];
    t = tnew;
    tnew = tnew + diff;
end

diff
isek
t

semilogy(0:isek-1, vekofdiffssek, 'b')
hold on

%b). Startvärden: t0 = 4 och t1 = 5, Newton har en lite bättre konvergenshastighet eftersom att i är 5 och
%i för sek är 6. Det är eftersom konvergenshastigheten för sekantmetoden är
%ungefär 1.62 och newtons är kvadratisk alltså 2.

% c). Konvergenshastigheten för newtons ge en snabbare konvergens än
% sekant.