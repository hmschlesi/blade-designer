function blade_save(profile)
folder='Tool\profiles';

l=length(profile)

if not(isfolder(folder))
    mkdir(folder)
else
    rmdir(folder,'s')
    mkdir( folder)
end

for i=1:l
   A=[profile(i).x; profile(i).y; profile(i).z]'
   if A(end,:) ~= A(1,:)
        A(end+1,:)=A(1,:)
   end
  %% filename = strcat(folder,'\',num2str(i),'_',profile(i).name,'_at_',num2str(profile(i).r),'m.txt')
  filename = strcat(folder,'\',num2str(i),'.txt')

    fileID = fopen(filename,'w');
    formatSpec = '%f\t%f\t%f\n';
    for ii = 1:size(A,1)
        fprintf(fileID,formatSpec,[A(ii,1), A(ii,2) A(ii,3)]);
    end
    fclose(fileID);
end