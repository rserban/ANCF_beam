function ee = tilde(e)

ee = zeros(3);
ee(1,2) = -e(3); ee(1,3) =  e(2);
ee(2,1) =  e(3); ee(2,3) = -e(1);
ee(3,1) = -e(2); ee(3,2) =  e(1);

return
