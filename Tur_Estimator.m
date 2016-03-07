function rstar = Tur_Estimator(r,Nr)
% Non-smoothed Good-Turing Estimator
% rstar = (r+1)*(N_[r+1]/N_r)

rows = size(r,1);
rstar = zeros(rows,1);

for i=1:rows-1
    rstar(i) = (r(i)+1) .* (Nr(i+1)/Nr(i));
end

