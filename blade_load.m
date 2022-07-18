function B= blade_load(filepath,file)
A=yaml.ReadYaml(filepath)
for i=1:length(A)
    if i==1
        B=A{i};
         B.x=cell2mat(B.x)
         B(i).y=cell2mat(B(i).y)
        B(i).z=cell2mat(B(i).z)
    else
        B(i)=A{i};
        B(i).x=cell2mat(B(i).x)
        B(i).y=cell2mat(B(i).y)
        B(i).z=cell2mat(B(i).z)
    end
        
end