function [pol,coords]=foil_evaluate(name, file_path, file_name)
%%evaluateds a given profile with xfoil
%might have issues with convergence, so its slighly unstable

 if regexp(name,'naca([0-9]{4})$') == 1 | regexp(name,'NACA([0-9]{4})$') == 1 
        A=readmatrix(file_path,'NumHeaderLines',1);
 elseif regexp(name,'naca([0-9]{5})$') == 1 | regexp(name,'NACA([0-9]{5})$') == 1 
        A=readmatrix(file_path,'NumHeaderLines',1);
 else
        A=readmatrix(file_path);
 end
 writematrix(A,join(['xfoil\',file_name]));
 AoA=linspace(0,20,21);
    if regexp(name,'naca([0-9]{4})$') == 1  | regexp(name,'NACA([0-9]{4})$') == 1 
        %%prüft ob ein 4-digit NACA Profil eingegeben wurde z.B. 'NACA0012'
        [pol,coords]=xfoil(name,AoA,1e5,0,join([name,' oper iter 300']));
    else
        [pol,coords]=xfoil(file_name,AoA,1e5,0,join([name,' oper iter 300']));
    end
    coords=A;