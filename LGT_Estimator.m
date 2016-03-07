function rstar = LGT_Estimator(r,b)
% Linear Good-Turing Estimator
% Given log(Nr) = a + b*log(r), then Nr = A*r^b where b is the slope of the
% linear fit of r vs Zr
% Plugging in GT Estimator we get
% rstar = r(1 + 1/r)^(b+1) for b<-1

if (b >= -1)
    return
end

rstar = r .* (1 + 1./r) .^ (b+1);

end

