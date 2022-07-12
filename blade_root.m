function  root=blade_root(R)
%%Creates two circle profiles for the root of the blade 
%%blade root is not used for foils until 15 of their radius
%% quote from 2005 Windkraftanlagen
R
d=R*0.02
r1=R*0.02
r2=R*0.08
root=prof_circle(d,r1,100);
root(2)=prof_circle(d,r2,100);