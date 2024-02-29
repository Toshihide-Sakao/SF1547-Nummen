% a). 
% y'(t) = sin(3t) - 2y 
% y'(t) + 2y = sin(3t)
% yh = Ce^(-2t)
% 
% yp = -(3/13)*cos(3t) + (2/13)*sin(3t)
% 2yp = -(6/13)*cos(3t) + (4/13)*sin(3t)
% yp' = (9/13)*sin(3t) + (6/13)cos(3t)
% yp'(t) + 2yp(t) = sin(3t)
% (9/13)*sin(3t) + (4/13)*sin(3t) + (6/13)cos(3t) - (6/13)*cos(3t) = sin(3t)
% 
% y(t) = Ce^(-2t) - (3/13)*cos(3t) + (2/13)*sin(3t)
% y(0) = 1.2
% y(0) = C - 3/13 = 1.2 = 6/5
% C = 6/5 + 3/13
% C = (78 + 15)/65 = 93/65
% 
% y(t) = (93/65)*e^(-2t) - (3/13)*cos(3t) + (2/13)*sin(3t)

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
        % Fram
        y = y + h(i)*f(t,y);
        t = t + h(i);

        % Bak
        ybak = (ybak + h(i) * sin(3.*t)) ./(2.*h(i) + 1); % t här är tn+1
        
        % Sparar resultaten
        results{i}(j+1) = y;
        resultsbak{i}(j+1) = ybak;
        
    end

    % Sparar error
    errorforw(i) = abs(yanalytic(T) - y);
    errorback(i) = abs(yanalytic(T)- ybak);

    % plot
    plot(linspace(t0,T,n+1), results{i} );
    hold on;
    plot(linspace(t0,T,n+1), resultsbak{i});
    hold on;
end

% riktiga
[Tout, Uout] = ode45(f, [0 T], y0);
plot(Tout,Uout, 'o');
axis auto
%legend('50','100','200','400', 'ode45');
hold off;

% felplot
figure(2);
loglog(h, errorforw, 'r');
hold on;
loglog(h, errorback, '-ob');
hold off;

% subplottar fram
figure(3);
root_of_ns = ceil(sqrt(length(ns)));
for i = 1:iterations
    subplot(root_of_ns,root_of_ns,i);
    plot(linspace(t0,T,ns(i)+1), results{i});
    hold on;
    plot(Tout,Uout, 'g');
    hold off;
end

% subplottar bak
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
