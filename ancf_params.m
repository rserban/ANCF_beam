function p = ancf_params()
%ANCF_PARAMS Problem specification

L = 3.0;   % noodle length
r = 0.02;  % noodle radius
ne = 5;    % number of beam elements

p.ne = ne;         % number of ANCF elements per noodle
p.n = 6*(p.ne+1);  % number of nodal coordinates
p.L = L / ne;      % length of one ANCF element
p.E = 2e7;         % elasticity modulus
p.A = pi * r^2;    % cross-section area
p.I = 0.25*pi*r^4; % second moment of area
p.rho = 7200;      % density

p.g = [0; 0; -9.81];  % gravitational acceleration

% specify constraints at the noodle ends
% (0: free, 1: ball joint; 2: weld joint)
p.leftCnstr = 2;
p.rightCnstr = 2;

end