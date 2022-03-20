% ECONOMIC LOAD DISPACH BY: BINARY SEARCH w/o LOSSES
% CODE BY: Ricardo Chu Zheng, 2022
% REFERENCE: Power Generation, Operation, and Control, Allen J. Wood, Bruce F. Wollenberg, Gerald B. Sheblé (2013)

clc; clear;

data = data();
PD = input("Load / Power demand in MW: "); % load/demand

NGEN = size(data, 1);
PMIN = data(:, 4);
PMAX = data(:, 5);
PGEN = 0

if PD < sum(PMIN)
    fprintf("PD is less than PMIN. ELD cannot be satisfied, choose another value of PD.\n")
    return
elseif PD > sum(PMAX)
    fprintf("PD is larger than PMAX. ELD cannot be satisfied, choose another value of PD.\n")
    return
end

a = data(:, 1);
b = data(:, 2);
dCmin = 2 .* a .* PMIN + b;
dCmax = 2 .* a .* PMAX + b;
minLambda = min(dCmin);
maxLambda = max(dCmax);
deltaLambda = (maxLambda - minLambda) / 2;
Lambda = minLambda + deltaLambda
iter = 0;

while abs(PGEN - PD) > 1e-6
    P = (Lambda - b) ./ (2 .* a);

    for i = 1:NGEN

        if Lambda < dCmin(i)
            P(i) = PMIN(i);
        elseif Lambda > dCmax(i)
            P(i) = PMAX(i);
        end

    end

    PGEN = sum(P);
    deltaLambda = deltaLambda / 2;

    if PGEN > PD
        Lambda = Lambda - deltaLambda;
    elseif PGEN < PD
        Lambda = Lambda + deltaLambda;
    end

    iter = iter + 1;
end

iter
Lambda
P
