function Q = gravitational_forces(params, varargin)
%GRAVITATIONAL_FORCES Calculate the beam generalized gravitational force

% Evaluate the elemental Qg
Qg = grav(params.L, params.g);
Qg = params.rho * params.A * params.L * Qg;

% Assemble generalized gravitational force for a noodle with 'ne' elements.
Q = zeros(params.n, 1);
for ie = 1:params.ne
    istart = 6*ie - 5;
    iend = 6*ie + 6;
    
    Q(istart:iend) = Q(istart:iend) + Qg;
end


% If some nodal coordinates are fixed, zero out the appropriate entries
% of the generalized force.
if nargin > 1
    fixed = varargin{1};
    ml = fixed(1);
    mr = fixed(2);
    
    if ml > 0
        il = 0;
        Q(il+1:il+ml) = zeros(ml,1);
    end
    
    if mr > 0
        ir = params.n - 6;
        Q(ir+1:ir+mr) = zeros(mr,1);
    end
end