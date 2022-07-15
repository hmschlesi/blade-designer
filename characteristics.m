function [lambda,omega,n,M,P,T,CM,CP,CT] = characteristics(vwind, R, z, prof)
%Computes the rotor characteristics
%P_n, M_n, CM_lambda, CT_lambda, CP_lambda

rho = 1.225; %kg/m^3 air density
Fst = rho/2*pi*R^2*vwind^2;
dM = @(r,a,a_prime,vwind,omega,rho) 4*pi*r.^3*rho*vwind*omega*(1-a)*a_prime ;
dT = @(r,a,v_wind,rho) 4*pi*r.*rho*v_wind^2*a*(1-a) ;

%lambda = 1:0.25:13 ;%list of lambda values investigated
lambda = 5:0.5:9;
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

for i = 1:length(lambda)

    for section_nr = 1:(length(prof)-2)

        %BEM calculation for the section
        [a, a_prime,~,~] = BEM(prof(i+2).name,lambda(i),prof(i+2).alpha_bau,z,prof(i+2).camber,prof(i+2).r,R,prof(i+2).Cl,prof(i+2).Cd);

        %Local coefficients
        [P_loc, M_loc, T_loc, CM_loc, CT_loc, CP_loc] = deal(0);

        M_loc(section_nr) = integral(@(r) dM(r,a,a_prime,vwind,omega(i)) , sections_lim(section_nr) , sections_lim(section_nr)+1 ) ;
        T_loc(section_nr) = integral(@(r) dT(r,a,vwind,rho), sections_lim(section_nr) , sections_lim(section_nr)+1) ;
        P_loc(section_nr) = M_loc(section_nr) * omega(i);
        CM_loc(section_nr) = M_loc(section_nr)/R/Fst;
        CP_loc(section_nr) = lambda(i) * CM_loc(section_nr);
        CT_loc(section_nr) = T_loc(section_nr)/Fst;

    end

    %Global coefficients
    M(i)=sum(M_loc);
    T(i)=sum(T_loc);
    P(i)=sum(P_loc);
    CM(i)=sum(CM_loc);
    CP(i)=sum(CP_loc);
    CT(i)=sum(CT_loc);

end

end