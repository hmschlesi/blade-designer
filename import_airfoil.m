clear all, close all, clc

%% Filename

%filename = 'du84132v.dat';
%filename = 'e339.dat';
filename = 'fx76mp140.dat';

%% Import data

airfoil = readmatrix(filename);

%% Process into arrays

% l=0;
% l_up=0;
% l_down=0;
% while l==0 && (l_up==0 || l_down==0)
%     if airfoil(1,1) > 1 || airfoil(1,2) > 1
%         if airfoil(1,1) == airfoil(1,2)
%             l = airfoil(1,1);
%             airfoil(1,:)=[];
%             af_up = airfoil (1:l,:);
%             af_down = airfoil (l+1:2*l,:);
%         else
%             l_up = airfoil(1,1);
%             l_down = airfoil(1,2);
%             airfoil(1,:)=[];
%             af_up = airfoil (1:l_up,:);
%             af_down = airfoil (l_up+1:l_up+l_down,:);
%         end
%     elseif airfoil(1,1) == 0
%         l = 0;
%         while l==0
%             if airfoil (end,1) == 1 && rem(airfoil(end,1),2)==0
%                 l = airfoil (end,1)/2;
%             else
%                 airfoil(end,:)=[];
%             end
%         end
%         af_up = airfoil (1:l,:);
%         af_down = airfoil (l+1:2*l,:);
%     elseif airfoil(1,1) == 1
%         while l==0
%             if airfoil (end,1) == 0 && rem(airfoil(end,1),2)==0
%                 l = airfoil (end,1)/2;
%             else
%                 airfoil(end,:)=[];
%             end
%         end
%         af_up = airfoil (1:l,:);
%         af_down = airfoil (l+1:2*l,:);
%     else
%         airfoil (1,:)=[];
%     end
% end

%% Process into arrays (better version)

af_type = '';
af_defined = false; %loop stop initialisation

while ~ af_defined
    if (airfoil(1,1) > 1) && (airfoil(1,2) > 1) %if range defined
        af_type = 'up & down';
        l_up = airfoil(1,1); %up side length
        l_down = airfoil(1,2); %down side length
        airfoil(1,:)=[];
        af_up = airfoil (1:l_up,:);
        af_down = airfoil (l_up+1:l_up+l_down,:);
        af_defined = true;

    elseif 0<=airfoil(1,1) && airfoil(1,1)<=1 && -1<airfoil(1,2) && airfoil(1,2)<1
        af_type = 'one line';
        while ~ (0<=airfoil(end,1) && airfoil(end,1)<=1 && -1<airfoil(end,2) && airfoil(end,2)<1)
            airfoil(end,:)=[]; %clean last line if not well defined
        end
        af = airfoil;
         af_defined = true;

    else
        airfoil(1,:)=[]; %clean first line if not well defined
    end
end