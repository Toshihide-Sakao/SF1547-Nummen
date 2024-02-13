clear all
format long 

beta = 0.2;
% funktion y(b;x)
f = @(x, beta)  (exp(x.*beta) + 8) ./ (1 + (x./5).^3);
v = @(x, beta) pi * f(x,beta).^2;
trapets = @(h, fx) h * (sum(fx) - 0.5*(fx(1) + fx(end)) )

% A(1:2:end) ger alla udda indexes, A(2:2:end) ger alla jämna allt annat är
% bara för att inte få med sista eller första elementet
simpson = @(h, fx) h/3 * ( fx(1) + 4*sum(fx(3:2:end-1)) + 2* sum(fx(2:2:end-1)) + fx(end))



a = 0;
b = 20;
h = 1;
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


%disp ([ 'h = 1  , I = ', num2str ( Th1 ) ]);
%disp ([ 'h = 1/2, I = ', num2str ( Th2 ) ]);
%disp ([ 'h = 1/4, I = ', num2str ( Th3 ) ]);

