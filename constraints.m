function [Phi, Phi_q, nu, gamma] = constraints(e, params)
%CONSTRAINTS Evaluate constraints, Jacobian, velocity and acceleration RHS.
%  [PHI, PHI_Q, NU, GAMMA] = CONSTRAINTS(E, PARAMS)
% Note that in all cases NU = GAMMA = 0

% Number of nodal coordinates
n = length(e);

% Number of constraints: ml and mr are the number of constraints at the
% left and right end, respectively. Acceptable values are:
%  0  -->  no constraints
%  3  -->  spherical joint at noodle end
%  6  -->  weld joint at noodle end
ml = 3 * params.leftCnstr;
mr = 3 * params.rightCnstr;
m = ml + mr;

% Noodle length
L = params.ne * params.L;

% Initialize output quantities.
Phi = zeros(m, 1);
Phi_q = zeros(m, n);
nu = zeros(m, 1);
gamma = zeros(m, 1);

if ml > 0
    il = 0;
    Phi(1:3) = [e(il+1) ; e(il+2) ; e(il+3)];
    if ml == 6
        Phi(4:6) = [e(il+4) - 1 ; e(il+5) ; e(il+6)];
    end
    Phi_q(1:ml, il+1:il+ml) = eye(ml);
end

if mr > 0
    ir = n - 6;
    Phi(ml+1:ml+3) = [e(ir+1) - L ; e(ir+2) ; e(ir+3)];
    if mr == 6
        Phi(ml+4:ml+6) = [e(ir+4) - 1; e(ir+5) ; e(ir+6)];
    end
    Phi_q(ml+1:ml+mr, ir+1:ir+mr) = eye(mr);
end

end

