function [pos, val, dfdx, idx, r] = sub_sample_extrema2(f, x)
    dfdx = sparse_derivation(f,x);
    assert_checkequal(length(x), length(f));
// Assumes extremum iff derivatives indicate zero-crossing.
    idx = find(diff(sign(dfdx)));
    dfdxx = dfdx(idx+1) - dfdx(idx);
    fdx = f(idx+1) - f(idx);
    r = (fdx+dfdxx) ./ (2.*dfdxx);
    disp(r);
    pos = r.*x(idx+1) + (1-r).*x(idx);
    val = f(idx+1) - r.*(fdx + (1-r).*dfdxx)
endfunction
