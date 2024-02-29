h = 0.1;
x = 0;
y = 0;
Y = 0;

for steg = 1:8
    k1 = dx(x, y);
    k2 = dx(x+h/2, y+h*k1/2);
    k3 = dx(x+h/2, y+h*k2/2);
    k4 = dx(x+h, y+h*k3);
    y = y+h*(k1+2*k2+2*k3+k4)/6;
    Y = [Y y];
    x = x +h;
end

ym = y;
X = 0:h:0.8;
plot(X,Y,X-Y)
axis equal
hold on