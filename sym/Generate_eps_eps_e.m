% This script generates code to calculate the quantity
%        \eps * \eps_e


%% Vector of nodal coordinates
e = [sym('e[1]') ; sym('e[2]') ; sym('e[3]') ; sym('e[4]')  ; sym('e[5]')  ; sym('e[6]') ; ...
     sym('e[7]') ; sym('e[8]') ; sym('e[9]') ; sym('e[10]') ; sym('e[11]') ; sym('e[12]')];
for i = 1:12
   assumeAlso(e(i), 'real');
end

%% Shape functions
sx = [sym('Sx[1]') sym('Sx[2]') sym('Sx[3]') sym('Sx[4]')];
for i = 1:4
   assumeAlso(sx(i), 'real');
end

Sx = [sx(1)*eye(3) sx(2)*eye(3) sx(3)*eye(3) sx(4)*eye(3)];

rx  = Sx  * e;

%% Axial elastic force.
eps = simplify(0.5 * (rx'*rx - 1));
eps_e = simplify((Sx' * Sx) * e);
eps_eps_e = simplify(eps * eps_e);

matlabFunction(eps_eps_e, 'file', 'eps_eps_e.m');

