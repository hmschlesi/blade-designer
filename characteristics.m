function [lambda,omega,n,M,P,T,CM,CP,CT] = characteristics(vwind, R, z, prof)
%Computes the rotor characteristics
%P_n, M_n, CM_lambda, CT_lambda, CP_lambda

%% Constants definition
rho = 1.225; %kg/m^3 air density
Fst = rho/2*pi*R^2*vwind^2;

%% Torque calculation

%From (6.32)
dM = @(r,a,a_prime,vwind,omega,rho,F) 4*pi*r.^3*rho*vwind*omega*(1-a)*a_prime*F ;

%From (6.22)
%dM = @(r,a,a_prime,vwind,omega,rho,z,phi,chord,C_t) 1/2*rho*z*vwind*(1-a)*omega.*r.*(1+a_prime)/sin(phi)/cos(phi)*chord*C_t.*r ;

%% Thrust calculation

%From (6.31)
dT = @(r,a,vwind,rho,F) 4*pi*r.*rho*vwind^2*a*(1-a)*F ;

%From (6.21)
%dT = @(a,vwind,rho,z,phi,chord,C_n) 1/2*rho*z*vwind^2*(1-a)^2/sin(phi)^2*chord*C_n ;

%% Loop values

lambda = 1:1:14; %list of lambda values investigated
omega = lambda .* vwind ./ R ; %[rad/s]
n = 60/2/pi .* omega ; %[rpm]
[P, M, T, CM, CT, CP]=deal(zeros(1,length(lambda)));%will be computed for each lambda value


%% Defining sections limits on the blade
%The profile n°i (stored in position i+2 in user_prof because of the root)
%is considered on the section between radiuses sections_lim(i) and
%sections_lim(i+1). The maximal radius of the last section is the rotor
%radius R
sections_lim = NaN(1,length(prof)-1);
for i = 1:length(prof)-2
    sections_lim(i) = (prof(i+1).r + prof(i+2).r)/2 ;
end
sections_lim(length(prof)-1)=R;

%% Iteration on lambda for the curves

for i = 1:length(lambda) %lambda index

    [P_loc, M_loc, T_loc, CM_loc, CT_loc, CP_loc] = deal(0);

    for j = 1:(length(prof)-2)%section index

        %% BEM calculation for the section
        [a, a_prime,C_n,C_t,F,phi] = BEM(prof(j+2).name,lambda(i),prof(j+2).alpha_bau,z,prof(j+2).camber,prof(j+2).r,R,prof(j+2).Cl,prof(j+2).Cd);

        %% Local coefficients
        
        %% Torque

        %With (6.32) and integral
        M_loc(j) = integral(@(r) dM(r,a,a_prime,vwind,omega(i),rho,F) , sections_lim(j) , sections_lim(j+1) ) ;
        
        %With (6.22) and integral
        %M_loc(j) = integral(@(r) dM(r,a,a_prime,vwind,omega(i),rho,z,phi,prof(j+2).camber,C_t) , sections_lim(j) , sections_lim(j+1) ) ;
        
        %With (6.22) and sum
        %M_loc(j) = dM(prof(j+2).r,a,a_prime,vwind,omega(i),rho,z,phi,prof(j+2).camber,C_t) * (sections_lim(j+1) - sections_lim(j)) ;
        
        %% Thrust

        %With (6.31) and integral
        T_loc(j) = integral(@(r) dT(r,a,vwind,rho,F), sections_lim(j) , sections_lim(j+1)) ;
        
        %With (6.21) and sum
        %T_loc(j) = dT(a,vwind,rho,z,phi,prof(j+2).camber,C_n) * (sections_lim(j+1) - sections_lim(j)) ;
        
        %% Power and coefficients

        P_loc(j) = M_loc(j) * omega(i);
        
        CM_loc(j) = M_loc(j)/R/Fst;
        CP_loc(j) = lambda(i) * CM_loc(j);
        CT_loc(j) = T_loc(j)/Fst;

    end

    %% Global coefficients
    %M_loc(isnan(M_loc))=0;
    %T_loc(isnan(T_loc))=0;
    M(i)=sum(M_loc);
    T(i)=sum(T_loc);
    P(i)=sum(P_loc);
    CM(i)=sum(CM_loc);
    CP(i)=sum(CP_loc);
    CT(i)=sum(CT_loc);

end

end