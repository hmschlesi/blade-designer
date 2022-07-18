function [a, a_prime, C_n, C_t,F,phi] = BEM(name,lambda,alpha_bau,z,chord,r,R,CL,CD)
% Computes local coefficients a and a' with the BEM algorithm for a
% specific radius and profile

%% Step 1: Initialization
a=0; %a
a_prime=0; %a'
a_c=0.2; %critical induction factor
d_a=1;  %change of a
d_a_prime=1; %change of a'

tol=1e-5;
it = 0;
itmax = 200; %max iteration number

while d_a > tol || d_a_prime > tol && it<itmax %%Step 7.2
    it = it + 1;
%     if it > 1
%         a = a_n;
%         a_head = a_headn;
%     end
    
    %% Step 2: Phi calculation (6.7)

    tan_phi=(1-a)*R./((1+a_prime)*lambda*r);
    phi=atan(tan_phi);
    
    %% Additional Step 2: Prandtl verlustfaktor F
    
    f = z/2*(R-r)/(r*sin(phi)); %(6.34)
    if ~ (f > 0)
        f = 0;
    end
    F = 2/pi*acos(exp(-f)); %(6.33)
    
    %% Step 3: Local AoA (6.6)

    alpha=phi-alpha_bau;
    rad2deg(alpha);

    %% Step 4: Cl(alpha) & Cd(alpha) from table

    %%With xfoil (option 1) (NON RECOMMENDED)
    %addpath(genpath("xfoil"))
    %filename=join([name,'.dat']);
    %[pol,coords]=xfoil(filename,rad2deg(alpha),1e6,0,'oper iter 300');

    %%With maximun Cl and Cd (option 2) (RECOMMENDED)
    %nothing else needed

    %%With polars reading (option 3) (takes longer and gives different results)
    %[C_l,C_d] = read_pol(name,alpha);

    %% Step 5:  Cn & Cd (6.12)(6.13)

    %%With option 1
    %C_n=pol.CL*cos(phi)+pol.CD*sin(phi);
    %C_t=pol.CL*sin(phi)-pol.CD*cos(phi);

    %%With option 2
    C_n=CL*cos(phi)+CD*sin(phi);
    C_t=CL*sin(phi)-CD*cos(phi);

    %%With option 3
    %C_n=C_l*cos(phi)+C_d*sin(phi);
    %C_t=C_l*sin(phi)-C_d*cos(phi);


    sigma=chord*z./(2*pi*r);
    
    %% Step 6.1: a mit Glauertskorrektur (6.44)(6.42)
    
    if a < a_c
        a_n = 1/(4*F*sin(phi)^2/(sigma*C_n)+1);
    else
        K = 4*F*sin(phi)^2/(sigma*C_n);
        a_n = 1/2*(2+K*(1-2*a_c)-sqrt((K*(1-2*a_c)+2)^2+4*(K*a_c^2-1)));
    end
    
    %% Step 6.2: a' (6.36)

    a_prime_n=abs(1/(4*F*sin(phi)*cos(phi)/(sigma*C_t)-1)) ;
    
    %% Step 7.1: check change of a and a'
    d_a=abs(a-a_n); %check change of a & a' for the loop condition
    d_a_prime=abs(a_prime-a_prime_n);
    
    a = a_n;
    a_prime = a_prime_n ;
    
end

if it<itmax
    disp('the solution is convergent')
else
    disp("the solution is not convergent for lambda = "+lambda+" and r = "+r)
end

