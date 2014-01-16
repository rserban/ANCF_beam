function [e0, ed0] = init_cond(params)
%INIT_COND Specify initial conditions for the beam nodal coordinates

% we always initialize the beam horizontal with its left end at the origin
% and at rest

e0 = zeros(params.n, 1);
ed0 = zeros(params.n, 1);

for ie = 1:params.ne+1
   e0(6*ie-5) = (ie-1) * params.L;
   e0(6*ie-2) = 1;
end