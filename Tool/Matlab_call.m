currentFile = mfilename( 'fullpath' );
[pathstr,~,~] = fileparts( currentFile );
swApp = actxserver('SldWorks.Application');
set(swApp, 'Visible', true);
M1 = invoke(swApp, 'SetCurrentWorkingDirectory', pathstr);
S1 = invoke(swApp, 'RunMacro', strcat(pathstr, '\Makro-Profil-laden.swp'), 'Makro_Profil_laden1', 'main');
