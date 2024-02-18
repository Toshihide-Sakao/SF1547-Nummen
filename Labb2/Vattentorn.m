clear all
format long 


% funktion y(b;x)
f = @(x, beta)  (exp(x.*beta) + 8) ./ (1 + (x./5).^3);
v = @(x, beta) pi * f(x,beta).^2;

trapets = @(h, fx) h * (sum(fx) - 0.5*(fx(1) + fx(end)) )

% A(2:3:end) ger alla udda indexes om man har nollindexerat, A(3:2:end-1)
% ger alla jämna om man har nollindexerat.
simpson = @(h, fx) h/3 * ( fx(1) + 4*sum(fx(2:2:end)) + 2* sum(fx(3:2:end-1)) + fx(end))



a = 0;
b = 20;
beta = 0.2;
h = 0.1;
iterations = 10;
trapetsresults = zeros(iterations,1)
simpsonresults = zeros(iterations,1)

for i = 1:iterations
    N = (b - a)/ h;
    
    x = [a:h:b];
    fx = v(x, beta);

    Th = trapets(h, fx);
    Sh = simpson(h, fx);
    trapetsresults(i) = Th;
    simpsonresults(i) = Sh;
    h = h/2;
end 

trapetsresults
simpsonresults

trapetsnoggranhet = zeros(size(trapetsresults)-2)
simpsonnoggranhet = zeros(size(simpsonresults)-2)

p = @(y, i) log2( abs(y(i) - y(i+1)) / abs(y(i+1)-y(i+2)) )
for i = 1:length(trapetsresults)-2
    trapetsnoggranhet(i) = p(trapetsresults, i);
    simpsonnoggranhet(i) = p(simpsonresults, i);

end
noggranhet_av_trapets = mean(trapetsnoggranhet)
noggranhet_av_simpson = mean(simpsonnoggranhet)




%disp ([ 'h = 1  , I = ', num2str ( Th1 ) ]);
%disp ([ 'h = 1/2, I = ', num2str ( Th2 ) ]);
%disp ([ 'h = 1/4, I = ', num2str ( Th3 ) ]);