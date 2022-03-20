% ECONOMIC LOAD DISPACH BY: ITERATIVE LAMBDA METHOD w/o LOSSES
% CODE BY: Ricardo Chu Zheng, 2022
% % GITHUB: https://github.com/kypexfly
% REFERENCE: Power Generation, Operation, and Control, Allen J. Wood, Bruce F. Wollenberg, Gerald B. Sheblé (2013)

% IMPORTANT: POWER LIMIT ISN'T CONSIDERED

clc; clear;

data = data();
PD = input("Load / Power demand in MW: "); % load/demand
NGEN = size(data, 1);
PMIN = data(:, 4);
PMAX = data(:, 5);

if PD < sum(PMIN)
    fprintf("PD is less than PMIN. ELD cannot be satisfied, choose another value of PD.\n")
    return
elseif PD > sum(PMAX)
    fprintf("PD is larger than PMAX. ELD cannot be satisfied, choose another value of PD.\n")
    return
end

a = data(:, 1);
b = data(:, 2);
P = randi([min(PMIN), max(PMAX)], [NGEN, 1]);
err = PD;
iter = 0;
A = diag(2 * a);
A(end + 1, end + 1) = 0;
A(end, 1:end - 1) = 1;
B = b*-1;

for i = 1:NGEN
    P_(1, i) = str2sym(sprintf('P_%d', i));
end

Ploss = 0.00003 * P_(1)^2 + 0.00006 * P_(2)^2 + 0.00012 * P_(3)^2;

for i = 1:NGEN
    dPloss(1, i) = diff(Ploss, P_(i));
end

while abs(err) > 1e-6
    Pold = P.';
    iter = iter +1;
    Ploss_val = vpa(subs(Ploss, symvar(Ploss), Pold));
    dPloss_val = vpa(subs(dPloss, symvar(Ploss), Pold));
    A(1:end - 1, end) = dPloss_val - 1;
    B(NGEN + 1) = PD + Ploss_val;
    iter = iter + 1;
    result = linsolve(A, B);
    P = result(1:end - 1);
    Lambda = result(end);
    err = sum((P - Pold.').^2);
end

iter
Lambda
P
