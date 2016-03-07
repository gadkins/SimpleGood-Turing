load('anc.mat');

r_anc = rNr{1,1}(:,1);
Nr_anc = rNr{1,1}(:,2);

[rstar, polycoef] = sgtsmooth(r_anc, Nr_anc);
