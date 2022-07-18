function blade_save(profiles,folder,file)
%% saves a profile structure with given profiles to a yaml file
%%uses +yaml https://github.com/ewiger/yamlmatlab
filepath=join([folder,file])

if ~exist(folder, 'dir')
       mkdir(folder)
end
yaml.WriteYaml(filepath,profiles);
