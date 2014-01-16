function out = S_e(S, e)
%S_E Calculate the product SM * e for one ANCF beam element
%  SM - function shape matrix (3x12)
%       SM = [S(1)*eye(3) , S(2)*eye(3) , S(3)*eye(3) , S(4)*eye(3)]
%  e  - vector of element nodal coordinates

out = [S(1)*e(1) + S(2)*e(4) + S(3)*e(7) + S(4)*e(10)
       S(1)*e(2) + S(2)*e(5) + S(3)*e(8) + S(4)*e(11)
       S(1)*e(3) + S(2)*e(6) + S(3)*e(9) + S(4)*e(12)];
   
end