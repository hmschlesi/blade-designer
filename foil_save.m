function foil_save(pol,coords,fname)

%% AoA für max. Gleitzahl ermitteln
epsilon=pol.CL./pol.CD;
[M,I]=max(epsilon);
AoA_eps=pol.alpha(I);
CL_eps=pol.CL(I);
CD_eps=pol.CD(I);
[M,I]=max(pol.CL);
AoA_lift=pol.alpha(I);
CL_lift=pol.CL(I);
CD_lift=pol.CD(I);
A=[pol.alpha, pol.CL, pol.CD,pol.Cm];

%%save polar data from xfoil to .dat
name=join(['imported\',fname,'_pol.dat'])
fileID = fopen(name,'w');
formatSpec = 'name: %s\nRe: %e\nNcrit: %d\nAoA_eps: %f\nCL_eps: %f\nCD_eps: %d\nAoA_lift: %f\nCL_lift: %f\nCD_lift: %d\n ';
fprintf(fileID,formatSpec,pol.name, pol.Re, pol.Ncrit, AoA_eps, CL_eps, CD_eps,AoA_lift, CL_lift, CD_lift);
formatSpec = '%s\t%s\t%s\t%s\n';
fprintf(fileID,formatSpec,'alpha', 'CL','CD','Cm');
formatSpec = '%f\t%f\t%f\t%f\n';
for ii = 1:size(A,1)
    fprintf(fileID,formatSpec,[A(ii,1), A(ii,2),A(ii,3),A(ii,4)]);
end
fclose(fileID);

%%save coords to .dat
name=join(['imported\',fname,'_coords.dat'])
fileID = fopen(name,'w');
formatSpec = 'name: %s\n';
fprintf(fileID,formatSpec,pol.name);
formatSpec = '%s\t%s\n';
fprintf(fileID,formatSpec,'x', 'y');
formatSpec = '%f\t%f\n';
for ii = 1:size(coords,1)
    fprintf(fileID,formatSpec,[coords(ii,1), coords(ii,2)]);
end

fclose(fileID);








