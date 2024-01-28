clear all

H = 2.864405473;

y = @(t) 8*exp(-t/2).*cos(3*t) - H;
yp = @(t) - 4*cos(3*t)*exp(-t/2) - 24*sin(3*t)*exp(-t/2);


t = 2;
i = 0;
tolerance = 10^(-8);
diff = 1;
maxiter = 100;
vekofdiffs = [];

while  diff > tolerance && i < maxiter
    i = i + 1;
    tnew = t - y(t)/yptest(t);
    diff = abs(tnew - t);
    t = tnew;
    vekofdiffs = [vekofdiffs diff];
    disp([i t diff])
end

diff
i
t
y(t)

semilogy([0:i-1]', vekofdiffs, 'r')
hold on
grid on



