clear all

format("longG")

% how to devirate in matlab
% syms y(t)
%y(t) = 8*exp(-t/2)*cos(3*t) - 0.5;
%Df = diff(y,t)

H = 0.5;

% d fråga
% H = 2.8464405473

y = @(t) 8*exp(-t/2).*cos(3*t) - H;
yp = @(t) - 4*cos(3*t)*exp(-t/2) - 24*sin(3*t)*exp(-t/2);

% a).
t = 2;
i = 0;
tolerance = 10^(-8);
diff = 1;
maxiter = 100;
vekofdiffs = [];

% testing
vekofts = [t];

% y(t) - tolerance < H < y(t) + tolerance
while  diff > tolerance && i < maxiter
    i = i + 1;
    disp([t y(t) yp(t)])
    tnew = t - y(t)/yp(t);
    diff = abs(tnew - t);
    t = tnew;
    vekofdiffs = [vekofdiffs diff];
    vekofts = [vekofts tnew];
    disp([i t diff])
end

% printar ut och kollar om det stämmer
diff
i
t
y(t)
% -------------

% plottar en ny figur med graf y
figure()
plot([0:0.1:6]', y([0:0.1:6]'), 'g')
% plot(vekofts, y(vekofts), 'o')
figure()
%.---------------------------

semilogy([0:i-1]', vekofdiffs, 'r')
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

% b). Startvärden: t0 = 4 och t1 = 5, Newton har en lite bättre konvergenshastighet eftersom att i är 5 och
% i för sek är 6. Det är eftersom konvergenshastigheten för sekantmetoden är
% ungefär 1.62 och newtons är kvadratisk alltså 2.

% c). Konvergenshastigheten för newtons ge en snabbare konvergens än
% sekant. Eftersom newtons metod oftast är kvadratisk (förrutom när punkten har derivatan 0 som ger en mer linjär) konvergens.
% Sekant har däremot en konvergens hastighet på 1.62...

% d). Startvärde 2 med 18 iterationer. Det är möjligt att se att konvergenshastigheten är
% kvadratisk och startvärdet är väldigt känsligt.
