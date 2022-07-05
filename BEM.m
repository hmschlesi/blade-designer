function BEM(name,lambda,alpha_bau,z,chord,r,R)

a=0;
a_head=0;
a_c=0.3;
d_a=1;
d_ahead=1;
tol=1e-5;
it = 0;
itmax = 100;

while d_a > tol || d_ahead >tol && it<itmax
    it = it + 1
    if it > 1
        a = a_n;
        a_head = a_headn;
    end
    
    tan_phi=(1-a)/((1+a_head)*lambda);
    phi=atan(tan_phi);
    
    %% Step 2: Prandtl verlustfaktor F
    
    f = z/2*(R-r)/(r*sin(phi));
    if f < 0
        f = 0;
    end
    F = 2/pi*acos(exp(-f));
    
    alpha=phi-alpha_bau;
    rad2deg(alpha)
    [pol,coords]=xfoil(name,rad2deg(alpha),1e6,0,'oper iter 300');
    pol.CL
    C_n=pol.CL*cos(phi)+pol.CD*sin(phi);
    C_t=pol.CL*sin(phi)-pol.CD*cos(phi);
    sigma=chord*z./(2*pi*r);
    
    %% Step 6.1 Glauertskorrektur
    
    if a < a_c
        a_n = 1/(4*F*sin(phi)^2/(sigma*C_n)+1);
    else
        K = 4*F*sin(phi)^2/(sigma*C_n);
        a_n = abs(1/2*(2+K*(1-2*a_c)-((K*(1-2*a_c)+2)^2+4*(K*a_c^2-1))^(1/2)))
    end
    
    a_headn=1/(4*F*sin(phi)*cos(phi)/(sigma*C_t)-1);
    
    d_a=abs(a-a_n);
    d_ahead=abs(a_head-a_headn);
    
    a=a_n;
    a_head=a_headn;
    
end
disp('Lösung ist konvergiert')
