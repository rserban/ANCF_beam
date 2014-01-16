% Script to generate code to calculate the generalized force due to gravity


g = [sym('g[1]') ; sym('g[2]') ; sym('g[3]')];
for i = 1:3
    assumeAlso(g(i), 'real');
end

syms L real;

syms xi;
S1 = 1 - 3*xi^2 + 2*xi^3;
S2 = L * (xi - 2*xi^2 + xi^3);
S3 = 3*xi^2 - 2*xi^3;
S4 = L * (-xi^2 + xi^3);

S = [S1*eye(3) S2*eye(3) S3*eye(3) S4*eye(3)];



Qg = int(S' * g, 0, 1)

matlabFunction(Qg, 'file', 'grav.m')
