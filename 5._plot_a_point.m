%% How to run this code
% Download and Install Robotics toolbox 9.4 form Petercore website and run the
% startup_rvc file.
%For more details on Toolbox, information is available on youtube
% Run this file.

disp('Robotics, Vision & Control: (c) Peter Corke 1992-2011 http://www.petercorke.com')

if verLessThan('matlab', '7.0')
    warning('You are running a very old (and unsupported) version of MATLAB.  You will very likely encounter significant problems using the toolboxes but you are on your own with this');
end
tb = false;
rvcpath = fileparts( mfilename('fullpath') );

robotpath = fullfile(rvcpath, 'robot');
if exist(robotpath,'dir')
    addpath(robotpath);
    tb = true;
    startup_rtb
end

visionpath = fullfile(rvcpath, 'vision');
if exist(visionpath,'dir')
    addpath(visionpath);
    tb = true;
    startup_mvtb
end

if tb
    addpath(fullfile(rvcpath, 'common'));
    addpath(fullfile(rvcpath, 'simulink'));
end

clear tb rvcpath robotpath visionpath

%% representing_Position _and_orientation_in_2D 
%% first frame

T1 = se2(1, 2, 30*pi/180);
trplot2(T1,'frame','l','color','r');
axis([0 6 0 6]);
grid on

%% Second frame

T2 = se2(2,1,0);
hold on
trplot2(T2,'frame','II','color','k');

%% Multiplication of frame 1 and 2

T3 = T1*T2;
trplot2(T3,'frame','III','color','b');

%% Multiplication of frame 2 and 1
% If we multiply the frames other way around like T2*T1, the result will be
% different
T4 = T2*T1;
trplot2(T4,'frame','IV','color','g');

%% Plot a point
p= [2;3];
plot_point(p,'*');







