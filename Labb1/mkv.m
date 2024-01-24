load STHLMARLANDA2023.mat

p = @(c , x) c(1) + c(2) *x + c(3) *x.^2 + c(4) *x.^3 + c(5)*x.^4;
mkvsak = @(a, x) a(1) + a(2)*x + a(3)*x.^2;

x = [-2 -1 0 1 2]'
y = [-2.9 -0.65 0.5 2.35 9.1]'

ettor = ones(size(x))

Ainterp = [ ettor, x, x.^2, x.^3, x.^4 ]

size(Ainterp)

cinterp = Ainterp\ y;
xv = [-2:0.1:2]';
yvinterp = p(cinterp, xv);

Amkv = [ettor, x, x.^2]
amkv = Amkv\ y;

res = Amkv*amkv - y
mkvsumma = norm(res).^2
yvmkv = mkvsak(amkv, xv);

hold on
plot(xv, yvinterp)
plot(xv, yvmkv)
plot (x ,y ,'o')
xlabel('x')
ylabel('y')

title('ok en test')