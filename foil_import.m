%% imports all foils in the folder 'foils_4_import
%% imports coords and runs them trough xfoil to calculate coefficents
%% saves the coords and coefficents in the folder 'foils'
function foil_import()
listing=dir('foils_4_import');
l=length(listing);

for i=3:l
    file_folder=listing(i).folder;
    file_name=listing(i).name
    name=erase(file_name, [".txt",".dat"]);
    file_path=join(['foils_4_import\',file_name]);

%      sizeA=[2 Inf];
%      formatSpec = '%f';
%      fileID = fopen(file_path,'r');
%      A = fscanf(fileID,formatSpec,sizeA);
%      fclose(fileID);
i
    if regexp(name,'naca([0-9]{4})$') == 1 | regexp(name,'NACA([0-9]{4})$') == 1 
        A=readmatrix(file_path,'NumHeaderLines',1);
    elseif regexp(name,'naca([0-9]{5})$') == 1 | regexp(name,'NACA([0-9]{5})$') == 1 
        i+10
        A=readmatrix(file_path,'NumHeaderLines',1);
    else
        A=readmatrix(file_path);
    end
        writematrix(A,join(['xfoil\',file_name]));

    AoA=linspace(0,20,21);
    if regexp(name,'naca([0-9]{4})$') == 1  | regexp(name,'NACA([0-9]{4})$') == 1 
        %%prüft ob ein 4-digit NACA Profil eingegeben wurde z.B. 'NACA0012'
        [pol,coords]=xfoil(name,AoA,1e5,0,join([name,' oper iter 160']));
    else
        i
        [pol,coords]=xfoil(file_name,AoA,1e5,0,join([name,' oper iter 160']));
    end
    i+1

    epsilon=pol.CL./pol.CD;
    [M,I]=max(epsilon);
    AoA_eps(i-2,1)=pol.alpha(I);
    AoA_eps(i-2,2)=pol.CL(I);
    AoA_eps(i-2,3)=pol.CD(I);
    [M,I]=max(pol.CL);
    AoA_lift(i-2,1)=pol.alpha(I);
    AoA_lift(i-2,2)=pol.CL(I);
    AoA_lift(i-2,3)=pol.CD(I);
    
    
    foil_save(pol,A);
end
for i=3:l
    listing_new(i-2).name=erase(listing(i).name, [".txt",".dat"]);
end
T_temp=struct2table(listing_new);
T=table(T_temp.name, AoA_eps(:,1),AoA_eps(:,2),AoA_eps(:,3),AoA_lift(:,1),AoA_lift(:,2),AoA_lift(:,3));
T.Properties.VariableNames={'foil_name','AoA_eps','CL_eps','CD_eps','AoA_lift','CL_lift','CD_lift'};

writetable(T,'foils_imported.dat');

% file_path='foils_imported.dat';
% fileID = fopen(file_path,'w');
% formatSpec = '%s\t%s\n';
% fprintf(fileID,formatSpec,['foil name','AoA_eps']);
% formatSpec = '%s\t%f\n';
% fprintf(fileID,formatSpec,listing_new.name,AoA_eps(:,1));
% fclose(fileID);