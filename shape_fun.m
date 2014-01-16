function S = shape_fun(x, L, der)
%SHAPE_FUN calculate the shape functions at the specified location
%   This function returns the shape functions or their derivatives (as a
%   column vector with 4 components) for an ANCF beam element of length L
%   at the specified curvilinear coordinate x along the element axis
%   (0 <= x <= L).
%   S = SHAPE_FUN(x, L, 0)  returns S
%   S = SHAPE_FUN(x, L, 1)  returns Sx
%   S = SHAPE_FUN(x, L, 2)  returns Sxx

xi = x / L;

switch der
    case 0
        S = [1 - 3*xi^2 + 2*xi^3
            L * (xi - 2*xi^2 + xi^3)
            3*xi^2 - 2*xi^3
            L * (-xi^2 + xi^3)];
    case 1
        S = [(6*xi^2 - 6*xi)/L
            1 - 4*xi + 3*xi^2
            (-6*xi^2 + 6*xi)/L
            -2*xi + 3*xi^2];
        
    case 2
        S = [(12*xi-6)/L^2
            (-4+6*xi)/L
            (6-12*xi)/L^2
            (-2+6*xi)/L];
end

end