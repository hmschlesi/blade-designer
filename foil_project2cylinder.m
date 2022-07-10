function  A=foil_project2cylinder(A,r)
%% projects coordinates to a cylinder of given radius
%% Input dimensions and outputdimensions must agree!
%% Following Yusufs explanations and geometry
l=size(A,1);
for i=1:l
   A(i,1)=r*sin(A(i,1)/r);
   A(i,3)=r*cos(A(i,1)/r);
end