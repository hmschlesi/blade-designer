function t=bld_deep(R,r,lamda_A,c_L,z)
%% Baltttiefe nach Schmitz, Vgls Pasch S.206
%% Ausgabe in m
%%lamda_A Schnellaufzahl           [1] lambda=2*pi*n*r/v_0
%%R Rotor-radius             [m]
%%r Position auf dem Rotor   [m]
%%c Auftriebsmoment           [1]
%%z ANzahl Rotorblätter      [1]
alpha_1=atan(R./(lamda_A.*r));
t_schmitz=16.*pi.*lamda_A.*r./R.*sin(1./3.*alpha_1).^2;
t=t_schmitz.*R/(lamda_A.*z.*c_L);            %% wirkliche Blatttiefe [m]
end