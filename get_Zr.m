function Zr = get_Zr(r,Nr)
% Linear Good-Turing Estimator
%   Average each non-zero Nr with the zero Nr that surround it
%   Order the non-zero Nr by r and let q,r and t be successive indices of 
%   non-zero Nr
%   Replace Nr with Zr = Nr/[0.5*(t-q)]
%   i.e. estimate the expected Nr, by the density of Nr

row = size(r,1);

Zr = zeros(row,1);

% first and last Nr are unmodified
Zr(1,1) = Nr(1,1);
Zr(row,1) = Nr(row,1);

for i=2:(row-1)
    % Zr = Nr/[0.5*(t-q)]
    % where q, r, and t are successive indices of non-zero Nr
    Zr(i) = Nr(i) / (0.5 * (r(i+1) - r(i-1)) );
end

