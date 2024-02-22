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


% b). 

clear all

yanalytisk = @(t) (93/65).*exp(-2.*t) - (3/13).*cos(3.*t) + (2/13).*sin(3.*t)
f = @(y, t) sin(3.*t) - 2.*y 

n = [50 100 200 400];
t = 0;
T = 80;
h = (T-t) ./ n;
y = 1.2;

tvec = zeros(4, n(4))';
tvec(1,:) = t;

% framåt
yf = y;
yfram = zeros(4, n(4))';
yfram(1,:) = y;

% bakåt 
% ynew = y + h * f(ynew, tnew)
% ynew = y + h * (sin(3.*tnew) - 2.*ynew)
% ynew = y + h*sin(3.*tnew) - 2*h*ynew
% ynew + 2*h*ynew
% (2*h + 1) * ynew = y + h*sin(3.*tnew)

% ynew = (y + h*sin(3.*tnew)) / (2*h + 1)

yb = y;
ybak = zeros(4, n(4))';
ybak(1,:) = y;

%spara felvärden
felfram = zeros(4, 1);
felbak = zeros(4, 1);

for j = 1:4
    for i = 1:n(j)
        % doing fram
        yf = yf + h(j) * f(yf, t);
        yfram(i + 1,j) = yf;

        t = t + h(j);

        %doing bakåt
        yb = (yb + h(j)*sin( 3.*t)) ./ (2.*h(j) + 1); % t här är tnext
        ybak(i + 1, j) = yb;

        % for both
        tvec(i + 1,j) = t;
    end
    felfram(j) = abs(yanalytisk(T) - yf);
    felbak(j) = abs(yanalytisk(T) - yb);

    t = 0;
    yf = 1.2;
    yb = 1.2;
end

felfram

figure(1)
rowToShow = 1;

hold on
% Only shows 'rowToShow'
plot(tvec(:,rowToShow), yfram(:,rowToShow), '.', 'LineWidth', 2)
plot(tvec(:,rowToShow), ybak(:, rowToShow) , '.', 'LineWidth', 2)

% Shows all hs
% plot(tvec, yfram, '.', 'LineWidth', 2)
% plot(tvec, ybak,  '.', 'LineWidth', 2)
plot([0:0.1:T], yanalytisk([0:0.1:T]), 'r')

hold off

figure(2)
loglog(h, felfram, 'r')
hold on
loglog(h, felbak, 'b')

hold off


