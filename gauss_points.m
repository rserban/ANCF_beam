function [x,w] = gauss_points(N)
%GAUSS_POINTS Nodes and weights for Gauss quadrature integration in [-1,1]
% [x,w] = GAUSS_POINTS(N) returns the nodes x (in [-1,1]) and weigths w to
% evaluate the integrals using Gauss quadrature of order N.
% 
% Then, for a continuous function f, its integral over [-1,1] can be
% calculated as sum(F.*w), where F(i) = f(x(i)).

switch N
    case 2
        x = [-sqrt(1/3); sqrt(1/3)];
        w = [1; 1];
    case 3
        x = [-sqrt(3/5); 0; sqrt(3/5)];
        w = [5/9; 8/9; 5/9];
    case 4
        x = [-sqrt(3/7 + sqrt(120)/35); -sqrt(3/7 - sqrt(120)/35);
            sqrt(3/7 - sqrt(120)/35); sqrt(3/7 + sqrt(120)/35)];
        w = [1/2 - 5/(3*sqrt(120)); 1/2 + 5/(3*sqrt(120));
            1/2 + 5/(3*sqrt(120)); 1/2 - 5/(3*sqrt(120))];
    case 5
        x = [-(sqrt(5 + 2*sqrt(10/7)))/3; -(sqrt(5 - 2*sqrt(10/7)))/3; 0;
            (sqrt(5 - 2*sqrt(10/7)))/3; (sqrt(5+2*sqrt(10/7)))/3];
        w = [(322 - 13*sqrt(70))/900; (322 + 13*sqrt(70))/900; 128/225;
            (322 + 13*sqrt(70))/900; (322 - 13*sqrt(70))/900];
end