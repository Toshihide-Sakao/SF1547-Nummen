% function h = circle(x,y,r)
% hold on
% th = 0:pi/50:2*pi;
% xunit = r * cos(th) + x;
% yunit = r * sin(th) + y;
% h = plot(xunit, yunit);
% hold off

clear all

Lfunc = @(xp, yp, x, y, L) (xp - x)^2 + (yp - y)^2 - L^2;
syms xp yp
Lmatrix = @(xp, yp, xa, ya, xb, yb, LA, LB) [Lfunc(xp, yp, xa, ya, LA); Lfunc(xp, yp, xb, yb, LB)];

% given vals
p0 = [0, 0]';
p4 = [1020, 0]';
xas = [175, 410, 675]';
yas = [950, 2400, 1730]';
xbs = [160, 381, 656]';
ybs = [1008, 2500, 1760]';
LAs = [60, 75, 42];
LBs = [45, 88, 57];

% startgisningar
% xposes = [204.6, 458, 712]';
% yposes = [1002, 2457.6, 1749]';
xposes = [208, 450, 720]';
yposes = [1010, 2450, 1760]';


tol = 10^-8;
hnorm = 1;
i = 0;
maxiter = 100;
numofpoints = 3;


for j = 1:numofpoints
    Ljacob(xp, yp) = jacobian(Lmatrix(xp, yp, xas(j), yas(j), xbs(j), ybs(j), LAs(j), LBs(j)), [xp, yp]);
    while hnorm > tol && i < maxiter
        i = i + 1;
        h = -Ljacob(xposes(j), yposes(j)) \ Lmatrix(xposes(j), yposes(j), xas(j), yas(j), xbs(j), ybs(j), LAs(j), LBs(j));
        xposes(j) = xposes(j) + h(1);
        yposes(j) = yposes(j) + h(2);
        hnorm = norm(h);
        % disp([i xposes(1) yposes(1) hnorm]);
    end
    i = 0;
end

% p0 and p4 is set at beggining
p1 = [xposes(1), yposes(1)]';
p2 = [xposes(2), yposes(2)]';
p3 = [xposes(3), yposes(3)]';

ps = [p0, p1, p2, p3, p4]
totalnumofp = 5;

% interpolation med naiv ansats
p4th = @(c, x) c(1) + c(2) *x + c(3) *x.^2 + c(4) *x.^3 + c(5)*x.^4;

% ps(1,:) means taking the row at index 1, so in this case the row with x values
Ainterp = [ones(size(ps(1,:)')), ps(1,:)', ps(1,:)'.^2, ps(1,:)'.^3, ps(1,:)'.^4 ];

% ps(2,:) means row with y vals
cinterp = Ainterp \ ps(2,:)'
xv = [0:1020]';

hold on
% plot all 5 points
for j = 1:totalnumofp
    plot(ps(1, j), ps(2, j), 'o')
end
% plot the graph
plot(xv, p4th(cinterp, xv))

% lable and make axis equal
xlabel('x')
ylabel('y')
axis equal

% plot the circle at the right posses
for j = 1:numofpoints
    circle(xas(j), yas(j), LAs(j));
    circle(xbs(j), ybs(j), LBs(j));
end


% draw circle
function h = circle(x,y,r)
    hold on
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    h = plot(xunit, yunit);
    hold off
end








