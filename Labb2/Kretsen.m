% a). 
% L*q''(t) + R*q'(t) + (1/C)*q(t) = 0
% i(t) = q'(t)
% 
% q(0) = 1
% q'(0) = i(t) = 0
% 
% i'(t) = - (R*i(t) + (1/C)*q(t)) / L
% q'(t) = i(t)

% y(t) = [q(t) i(t)]
% F(t, y) = - [i(t), - (R*i(t) + (1/C)*q(t)) / L]'
% y0 = y(0) = [1, 0]

clear all

F = @(t, y, R, L, C) [y(2),- (R*y(2) + (1/C)*y(1)) / L]'

y0 = [1, 0]';
t = 0;
T = 40;

% c).
tSpan = [t T];
[it, iy] = ode45(@(t, y) F(t, y, 1, 2, 0.5), tSpan, y0);
% [iit, iiy] = ode45(@(t, y) F(t, y, 0, 2, 0.5), tSpan, y0);

% d).
n = [40, 80, 160, 320];
R = 1;
L = 2;
C = 0.5;
h = (T - t) ./ n;

% gör listor
q = y0(1);
qvec = zeros(size(n,2), n(end))';
qvec(1,:) = q;

i = y0(2);
ivec = zeros(size(n,2), n(end))';
ivec(1,:) = i;

tvec = zeros(size(n,2), n(end))';
tvec(1,:) = t;

% euler
y = y0;
for j = 1:size(n,2)
    for i = 1:n(j)
        % doing fram
        y = y + h(j) .* F(t, y, R, L, C);
        qvec(i + 1, j) = y(1);
        ivec(i + 1, j) = y(2);

        t = t + h(j);
        tvec(i + 1,j) = t;
    end

    t = 0;
    y = y0;
end



for i = 1:size(n,2)
    subplot(2, 2, i)

    plot(tvec(:,i), qvec(:,i), 'o')
    hold on
    plot(it, iy(:, 1), 'r')
    hold off
    title("n = " + 40*2^(i-1))
end

% plot(iit, iiy(:, 1), 'b')

hold off
