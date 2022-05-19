function prof=bld_sort(profiles)
%%sortiert eine Satz an Profilen nach Blattposiiton aufsteigend.
for k=1:length(profiles)
    pos(k) = profiles(k).r(1);
end
[pos,idx]=sort(pos);
for k=1:length(idx)
    idx(1,k);
    prof(k)=profiles(idx(1,k));
end