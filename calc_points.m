function r = calc_points(e, params, np)
%CALC_POINTS generate points on this noodle at the given configuration.
%   R = CALC_POINTS(E, PARAMS, NP) returns a set of 3-D points on the
%   noodle for the configuration defined by the set of nodal coordinates E,
%   using NP points per ANCF beam element.

% Number of points per element
x = linspace(0, params.L, np);

% Number of points per noodle
NP = params.ne * (np-1) + 1;

r = zeros(3, NP);

% Loop over all ANCF elements on the noodle
ii = 1;
for ie = 1:params.ne
   % Find range of nodal coordinates for this element
   istart = 6*ie - 5;
   iend = 6*ie + 6;

   % Evaluate positions on ANCF element
   for ip = 1:np-1
       S = shape_fun(x(ip), params.L, 0);
       r(:,ii) = S_e(S, e(istart:iend));
       ii = ii + 1;
   end
end

% Right end of noodle.
S = shape_fun(x(np), params.L, 0);
r(:,ii) = S_e(S, e(istart:iend));