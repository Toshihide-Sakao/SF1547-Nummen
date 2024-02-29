function Y = compute_Y(alpha, n, t)
    y0 = [1; 1];
    h = t/n;
    Y = zeros(2,n);
    A = [-2 1; 1 alpha];
    Y(:,1) = y0 + h*A*y0; % first row

    for i = 2:n
        Y(:, i) = Y(:, i-1)+h*A*Y(:,i-1);
    end
end