// Intends to compress color-images in ways suitable for object recognition
// (preprocessing / feature detection).
// STATUS: plaything sandbox

function playcompress()
stacksize("max");
in = imread("C:\Users\Jan\Pictures\every_majors_terrible.png");
dims = size(in);
assert_checkequal(3, length(dims)); // Assert color-image, assume rgb.
in = rgb2hsv(in); // 0<Hue<(5/6) , 0<Saturation<1 , 0<Value<1

// Hue is well-represented as an angle:
hue = exp(in(:,:,1).*(2*%pi*%i));
hue_accuracy = in(:,:,2).*in(:,:,3);

grey_diff = directed_edges( in(:,:,3));
edge_dir = phase(grey_diff);
out = grey_diff;
imagesc(out);

//tst = matrix([255,0,0,254 0,255,0,0 0,0,255,255], [2 2 3])
//imshow(uint8(tst));
//rgb2hsv(tst)
endfunction

// For complex gray diffs: real part vertical down and imaginary part
// horizontal right.
// This ordering conserves the complex rotation-direction of "clockwise",
// although the directions will seem 90 degrees off when comparing image
// coordinates with traditional complex coordinate visualization.
// Complex phase "arrows" points from dark to bright.
// NOTE: This edge-detection does not perform any kind of low-pass filtering.
// If needed, low-pass filtering / smoothing can be applied before or after
// edge-calculations, in order to reduce noise.
function grey_diff = directed_edges(grey)
    grey_diff = complex( ...
        conv2(in(:,:,3), [1;-1],"same"), ...
        conv2(in(:,:,3), [1,-1],"same"));
endfunction

/// Returns the complex angles (imaginary exponents) of in.
// in is a complex matrix.
// phi is a real matrix containing the phase-info in radians.
function phi = phase(in)
    phi = atan(imag(in), real(in));
endfunction

/// Rescale pixelvalues to span 8 bits and show result.
function imagesc(image)
    imshow(uint8(abs(image*(255/max(abs(image(:)))))));    
endfunction

playcompress();
