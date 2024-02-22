f = @(t, y) sin(3*t) - 2*y;
yanalytic = @(t) 93/65 * exp(-2 * t) - 3/13*cos(3*t) + 2/13*sin(3*t);
y0 = 1.2;

T = 80; 
t0 = 0;
ns = [50 100 200  400];
iterations = length(ns);
results = {};
resultsbak = {};
errorforw = zeros(length(ns),1);
errorback = zeros(length(ns),1);
h = (T-t0)./ns;
for i = 1:iterations
    n = ns(i);
    results{i} = zeros(n,1);
    
    
    y = y0;
    ybak = y0;
    results{i}(1) = y;
    resultsbak{i}(1) = ybak;
    t = t0;
    for j = 1:n
        y = y + h(i)*f(t,y);
        t = t + h(i);
        ybak = (ybak + h(i) * sin(3.*t)) ./(2.*h(i) + 1);
        results{i}(j+1) = y;
        resultsbak{i}(j+1) = ybak;
        
    end
    errorforw(i) = abs(yanalytic(T) - y);
    errorback(i) = abs(yanalytic(T)- ybak);
    plot(linspace(t0,T,n+1), results{i} );
    hold on;
    plot(linspace(t0,T,n+1), resultsbak{i});
    hold on;
end
[Tout, Uout] = ode45(f, [0 T], y0);
plot(Tout,Uout, 'o');
axis auto
%legend('50','100','200','400', 'ode45');
hold off;

figure(2);
loglog(h, errorforw, 'r');
hold on;
loglog(h, errorback, 'b');
hold off;


figure(3);
root_of_ns = ceil(sqrt(length(ns)));
for i = 1:iterations
    subplot(root_of_ns,root_of_ns,i);
    plot(linspace(t0,T,ns(i)+1), results{i});
    hold on;
    plot(Tout,Uout, 'g');
    hold off;
end

figure(4);
root_of_ns = ceil(sqrt(length(ns)));
for i = 1:iterations
    subplot(root_of_ns,root_of_ns,i);
    plot(linspace(t0,T,ns(i)+1), resultsbak{i});
    hold on;
    plot(Tout,Uout, 'g');
    hold off;
end
%När n ökar så närmar vi oss den korrekta lösningen (ode45)

%Eulers bak är stabil för samtliga h medans eulers fram kräver h > 100.
%Detta är att förvantas då eulers fram endast är stabil för h < 2/lamda
%vilket i vårt fall betyder att h < 1 => N > 80
