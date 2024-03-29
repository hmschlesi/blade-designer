function [pol,coords]=foil_importpol(name)
%%imports coordinates and polar data from airfoiltools.com .dat file
folder='foils_4_import_pol\';
filepath_pol=join([folder,name,'_pol.dat']);
filepath_coords=join([folder,name,'.dat']);

opts = detectImportOptions(filepath_pol);
opts.VariableNamesLine = 10;
opts.DataLines = [12 Inf];
pol=readtable(filepath_pol,opts);
%%pol=renamevars(pol,["Cl","Cd","Alpha"],["CL","CD","alpha"]);
%%pol=[pol.Alpha,pol.Cl,pol.Cd,pol.Cm]


coords=readmatrix(filepath_coords,'NumHeaderLines',1);

%work trough the header line by line
fileID=fopen(filepath_pol,'r');
%line 1
tline = fgetl(fileID);
%line 2
tline = fgetl(fileID);
%line 3
tline = fgetl(fileID);
%line 4
 tline = fgetl(fileID);
% string=convertCharsToStrings( split(tline,","));
% Re=str2num(string(2,1));
%line 5
 tline = fgetl(fileID);
% string=convertCharsToStrings( split(tline,","));
% Ncrit=str2num(string(2,1));
%line 6
 tline = fgetl(fileID);
% string=convertCharsToStrings( split(tline,","));
 %Ma=str2num(string(2,1));
%line 7
tline = fgetl(fileID);
%line 8
tline = fgetl(fileID);
string=convertCharsToStrings( split(tline,["=", "  "]));
string=erase(string," ");
Ma=str2num(string(3,1));
Re=str2num(string(8,1));
Ncrit=str2num(string(12,1));

fclose(fileID)
pol=table2struct(pol,"ToScalar",true);
pol.name=name;
pol.Re=Re;
pol.Ncrit=Ncrit;

