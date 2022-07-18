clear all
close all
clc

%% Definitions

vwind = 12;
R=50;
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

prof(3).r=15;
prof(3).name="NACA63-212";
prof(3).alpha_bau=0.1654;
prof(3).camber=5.2865;
prof(3).Cl=1.0357;
prof(3).Cd=0.0096;

prof(4).r=20;
prof(4).name="NACA63-212";
prof(4).alpha_bau=0.0978;
prof(4).camber=4.2117;
prof(4).Cl=1.0357;
prof(4).Cd=0.0096;

prof(5).r=25;
prof(5).name="NACA63-212";
prof(5).alpha_bau=0.0546;
prof(5).camber=3.4705;
prof(5).Cl=1.0357;
prof(5).Cd=0.0096;

prof(6).r=30;
prof(6).name="NACA63-212";
prof(6).alpha_bau=0.0249;
prof(6).camber=2.9403;
prof(6).Cl=1.0357;
prof(6).Cd=0.0096;

prof(7).r=35;
prof(7).name="NACA63-212";
prof(7).alpha_bau=0.0033;
prof(7).camber=2.5459;
prof(7).Cl=1.0357;
prof(7).Cd=0.0096;

prof(8).r=40;
prof(8).name="NACA63-212";
prof(8).alpha_bau=-0.0131;
prof(8).camber=2.2426;
prof(8).Cl=1.0357;
prof(8).Cd=0.0096;

prof(9).r=45;
prof(9).name="NACA63-212";
prof(9).alpha_bau=-0.026;
prof(9).camber=2.0026;
prof(9).Cl=1.0357;
prof(9).Cd=0.0096;

prof(10).r=49;
prof(10).name="NACA63-212";
prof(10).alpha_bau=-0.0344;
prof(10).camber=1.8441;
prof(10).Cl=1.0357;
prof(10).Cd=0.0096;

%a = 0.1;
%a_prime = 0.9;

%% Test BEM

%[a, a_head, C_n, C_t] = BEM(name,lambda,alpha_bau,z,chord,r,R,CL,CD);

%% Test characteristics

[lambda,omega,n,M,P,T,CM,CP,CT] = characteristics(vwind, R, z, prof);
figure()
tiledlayout(3,2)

nexttile
plot(lambda,CP)
title('C_P-\lambda curve')
xlabel('\lambda')
ylabel('C_P')
axis ([1 14 0 Inf])

nexttile
plot(n,P)
hold on
title ('P-n curve')
xlabel('n [rpm]')
ylabel('Power [W]')

nexttile
plot(lambda,CM)
title('C_M-\lambda curve')
xlabel('\lambda')
ylabel('C_M')
axis ([1 14 0 Inf])

nexttile
plot(n,M)
title('M-n curve')
xlabel('n [rpm]')
ylabel('Torque [Nm]')

nexttile
plot(lambda,CT)
title('C_T-\lambda curve')
xlabel('\lambda')
ylabel('C_T')
axis ([1 14 0 Inf])

nexttile
plot(n,T)
title('T-n curve')
xlabel('n [rpm]')
ylabel('Thrust [N]')