currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );
swApp = actxserver('SldWorks.Application');
set(swApp, 'Visible', true);
O1 =invoke(swApp,'OpenDoc',append(pathstr,'\Teil6.SLDPRT'),1);
S1=invoke(swApp ,'RunAttachedMacro','Makro-Profil-laden.swp', 'Makro_Profil_laden1', 'main');