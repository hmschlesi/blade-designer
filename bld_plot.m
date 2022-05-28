function  bld_plot(profiles)
%%Plotet einen Satz profile in 3d
l=length (profiles)
for n=1:l
  plot3(profiles(n).z, profiles(n).y, profiles(n).x,'k');
    hold on
    axis equal
    text(profiles(n).z(1), profiles(n).y(1), profiles(n).x(1)+1,profiles(n).name)
end
hold off
