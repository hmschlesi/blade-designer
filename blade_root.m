function  root=blade_root(R)
%%Creates two circle profiles for the root of the blade 
%%blade root is not used for foils until 15 of their radius
%% quote from 2005 Windkraftanlagen
%%Root diameter 4% of Radius
%%Z-coordinate of first circle must be at least 0.85 * root diameter in order for the hub to have enough room
d=R*0.04;
r1=R*0.034;
r2=R*0.06;
root=prof_circle(d,r1,100);
root(2)=prof_circle(d,r2,100);
