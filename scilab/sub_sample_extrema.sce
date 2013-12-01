/// Looks on the two closest values on each side to determine position and value of extrema with sub-pixel accuracy, assuming no noise.
/// Estimates f(x_k + r(x_(k+1)-r_k)) using second-order interpolation. 0<=r<=1.

function [pos, val] = sub_sample_extrema(f, x)
if 0==argn(2) then
    //simple test
    f=[10 -20 -25 15 15 -10]
    x=[ 2   4   8 11 12  15]
end
L = length(f(:));
pos = list();
val = list();


for k = 2:(L-2) do
    f1 = f(k-1);
    f2=f(k);
    f3=f(k+1);
    f4=f(k+2);
    f_2 = f3-f1; // Unscaled Tustins derivation estimators.
    f_3 = f4-f2;
// Assumes extremum iff derivatives indicate zero-crossing.
    if( f_3*f_2 < 0)
        D = (x(k+1)-x(k));
        f_ = (f3-f2) / D;
        f__ = f_3 /(x(k+2)-x(k)) ...
            - f_2 /(x(k+1)-x(k-1));
        f_C = f_-f__;
// Calculates the exact position for extrema
        r = -f_C/(2*f__);
        pos($+1) = x(k)+D*r;
        fr = r*D* ((r-1)*f__ + f_)+f2;
        val($+1) = fr;
// Derivative should be zero:
        assert_checkalmostequal(0, ...
            2*r*f__ + f_C, 2*%eps);
    end
end
endfunction
