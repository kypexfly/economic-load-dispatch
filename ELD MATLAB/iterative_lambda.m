% ECONOMIC LOAD DISPACH BY: ITERATIVE LAMBDA METHOD w/o LOSSES
% CODE BY: Ricardo Chu Zheng, 2022
% REFERENCE: Power Generation, Operation, and Control, Allen J. Wood, Bruce F. Wollenberg, Gerald B. Sheblé (2013)

clc; clear;

data = data();
PD = input("Load / Power demand in MW: "); % load/demand
NGEN = size(data, 1);
PMIN = data(:, 4);
PMAX = data(:, 5);
a = data(:, 1);
b = data(:, 2);

if PD < sum(PMIN)
    fprintf("PD is less than PMIN. ELD cannot be satisfied, choose another value of PD.\n")
    return
elseif PD > sum(PMAX)
    fprintf("PD is larger than PMAX. ELD cannot be satisfied, choose another value of PD.\n")
    return
end

Lambda = max(b); % initial Lambda set by default
P = zeros(NGEN, 1);
err = PD;
d_err = -sum(1 ./ (2 * a));
iter = 0;

while abs(err) > 1e-6
    P = (Lambda - b) ./ (2 .* a);

    for i = 1:NGEN

        if P(i) < PMIN(i)
            P(i) = PMIN(i);
        elseif P(i) > PMAX(i)
            P(i) = PMAX(i);
        end

    end

    err = PD - sum(P);
    Lambda = Lambda - err / d_err;
    iter = iter + 1;
end

iter
Lambda
P
