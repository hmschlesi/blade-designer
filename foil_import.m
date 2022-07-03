%% imports all foils in the folder 'foils_4_import
%% imports coords and runs them trough xfoil to calculate coefficents
%% saves the coords and coefficents in the folder 'foils'
function [pol,coords]=foil_import()
listing=dir('foils_4_import');
l=length(listing);

i=1;
i=i+2

file_folder=listing(i).folder;
file_name=listing(i).name
name=erase(file_name, [".txt",".dat"])
file_path=join(['foils_4_import\',file_name])

% sizeA=[2 Inf];
% formatSpec = '%f';
% fileID = fopen(file_path,'r');
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
A=readmatrix(file_path);

writematrix(A,join(['xfoil\',file_name]))

AoA=linspace(-10,20,31);

iniTime = clock;
limit   = 10;  % Seconds 
while etime(clock, iniTime) < limit
    [pol,coords]=xfoil(file_name,AoA,1e6,0,join([name,' oper iter 160']));
end
foil_save(pol,coords);