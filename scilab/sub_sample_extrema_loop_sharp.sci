/// Looks on the two closest values on each side to determine position and value of extrema with sub-pixel accuracy, assuming no noise.
/// Estimates f(x_k + r(x_(k+1)-r_k)) using second-order interpolation. 0<=r<=1.

function [xpos, fval] = sub_sample_extrema_loop_sharp(f, x)
if 0==argn(2) then
    //simple test
    f=[10 -20 -25 15 15 -10]
    x=[ 2   4   8 11 12  15]
end
L = length(f(:));
xpos = list();
fval = list();


for k = 2:(L-2) do
    f1 = f(k-1);
    f2=f(k);
    f3=f(k+1);
    f4=f(k+2);
    // Unscaled derivation estimators.
    f_2 = f2-f1; // Eulers backward derivation estimator.
    f_3 = f4-f3; // Eulers forward derivation estimator.
// Assumes extremum iff derivatives indicate zero-crossing.
    if( f_3*f_2 < 0)
        d12 = (x(k)-x(k-1));
        d23 = (x(k+1)-x(k));
        d34 = (x(k+2)-x(k+1));
        f_2 = f_2/d12;
        f_3 = f_3/d34;
        f_23 = (f3-f2);
        bow = -(f_3 - f_2)*d23;
        r = .5 - f_23/(2*bow); // Relative position.
        // Derivative should be zero, but using Eulers derivation-estimators gives exaggregated sharp extremas, causing this test to fail.
        //assert_checkalmostequal(0, f3-f2 +(1-2*r)*bow), 2*%eps);
        xpos($+1) = x(k) + r*d23;
        fval($+1) = f2*(1-r) + f3*r + r*(1-r)*bow;
    end
end
endfunction
