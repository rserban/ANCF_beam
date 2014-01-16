%% Vector of nodal coordinates
e = [sym('e[1]') ; sym('e[2]') ; sym('e[3]') ; sym('e[4]')  ; sym('e[5]')  ; sym('e[6]') ; ...
     sym('e[7]') ; sym('e[8]') ; sym('e[9]') ; sym('e[10]') ; sym('e[11]') ; sym('e[12]')];
for i = 1:12
   assumeAlso(e(i), 'real');
end


%% Position derivative vectors 
rx = [sym('rx[1]') sym('rx[2]') sym('rx[3]')];
rxx = [sym('rxx[1]') sym('rxx[2]') sym('rxx[3]')];
v = [sym('v[1]') sym('v[2]') sym('v[3]')];
for i = 1:3
   assumeAlso(rx(i), 'real');
   assumeAlso(rxx(i), 'real');
   assumeAlso(v(i), 'real');
end
rx = rx';
rxx = rxx';
v = v';


%% Shape functions
% Note the hacks we need to get the final generated code to look right...
sx = [sym('Sx[1]') sym('Sx[2]') sym('Sx[3]') sym('Sx[4]')];
sxx = [sym('Sxx[1]') sym('Sxx[2]') sym('Sxx[3]') sym('Sxx[4]')];
for i = 1:4
   assumeAlso(sx(i), 'real');
   assumeAlso(sxx(i), 'real');
end

Sx = [sx(1)*eye(3) sx(2)*eye(3) sx(3)*eye(3) sx(4)*eye(3)];
Sxx = [sxx(1)*eye(3) sxx(2)*eye(3) sxx(3)*eye(3) sxx(4)*eye(3)];


%%
fprintf('CODE to calculate kappa * kappa_e\n');
fprintf('It is assumed that coef = 3 * ||v||^2 / ||rx||^2 is available\n');
A = tilde(rx)*Sxx;
B = tilde(rxx)*Sx;

syms inv_rx_rx_cubed real;
syms coef real;

kappa_kappa_e = inv_rx_rx_cubed * ( v'*(A-B) - coef * (rx'*Sx));

matlabFunction(kappa_kappa_e, 'file', 'kappa_kappa_e.m');



