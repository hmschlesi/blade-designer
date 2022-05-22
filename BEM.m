function BEM(name,lambda,alpha_bau,z,chord,r)

a=0;
a_head=0;
d_a=1;
d_ahead=1;

while d_a > 0.001 & d_ahead >0.001
    tan_phi=(1-a)/((1+a_head)*lambda);
    phi=atan(tan_phi);
    alpha=phi-alpha_bau
    [pol,coords]=xfoil(name,rad2deg(alpha),1e6,0,'oper iter 300');
    pol.CL
    C_n=pol.CL*cos(phi)+pol.CD*sin(phi);
    C_t=pol.CL*sin(phi)+pol.CD*cos(phi);
    sigma=chord*z/(2*pi*r);
    
    a_n=1/(4*sin(phi)^2/(sigma*C_n)+1);
    a_headn=1/(4*sin(phi)*cos(phi)/(sigma*C_t)-1);
    
    d_a=abs(a-a_n);
    d_ahead=abs(a_head-a_headn);
    
    a=a_n;
    a_head=a_headn;
end
disp('Lösung ist konvergiert')
