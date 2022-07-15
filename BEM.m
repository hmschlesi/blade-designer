function [a, a_head, C_n, C_t] = BEM(name,lambda,alpha_bau,z,chord,r,R,CL,CD)
% Computes local coefficients with the BEM algorithm

%% Step 1: Initialization
a=0;
a_head=0;
a_c=0.3;
d_a=1;
d_ahead=1;

tol=1e-5;
it = 0;
itmax = 100;

while d_a > tol || d_ahead > tol && it<itmax %%Step 7.2
    it = it + 1;
    if it > 1
        a = a_n;
        a_head = a_headn;
    end
    
    %% Step 2: Phi calculation (6.7)

    tan_phi=(1-a)*R./((1+a_head)*lambda*r);
    phi=atan(tan_phi);
    
    %% Additional Step 2: Prandtl verlustfaktor F
    
    f = z/2*(R-r)/(r*sin(phi));
    if f < 0
        f = 0;
    end
    F = 2/pi*acos(exp(-f));
    
    %% Step 3: Local AoA (6.6)

    alpha=phi-alpha_bau;
    %%wird mit ausgegeben.. Warum?
    rad2deg(alpha)

    %% Step 4: Cl(alpha) & Cd(alpha) from table

    %filename=join([name,'.dat'])
    %[pol,coords]=xfoil(filename,rad2deg(alpha),1e6,0,'oper iter 300');
    %pol.CL

    %% Step 5:  Cn & Cd (6.12)(6.13)

    %C_n=pol.CL*cos(phi)+pol.CD*sin(phi);
    %C_t=pol.CL*sin(phi)-pol.CD*cos(phi);
    C_n=CL*cos(phi)+CD*sin(phi);
    C_t=CL*sin(phi)-CD*cos(phi);
    sigma=chord*z./(2*pi*r);
    
    %% Step 6.1: a mit Glauertskorrektur (6.44)(6.42)
    
    if a < a_c
        a_n = 1/(4*F*sin(phi)^2/(sigma*C_n)+1);
    else
        K = 4*F*sin(phi)^2/(sigma*C_n);
        a_n = abs(1/2*(2+K*(1-2*a_c)-((K*(1-2*a_c)+2)^2+4*(K*a_c^2-1))^(1/2)));
    end
    
    %% Step 6.2: a' (6.36)

    a_headn=1/(4*F*sin(phi)*cos(phi)/(sigma*C_t)-1);
    
    %% Step 7.1: check change of a and a'
    d_a=abs(a-a_n); %check change of a & a' for the loop condition
    d_ahead=abs(a_head-a_headn);
    
    a=a_n;
    a_head=a_headn;
    
end
disp('Lösung ist konvergiert')

