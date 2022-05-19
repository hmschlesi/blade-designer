function bladesafe(profile)
l=length(profile)

for i=1:l
   filename = strcat(profile(i).name,'_at_',num2str(profile(i).r),'m.dat');
   csvwrite(filename,[profile(i).x ; profile(i).y ; profile(i).z]');
 end

    
%%csvwrite('./blade/test.dat',profile);
