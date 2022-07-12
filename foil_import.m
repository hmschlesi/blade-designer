%% imports all foils in the folder 'foils_4_import
%% imports coords and runs them trough xfoil to calculate coefficents
%% saves the coords and coefficents in the folder 'foils'
function foil_import()
listing=dir('foils_4_import');
foil_db_path='foils_imported.dat'
l=length(listing);

for i=3:l
    file_folder=listing(i).folder;
    file_name=listing(i).name;
    name=erase(file_name, [".txt",".dat"])
    file_path=join(['foils_4_import\',file_name]);
%% checks if foil_db exists
    if isfile(foil_db_path)
        
        foil_db=readtable(foil_db_path);
        Index =find(strcmp(name,foil_db.foil_name));
        if isempty(Index)
           
             [pol,A]=foil_evaluate(name, file_path,file_name);

            epsilon=pol.CL./pol.CD;
            [M,I]=max(epsilon);
            AoA_eps(1,1)=pol.alpha(I);
            AoA_eps(1,2)=pol.CL(I);
            AoA_eps(1,3)=pol.CD(I);
            [M,I]=max(pol.CL);
            AoA_lift(1,1)=pol.alpha(I);
            AoA_lift(1,2)=pol.CL(I);
            AoA_lift(1,3)=pol.CD(I);

            T=table(string(name), AoA_eps(1,1),AoA_eps(1,2),AoA_eps(1,3),AoA_lift(1,1),AoA_lift(1,2),AoA_lift(1,3));
            T.Properties.VariableNames={'foil_name','AoA_eps','CL_eps','CD_eps','AoA_lift','CL_lift','CD_lift'};
            foil_db=[foil_db;T];
            writetable(foil_db,foil_db_path);
            disp(join(['Profil ',name,' wurde importiert']))
        else
            disp('foil already imported')
        end
        
    else
        %% checks if foil_db exists
        [pol,A]=foil_evaluate(name, file_path,file_name);

        epsilon=pol.CL./pol.CD;
        [M,I]=max(epsilon);
        AoA_eps(1,1)=pol.alpha(I);
        AoA_eps(1,2)=pol.CL(I);
        AoA_eps(1,3)=pol.CD(I);
        [M,I]=max(pol.CL);
        AoA_lift(1,1)=pol.alpha(I);
        AoA_lift(1,2)=pol.CL(I);
        AoA_lift(1,3)=pol.CD(I);
        
        T=table(string(name), AoA_eps(1,1),AoA_eps(1,2),AoA_eps(1,3),AoA_lift(1,1),AoA_lift(1,2),AoA_lift(1,3));
        T.Properties.VariableNames={'foil_name','AoA_eps','CL_eps','CD_eps','AoA_lift','CL_lift','CD_lift'};    

        writetable(T,foil_db_path);

    
        foil_save(pol,A,name);
    end
end
for i=3:l
    listing_new(i-2).name=erase(listing(i).name, [".txt",".dat"]);
end
%T_temp=struct2table(listing_new);
%T=table(T_temp.name, AoA_eps(:,1),AoA_eps(:,2),AoA_eps(:,3),AoA_lift(:,1),AoA_lift(:,2),AoA_lift(:,3));
%T.Properties.VariableNames={'foil_name','AoA_eps','CL_eps','CD_eps','AoA_lift','CL_lift','CD_lift'};

%writetable(T,'foils_imported.dat');

% file_path='foils_imported.dat';
% fileID = fopen(file_path,'w');
% formatSpec = '%s\t%s\n';
% fprintf(fileID,formatSpec,['foil name','AoA_eps']);
% formatSpec = '%s\t%f\n';
% fprintf(fileID,formatSpec,listing_new.name,AoA_eps(:,1));
% fclose(fileID);