x = -10:.1:10;
y = -10:.1:10;
[xx,yy] = meshgrid(x,y);
r = sqrt(xx.^2 + yy.^2);
z = sin(r)./r;

surf(z);