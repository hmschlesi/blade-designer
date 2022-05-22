function bld_plot(profiles)
%%Plotet einen Satz profile in 3d
l=length (profiles)
for n=1:l
    plot3(profiles(n).x, profiles(n).y, profiles(n).z,'k')
    hold on
    axis equal
end
hold off