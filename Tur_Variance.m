function var = Tur_Variance(r,Nr)
% Calculate variance of Turing estimate
%   Used to determine when to transition from Turing estimate to Linear
%   Good-Turing (LGT) estimate
%   var = (r+1)^2  * (N_[r+1]/N_r^2) * (1 + N_[r+1]/N_r)

rows = size(r,1);
var = zeros(rows,1);

for i=1:rows-1
    var(i) = (r(i)+1)^2 * (Nr(i+1)/Nr(i)^2) * (1+Nr(i+1)/Nr(i));
end

