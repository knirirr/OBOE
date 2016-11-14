function y = tfunc(x,k)

if k == 0
    y = x;
else
    y = (exp(x.*k) - 1) ./ (exp(k) - 1);
end
