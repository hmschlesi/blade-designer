function [C_l,C_d] = read_pol(name,alpha)
%read_pol read the polars of a profile
%   Detailed explanation goes here

addpath("imported\")
%addpath("foils_4_import_pol\")

polars = readmatrix(name+"_pol.dat");

line = 1;
alpha_under = polars(line,1);
alpha_over = polars(line+1,1);

if alpha < alpha_under %if AoA lower than range
    disp("The angle of attack is too low")
    C_l = polars(1,2) ;
    C_d = polars(1,3) ;
elseif polars(size(polars,1),1) < alpha % if AoA higher than range
    disp("The angle of attack is too high")
    C_l = polars(size(polars,1),2) ;
    C_d = polars(size(polars,1),3) ;
else
    while ~ (alpha_under <= alpha && alpha < alpha_over) && line < size(polars,1)-1
        line = line+1;
        alpha_under = polars(line,1);
        alpha_over = polars(line+1,1);
    end
    
    if polars(line,1)==alpha %if exact value
        C_l = polars(line,2) ;
        C_d = polars(line,3) ;
    else
        alpha_1 = polars(line,1);
        alpha_2 = polars(line+1,1);
        Cl_1 = polars(line,2);
        Cl_2 = polars(line+1,2);
        Cd_1 = polars(line,3);
        Cd_2 = polars(line+1,3);
        % linear interpolation
        C_l = Cl_1+(alpha-alpha_1)*(Cl_2-Cl_1)/(alpha_2-alpha_1);
        C_d = Cd_1+(alpha-alpha_1)*(Cd_2-Cd_1)/(alpha_2-alpha_1);
    end
end

end