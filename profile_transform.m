
function  foil_temp=profile_transform(R,r,name,lamda_A,z, t)
%%  Profil generienren, verdrehen und verschieben für die Blattauslegung%%
%%Bei bekannten Profilen wird eine Alpha_A mit max C_l gewählt
%% R       %% Blattgesamtlänge         [m]
%% r %%Position auf dem Blatt    [m]
%% z        %% Anzahl Rotorblätter      [1]
%% alpha_A  %% Anströminkel
%% t     %% mittelpunkt der rotation bei 1/4 z.B.
%% lamda_A Schnellaufzahl
%% name;

addpath('./xfoil/');

if regexp(name,'NACA([0-9]{4})$') == 1
    %%prüft ob ein 4-digit NACA Profil eingegeben wurde z.B. 'NACA0012'
    
    alpha_A=naca_AoA_max(name)
    
    %%Airfoil daten berehcnen mit xFoil Schnittstelle
    [coeffs,foil]=xfoil(name,alpha_A,0,0.3); 

    %%Profil zum weiterrechnen in MAtrixform
    profile=horzcat(foil.x, foil.y)';

    %%Verdrehung berechnen
    theta_bld=bld_twist(R,r,lamda_A,deg2rad(alpha_A));
    %%Blatttiefe berechnen
    deep_bld=Bld_deep(R,r,lamda_A,coeffs.CL, z)

    %%Rotationsmatrix für die Verdrehnung erstellen
    R = [cos(theta_bld) -sin(theta_bld); sin(theta_bld) cos(theta_bld)];
    %%Profil verschieben und verdrehen
    profile=deep_bld*R*(profile-[t;0])

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
    foil_temp.camber=deep_bld;
    foil_temp.alpha_bau=theta_bld;
elseif regexp(name,'Cir_([0-9]+([.][0-9]*))') == 1
    d=str2double(regexp(name,'([0-9]+([.][0-9]*))','match'))
    profile=prof_circle(d,r,160);
    profile.name=name;
    foil_temp=profile;
else
    disp('Profile nicht erkannt. Anderes Profil eingeben');
end
end