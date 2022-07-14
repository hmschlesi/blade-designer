function [lambda,omega,n,M,P,CM,CP] = characteristics(vwind, R)
%Computes the rotor characteristics
%P_n, M_n, CM_lambda, CT_lambda, CP_lambda

rho = 1.225; %kg/m^3 air density
Fst = rho/2*pi*R^2*vwind^2;
dM = @(r,a,a_prime,vwind,omega) 4*pi*r.^3*vwind*omega*(1-a)*a_prime ;


lambda = 1:0.25:13 ;%list of lambda values investigated
omega = lambda .* vwind ./ R ; %[rad/s]
n = 60/2/pi .* omega ; %[rpm]
[P, M, CM, CT, CP]=deal(zeros(1,length(lambda)));%will be computed for each lambda value

for i = 1:length(lambda)

    %[a, a_prime,~,~] = BEM(); to be completed

    M(i) = integral(@(r) dM(r,a,a_prime,vwind,omega(i)) , 0 , R) ;
    P(i) = M(i) * omega(i);
    CM(i) = M(i)/R/Fst;
    CP(i) = lambda(i) * CM(i);

end

%T = ?
%CT(i) = T/Fst;

end