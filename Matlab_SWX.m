swApp = actxserver('SldWorks.Application');
set(swApp, 'Visible', true);
%% change to universal folder format!
O1 =invoke(swApp,'OpenDoc','C:\Users\Tom\Desktop\WEA II\Teil6.SLDPRT',1);
S1=invoke(swApp ,'RunAttachedMacro','Makro-Profil-laden.swp', 'Makro_Profil_laden1', 'main');