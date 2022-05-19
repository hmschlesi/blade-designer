function existing=check_existing(profiles,R)
%% Prüft ein gegebene Sammlung an Profilen, ob an der Stelle R 
%%bereits ein Eintrag vorhanden ist. 
%%Ausgabe in boolean, Profil vorhanden >1, nicht vorhanden >0
for k=1:length(profiles)
    radii(k) = profiles(k).r(1);
end
existing=not(isempty(intersect(radii,R)))