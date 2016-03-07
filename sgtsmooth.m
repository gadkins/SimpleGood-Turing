function [rstar, polycoef] = sgtsmooth(r, Nr)
% [rstar, polycoef] = sgtsmooth(r, Nr)
% Given a vector of frequencies r, and corresponding counts
% of how many times things of that frequency occur Nr, compute
% smoothed frequencies using the simple Good-Turing (SGT) estimator. %
% The function returns Gale's SGT estimates as:
% rstar, where rstar(k) is the SGT estimate of r(k) for all indices 
%   1 <= k <= length(r).
% polycoef is the coefficients of the regression line fit
% Implementation follows the methods described in:
%
% Gale, W. (1994). "Good-Turing Smoothing Without Tears,"
% J. Quant. Linguistics 2, 24.


% Turing (Tur) Estimator
rstar_Tur = Tur_Estimator(r,Nr);

% Linear Good-Turing (SGT) Estimator
Zr = get_Zr(r,Nr);
p = polyfit(log(r),log(Zr),1);
polycoef = polyval(p,log(r));
b = p(1);
rstar_LGT = LGT_Estimator(r,b);

% Simple Good-Turing (SGT) Method
% Determine when to switch from Tur to LGT estimator
% If the difference between Tur and LGT exceeds 1.65 times the standard
% deviation (square root of variance) of the Tur estimate, then switch is
% made
var = Tur_Variance(r,Nr);
thresh = 1.65 .* sqrt(var);
est_diff = abs(rstar_Tur - rstar_LGT);

rows = size(r,1);
rstar = zeros(rows,1);

% Turing boolean: one we switch to LGT, we don't use Turing counts again
Tur = true;             

for i=1:rows
    if (est_diff(i) >= thresh(i) && Tur)
        rstar(i) = rstar_Tur(i);
    else
        rstar(i) = rstar_LGT(i);
        Tur = false;
    end
end



%////////////////////////  Visualize Data  /////////////////////////

% Non-smooth r vs Nr
figure('Name','Non-smoothed r vs Nr');
plot(log(r),log(Nr),'x');
title('Non-smoothed r vs Nr');
xlabel('log(r), frequency');
ylabel('log(Nr), frequency of frequency');

% Smoothed r vs Nr (i.e. r vs Zr)
figure('Name', 'Smoothed r vs Zr');
plot(log(r),log(Zr), 'x');
title('Smoothed r vs Zr');
xlabel('log(r), frequency');
ylabel('log(Zr), frequency of frequency');
hold on

% Linear fit
plot(log(r),polycoef,'r');
legend('Smoothed Data', 'Linear fit');

% Relative adjusted frequency
SGT_rel = rstar_LGT ./ r;
figure('Name','Simple Good-Turing Estimates');
plot(r(1:50),SGT_rel(1:50),'x');
title('Simple Good-Turing Estimates, r vs (r*/r)');
xlabel('r, frequency');
ylabel('r*/r, relative adjusted frequency');

% Versus unsmoothed 
Tur_rel = rstar_Tur ./ r;
figure('Name','Turing Estimates');
plot(r(1:10),Tur_rel(1:10),'x');
title('Turing Estimates, r vs (r*/r)');
xlabel('r, frequency');
ylabel('r*/r, relative adjusted frequency');

end

