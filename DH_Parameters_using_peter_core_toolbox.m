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

%% DH Parameters using Peter Core Robotics toolbox
% Rhino XR1 Dim
L1 = 10.25; L2=9 ; L3=9; L5=6.25;

% Create Link using this code
% L = Link([th d a alph])
L(1) = Link([0 L1 0 pi/2]);
L(2) = Link([0 0 L2 0]);
L(3) = Link([0 0 L3 0]);
L(4) = Link([0 0 0 pi/2]);
L(5)=Link([0 L5 0 0]);

Rob = SerialLink(L)
Rob.name='Rhino XR1';

q1=0 ; q2=0 ; q3=0 ; q4=0 ;q5=0;
Rob.plot([q1,q2,q3,q4,q5])

Rob.fkine([q1,q2,q3,q4,q5])
Rob.teach
syms th1 th2 th3 th4 th5

%% Animation
for th = 0:0.1:pi
    Rob.plot([th th th th th])
    pause(0.05)
end
