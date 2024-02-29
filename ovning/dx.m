function f = dx(x,y)
    if x == 0
        f = sqrt(2);
    else
        f = 2*x/y*(2/(1+2*x^2+y^2)-1);
    end
end