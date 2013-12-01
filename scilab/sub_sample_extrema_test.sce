// Testing extrema generation
//simple test-signals
f=[10 -20 -25 15 15 -10]';
x=[ 2   4   8 11 12  15]';
t = (0:.2:7)';
s = sin(t);
[pos, val]=sub_sample_extrema(f,x);
plot(x,f,'-',pos,val,'o');
