%secant

targetVolume = 1500;
F = @(h, beta) simpson(h, v([a:h:b], beta)) - targetVolume;

a = 0;
b = 20;

h = 0.01;
h0 = 0.2;
h1 = 0.3;
secanterror = [];
count = 0;
tolerance = 10^-8;

while abs(F(h,h1) - F(h,h0))> tolerance
       nexth = h1-F(h,h1)* (h1-h0)/(F(h,h1)-F(h,h0));
       h0=h1;
       h1=nexth;
       count = count + 1;
       secanterror = [secanterror;abs(F(h,h0)-F(h,h1))];
end
secant = h1
secanterror;
count
limit = zeros(1,30)+ tolerance;
semilogy(secanterror, 'b');
hold on;
semilogy(limit);
hold off;