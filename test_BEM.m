clear all
close all
clc

%% Definitions

vwind = 12;
R=10;
lambda_design = 7;
z = 3;

prof(1).r=1;
prof(1).name="circle1m";
prof(1).alpha_bau=0;
prof(1).camber=1;
prof(1).Cl=0;
prof(1).Cd=0.43;

prof(2).r=4;
prof(2).name="circle1m";
prof(2).alpha_bau=0;
prof(2).camber=1;
prof(2).Cl=0;
prof(2).Cd=0.43;

prof(3).r=10;
prof(3).name="fx66s196";
prof(3).alpha_bau=0.2651;
prof(3).camber=5.1324;
prof(3).Cl=1.3757;
prof(3).Cd=0.01;

prof(4).r=30;
prof(4).name="naca1408";
prof(4).alpha_bau=0.086;
prof(4).camber=5.2595;
prof(4).Cl=0.579;
prof(4).Cd=0.0131;

prof(5).r=50;
prof(5).name="naca63209";
prof(5).alpha_bau=0.0248;
prof(5).camber=3.1743;
prof(5).Cl=0.59;
prof(5).Cd=0.0135;

%a = 0.1;
%a_prime = 0.9;

%% Test BEM

%[a, a_head, C_n, C_t] = BEM(name,lambda,alpha_bau,z,chord,r,R,CL,CD);

%% Test characteristics

[lambda,omega,n,M,P,T,CM,CP,CT] = characteristics(vwind, R, z, prof);
tiledlayout(3,2)
nexttile
plot(n,P)
title ('P-n')
nexttile
plot(n,M)
title('M-n')
nexttile
plot(n,T)
title('T-n')
nexttile
plot(lambda,CP)
title('CP-lambda')
nexttile
plot(lambda,CM)
title('CM-lambda')
nexttile
plot(lambda,CT)
title('CT-lambda')