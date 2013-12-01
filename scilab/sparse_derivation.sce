// Coloumn-wise derivation estimator based on sparse information.
function [dfdx] = sparse_derivation(f, x)
    dx = diff(x);
    dx2 = dx.^2;
    df = diff(f);
    dfdx = f;
    // Tustins method generalized to the sparse case with varying intervals.
    dx21d = dx(2:$) ./ dx(1:$-1);
    dfdx(2:$-1) = (df(1:$-1) .*dx21d + df(2:$) ./dx21d) ...
    ./ (dx(2:$) + dx(1:$-1));
    dfdx(1,:) = df(1,:)./dx(1,:); // Eulers forward.
    dfdx($,:) = df($,:)./dx($,:); // Eulers backward.
endfunction
