f = @(t, y) sin(3*t) - 2*y;
y = @(t) 93/65 * exp(-2 * t) - 3/13*cos(3*t) + 2/13*sin(3*t);
y0 = 1.2;

T = 8; 

ns = [50 100 200 400];
iterations = length(ns);
results = {};
for i = 1:iterations
    n = ns(i);
    results{i} = zeros(n,1);
    
    h = T/n;
    y = y0;
    t = 0;
    for j = 0:n
        y = y + h*f(t,y);
        results{i}(j+1) = y;
        t = t + h;
    end
    plot(linspace(0,T,n+1), results{i} );
    
    hold on;
end
ode45(f, [0 T], y0);
plot(T,U);
axis auto
legend('50','100','200','400', 'ode45');
hold off;
