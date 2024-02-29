n = 100;
Y = compute_Y(0, n, 10);
yy = Y(1,:);

h = 10/n;
T = sum(yy)*h+1*h/2-yy(end)*h/2