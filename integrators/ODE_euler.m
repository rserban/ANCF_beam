function data = ODE_euler(tend, h, hout, params)
% Perform forward Euler integration

% Number of fixed nodal coordinates (left and right)
ml = 3 * params.leftCnstr;
mr = 3 * params.rightCnstr;
fixed = [ml mr];

% Preallocate output
nout = floor(tend/hout) + 1;
data.t = zeros(1, nout);
data.e = zeros(params.n, nout);
data.ed = zeros(params.n, nout);

% Initial conditions (t=0)
[e, ed] = init_cond(params);

% Store data at t0
data.t(1) = 0;
data.e(:,1) = e;
data.ed(:,1) = ed;

% Mass matrix (constant)
M = mass_matrix(params, fixed);
Minv = M^(-1);

% Loop over all output times.
hw = waitbar(0,'Initializing waitbar...');

t = 0;
iout = 1;
while t < tend
    Qe = elastic_forces(e, params, fixed);
    Qg = gravitational_forces(params, fixed);
    f = [ed ; Minv*(Qg-Qe)];
    if ml > 0, il = 0;            f(il+1:il+ml) = zeros(ml,1); end
    if mr > 0, ir = params.n - 6; f(ir+1:ir+mr) = zeros(mr,1); end
    
    update = h * f;
    e = e + update(1:params.n);
    ed = ed + update(params.n+1:end);
    
    t = t + h;
    
    if t >= iout * hout
        % update waitbar
        t_str = sprintf('t = %.4f', t);
        waitbar(t/tend,hw,t_str)
        
        % save output
        data.t(iout+1) = t;
        data.e(:,iout+1) = e;
        data.ed(:,iout+1) = ed;
        iout = iout + 1;
    end
end

close(hw);
