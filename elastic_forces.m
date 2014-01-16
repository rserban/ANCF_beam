function Q = elastic_forces(e, params, varargin)
%ELASTIC_FORCES Calculate the beam generalized elastic force

% Calculate nodes and weights for Gauss quadrature on the interval [-1,1]
% using 5 nodes (for the axial forces) and 3 nodes (for the torsional
% forces).
[x3, w3] = gauss_points(3);
[x5, w5] = gauss_points(5);

% Initialize elastic force vector
Q = zeros(params.n, 1);

% Loop over all ANCF elements on the noodle
for ie = 1:params.ne
    % Find range of nodal coordinates for this element
    istart = 6*ie - 5;
    iend = 6*ie + 6;
    
    % Calculate axial force
    Qe = zeros(12,1);
    for k = 1:5
        x = (1 + x5(k)) * params.L / 2;
        eee = eps_integrand(e(istart:iend), x, params.L);
        Qe = Qe + w5(k) * eee;
    end
    Qe = Qe * params.E * params.A * params.L / 2;
    
    % Calculate torsional force
    Qk = zeros(12,1);
    for k = 1:3
        x = (1 + x3(k)) * params.L / 2;
        kke = kappa_integrand(e(istart:iend), x, params.L);
        Qk = Qk + w3(k) * kke;
    end
    Qk = Qk * params.E * params.I * params.L / 2;
    
    % Accumulate the two elastic force components
    Q(istart:iend) = Q(istart:iend) + Qe + Qk;
end

% If some nodal coordinates are fixed, zero out the appropriate entries
% of the generalized force.
if nargin > 2
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

end


%% -----------------------------------------------------------

function eee = eps_integrand(e, x, L)

% Evaluate shape function derivatives.
Sx = shape_fun(x, L, 1);

% Evaluate eps * eps_e
eee = eps_eps_e(Sx, e);

end

%% -----------------------------------------------------------

function kke = kappa_integrand(e, x, L)

% Evaluate shape function derivatives.
Sx = shape_fun(x, L, 1);
Sxx = shape_fun(x, L, 2);

% Evaluate rx and rxx.
rx = S_e(Sx, e);
rxx = S_e(Sxx, e);

% Calculate v = rx x rxx
v = cross(rx, rxx);

coef = 3 * (v'*v) / (rx'*rx);
inv_rx_rx_cubed = 1 / (rx'*rx)^3;

% Evaluate kappa * kappa_e
kke = kappa_kappa_e(Sx, Sxx, coef, inv_rx_rx_cubed, rx, rxx, v);
kke = kke';

end