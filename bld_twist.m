function twist=bld_twist(R,r,lamda_A,alpha_A )
%%   %%Blattverdrehung nach Betz , Vgl. Gosch S.210
%% outpiut in Radians, NOT in degrees
%% alpha_A Anstellwinkel [°]
%% lamda_A Schnellaufzahl [1] lambda=2*pi*n*r/v_0
%% R=50 Rotor-radius [m]
%% r Position auf dem Rotor [m] 
twist=2./3.*atan(R./(lamda_A.*r))-alpha_A;
end