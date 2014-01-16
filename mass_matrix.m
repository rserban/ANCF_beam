function M = mass_matrix(params, varargin)
%MASS_MATRIX Calculate the generalized mass matrix for a beam.

% Evaluate the elemental mass matrix.
Me = mass(params.L);
Me = params.rho * params.A * params.L * Me;

% Assemble mass matrix for a noodle with 'ne' elements.
M00 = Me(1:6,1:6);
M01 = Me(1:6,7:12);
M10 = Me(7:12,1:6);
M11 = Me(7:12, 7:12);

M = zeros(params.n);
for i = 1:params.ne
    ii = (i-1)*6 + 1;
    M(ii:ii+5,ii:ii+5) = M(ii:ii+5,ii:ii+5) + M00;
    M(ii:ii+5,ii+6:ii+11) = M01;
    M(ii+6:ii+11,ii:ii+5) = M10;
    M(ii+6:ii+11,ii+6:ii+11) = M(ii+6:ii+11,ii+6:ii+11) + M11;
end

% If some nodal coordinates are to be fixed, modify the mass matrix
% (zero out rows and columns, then set diagonal block(s) to identity)
if nargin > 1
    fixed = varargin{1};
    ml = fixed(1);
    mr = fixed(2);
    
    if ml > 0
        il = 0;
        M(il+1:il+ml,:) = zeros(ml,params.n);
        M(:,il+1:il+ml) = zeros(params.n,ml);
        M(il+1:il+ml,il+1:il+ml) = eye(ml);
    end
    
    if mr > 0
        ir = params.n - 6;
        M(ir+1:ir+mr,:) = zeros(mr,params.n);
        M(:,ir+1:ir+mr) = zeros(params.n,mr);
        M(ir+1:ir+mr,ir+1:ir+mr) = eye(mr);
    end 
end