function [data, params] = ancf_beam(tend, h, method)
%ANCF_BEAM  simulate a flexible noodle modeled with ANCF beam elements
%   [data,params] = ANCF_BEAM(TEND, H, METHOD) simulates a noodle over the
%     time interval [0,TEND] using a step-size H and the specified method:
%     'newmark' - use a DAE formulation and Newmark integration
%     'rk2'     - use an ODE formulation and an RK2 method (change value
%                 'a' in ODE_rk2 to select a different RK2 method; default 
%                 is midpoint)
%     'euler'   - use an ODE formulation and forward Euler integration


% Add path to functions in subdirectories.
addpath sym;
addpath integrators;

% Set problem parameters and options.
params = ancf_params();

hout = 1e-3;   % Output step size

switch method
    case 'newmark'
        data = DAE_newmark(tend, h, hout, params);
    case 'rk2'
        data = ODE_rk2(tend, h, hout, params);
    case 'euler'
        data = ODE_euler(tend, h, hout, params);
end

% Remove path to subdirectories
rmpath sym;
rmpath integrators;

% Animate noodle and plot coordinates of ends and middle as well as beam
% length.
animate(data, params);
plot_points(data, params);
plot_length(data, params);



