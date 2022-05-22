function profile=prof_circle(d,r,n)
phi=linspace(0,2*pi,n);
profile.x=d./2.*cos(phi)+(0.5.*d);
profile.y=d./2.*sin(phi);
profile.z=ones(1,n)*r;
profile.Cd=1.2;
profile.Cl=0;
profile.camber=d;
profile.alpha_bau=0;
profile.r=r;
profile.Cdp=0;
profile.Cm=0;
