function foil_save(pol,coords)
%%save structure array from xfoil to .dat
name=join(['imported\',pol.name,'.dat'])
fileID = fopen(name,'w');
formatSpec = 'name: %s\n Re: %e\n Ncrit: %d\n';
fprintf(fileID,formatSpec,pol.name, pol.Re, pol.Ncrit);
formatSpec = '%s\t%s\t%s\t%s\n';
fprintf(fileID,formatSpec,'alpha', 'CL','CD','Cm');
formatSpec = '%f\t%f\t%f\t%f\n';
fprintf(fileID,formatSpec, [pol.alpha, pol.CL, pol.CD, pol.Cm]);
fclose(fileID);





