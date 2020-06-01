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

%% Frame Translation in 2D
%% setting up base
HBaseBase = se2(0,0,0);
trplot2(HBaseBase,'frame','Base','color','r','arrow');
hold on

%% Camera wrt Base
HCamBase= se2(1,2,0);
HBaseCam = inv(HCamBase);
trplot2(HCamBase,'frame','camera','color','b','arrow');
grid
hold on

%% Robot wrt Base
HRobotBase=se2(3,4,0);
HBaseRobot = inv(HRobotBase);
hold on
trplot2(HRobotBase,'frame','Robot','color','r','arrow');
axis([0 6 0 6]);

%% Point P wrt Base
PBase=[4;3];
plot_point(PBase,'*');


%% Point P wrt Robot
PRobot = HBaseRobot * e2h(PBase)

%% Point P wrt Camera
PCam = HBaseCam * e2h(PBase)



