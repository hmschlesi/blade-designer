
function  foil_temp=profile_transform(R,r,name,lamda_A,z, t,foil_db)
%%  Profil generienren, verdrehen und verschieben für die Blattauslegung%%
%%Bei bekannten Profilen wird eine Alpha_A mit max C_l gewählt
%% R       %% Blattgesamtlänge         [m]
%% r %%Position auf dem Blatt    [m]
%% z        %% Anzahl Rotorblätter      [1]
%% alpha_A  %% Anströminkel
%% t     %% mittelpunkt der rotation bei 1/4 z.B.
%% lamda_A Schnellaufzahl
%% name;


Index =find(strcmp(name,foil_db.foil_name))

    profile=readmatrix(join(['imported\',name,'_coords.dat']))'
    %%Verdrehung berechnen
      theta_bld=bld_twist(R,r,lamda_A,foil_db.AoA_eps(Index))
    %%Blatttiefe berechnen
      deep_bld=Bld_deep(R,r,lamda_A,foil_db.CL_eps(Index), z)

    %%Rotationsmatrix für die Verdrehnung erstellen
      rot_angle=theta_bld+deg2rad(foil_db.AoA_eps(Index))
      R = [cos(rot_angle) -sin(rot_angle); sin(rot_angle) cos(rot_angle)];
    %%Profil verschieben und verdrehen
      profile=deep_bld*R*(profile-[t;0]);

    %%die z Koordinate des profiles hinzufügen
     len=length(profile);
     profile=[profile; ones(1,len)*r]

    foil_temp.x=profile(1,:);
    foil_temp.y=profile(2,:);
    foil_temp.z=profile(3,:);
    foil_temp.name=name
    foil_temp.Cl=foil_db.CL_eps(Index);
    foil_temp.Cd=foil_db.CD_eps(Index);
    foil_temp.r=r;
    foil_temp.camber=deep_bld;
    foil_temp.alpha_bau=theta_bld;
% elseif regexp(name,'Cir_([0-9]+([.][0-9]*))') == 1
%     d=str2double(regexp(name,'([0-9]+([.][0-9]*))','match'))
%     profile=prof_circle(d,r,160);
%     profile.name=name;
%     foil_temp=profile;
% else
%     disp('Profile nicht erkannt. Anderes Profil eingeben');
% end
% end