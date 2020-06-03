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

%% Frame transformation in 3D
%% Creating a translation matrix with displacement 1 , 2 ,3 in x y z direction
A =transl(1,2,3)

%% Creating a rotation matrix with rotation of pi in about x direction (3*3 matrix)
B =rotx(pi)

%% Creating a rotation matrix with rotation of pi in about x direction (4*4 matrix)
C =trotx(pi)

%% Creating a diagonal matrix and ploting it
base = eye(4)
trplot(base,'frame','0','color','b','arrow');

%% moving from frame 1 to frame 0
H10 = transl(0,0,1)*trotx(pi/2)*trotz(-pi/2)
hold on
trplot(H10,'frame','1','color','r','arrow')

%% moving from frame 2 to 0
H20 = transl(0,1,0)*trotz(-pi/2)*trotx(pi/2)
hold on
trplot(H20,'frame','2','color','g','arrow');

%% frame 2 wrt 1
H12 = inv(H20)*H10
% or
H12m = transl(1,1,0) * troty(pi/2) * trotz(-pi/2)

%% Ploting point p
p0= [0;0;1;1]
H01 = inv(H10)
p1 = H01 * p0
H02 = inv(H20)
p2 = H02 * p0

%% animation
tranimate(H20);
tranimate(H10);

