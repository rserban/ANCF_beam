% Script to generate code for the evaluation of the elemental mass matrix
% for a gradient-deficient ANCF beam element.
%    Evaluate  int_0^1 S' * S dx
% Note: we assume that the density is constant over the element.

syms L real;

syms xi;
S1 = 1 - 3*xi^2 + 2*xi^3;
S2 = L * (xi - 2*xi^2 + xi^3);
S3 = 3*xi^2 - 2*xi^3;
S4 = L * (-xi^2 + xi^3);

S = [S1*eye(3) S2*eye(3) S3*eye(3) S4*eye(3)];

M = simplify(int(S'*S, 0, 1));

matlabFunction(M, 'file', 'mass.m');