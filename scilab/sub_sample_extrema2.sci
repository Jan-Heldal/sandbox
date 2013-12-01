function [pos, val] sub_sample_extrema2(f, x)
    dfdx = sparse_derivation(f,x);
    idx = find(diff(sign(dfdx)));

endfunction
