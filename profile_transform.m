
function  foil_temp=profile_transform(R,r,name,lamda_A,z, alpha_A, t)
%%  Profil generienren, verdrehen und verschieben für die Blattauslegung%%
%% R       %% Blattgesamtlänge         [m]
%% r %%Position auf dem Blatt    [m]
%% z        %% Anzahl Rotorblätter      [1]
%% alpha_A  %% Anströminkel
%% t     %% mittelpunkt der rotation bei 1/4 z.B.
%% lamda_A Schnellaufzahl
%% name;

addpath('./xfoil/');
%%Airfoil daten berehcnen mit xFoil Schnittstelle
[coeffs,foil]=xfoil(name,alpha_A,0,0.3); 
c_L=coeffs.CL;       %%Auftriebsbeiwert aus der xfoil berechnung

%%Profil zum weiterrechnen in MAtrixform
profile=horzcat(foil.x, foil.y)';

%%Verdrehung berechnen
theta_bld=bld_twist(R,r,lamda_A,deg2rad(alpha_A));
%%Blatttiefe berechnen
deep_bld=Bld_deep(R,r,lamda_A,c_L, z);

%%Rotationsmatrix für die Verdrehnung erstellen
R = [cos(theta_bld) -sin(theta_bld); sin(theta_bld) cos(theta_bld)];
%%Profil verschieben und verdrehen
profile=deep_bld*R*(profile-[t;0]);

%%die z Koordinate des profiles hinzufügen
len=length(profile);
profile=[profile; ones(1,len)*r];

foil_temp.x=profile(1,:);
foil_temp.y=profile(2,:);
foil_temp.z=profile(3,:);
foil_temp.name=coeffs.name;
foil_temp.Cl=coeffs.CL;
foil_temp.Cd=coeffs.CD;
foil_temp.Cdp=coeffs.CDp;
foil_temp.Cm=coeffs.Cm;
foil_temp.r=r;
end