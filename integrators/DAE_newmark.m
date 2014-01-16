function data = DAE_newmark(tend, h, hout, params)
% Perform Newmark integration

% Number of constraints
m = 3 * params.leftCnstr + 3 * params.rightCnstr;

% Preallocate output
nout = floor(tend/hout) + 1;
data.t = zeros(1, nout);
data.e = zeros(params.n, nout);
data.ed = zeros(params.n, nout);
data.edd = zeros(params.n, nout);
if m > 0
    data.lam = zeros(m, nout);
end

% Get initial conditions
[e, ed] = init_cond(params);

% Calculate acceleration and lambda at initial time (assume t0 = 0)
M = mass_matrix(params);
Qe = elastic_forces(e, params);
Qg = gravitational_forces(params);
Q = Qg - Qe;

if m > 0
    [~, Phi_q, ~, Gamma] = constraints(e, params);
    Mbar = [M , Phi_q' ; Phi_q , zeros(m)];
    x = Mbar \ [Q ; Gamma];
    edd = x(1:params.n);
    lam = x(params.n+1:end);
else
    edd = M \ Q;
end

% Store data at t0
data.e(:,1) = e;
data.ed(:,1) = ed;
data.edd(:,1) = edd;
if m > 0
    data.lam(:,1) = lam;
end

% Integrator parameters
tol = 1e-6;
maxIt = 100;

beta = 0.3025;
gam = 0.6;

inv_beta = 1 / (beta * h^2);

% Loop over output times.
hw = waitbar(0,'Initializing waitbar...');

t = 0;
iout = 1;
while t < tend
    e_prev = e;
    ed_prev = ed;
    edd_prev = edd;
    
    % Newton loop.
    for iter = 1:maxIt
        % Update position and velocity (using Newmark)
        e = e_prev + h*ed_prev + 0.5*h^2*((1-2*beta)*edd_prev + 2*beta*edd);
        ed = ed_prev + h*((1-gam)*edd_prev + gam*edd);
        
        % Evaluate generalized forces
        Qe = elastic_forces(e, params);
        Qg = gravitational_forces(params);
        Q = Qg - Qe;

        if m > 0
            % Evaluate constraint residual and Jacobian
            [Phi, Phi_q, ~, ~] = constraints(e, params);
            
            % Evaluate residual and simplified Jacobian
            R = [M*edd + Phi_q' * lam - Q;  inv_beta * Phi];
            if iter == 1
                J = [M , Phi_q' ; Phi_q , zeros(m)];
            end
            
            % Solve for corrections and update solution.
            del = J\R;
            edd = edd - del(1:params.n);
            lam = lam - del(params.n+1:end);
        else
            R = M*edd - Q;
            del = M\R;
            edd = edd - del;
        end
                
        % Check for convergence (exclude Lagrange multipliers).
        if norm(del(1:params.n), inf) <= tol
            break;
        end
    end
    
    % Print a warning if too many Newton iterations...
    if iter > 60
        fprintf('t = %g  h = %g  iter = %i  nrm  %g    %g    cond(J) = %g\n', ...
            t, h, iter, norm(del,inf), norm(del(1:params.n), inf), cond(J));
    end
    
    % Store solution in output (use Newmark for e and ed)
    t = t + h;
    
    if t >= iout * hout
        % update waitbar
        t_str = sprintf('t = %.4f', t);
        waitbar(t/tend,hw,t_str)

        % save output
        data.t(iout+1) = t;
        data.e(:,iout+1) = e_prev + h*ed_prev + 0.5*h^2*((1-2*beta)*edd_prev + 2*beta*edd);
        data.ed(:,iout+1) = ed_prev + h*((1-gam)*edd_prev + gam*edd);
        data.edd(:,iout+1) = edd;
        if m > 0
            data.lam(:,iout+1) = lam;
        end
        iout = iout + 1;
    end
end

close(hw);