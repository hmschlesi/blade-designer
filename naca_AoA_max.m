function AoA =naca_AoA_max(name)
%%Gives back the AoA with max C_l in [°]
[pol,coords]=xfoil(name,[0:20],1e6,0,'oper iter 150');
[m,i]=max(pol.CL);
AoA=pol.alpha(i);