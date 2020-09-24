%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This code is to construct the f-L curve for the inhomogeneous model
%%% with free-hinged BC. The equations to be solved is coded in 'shape.m'.

%%% File explanation:
%%% 1. 'terminate1.m' and 'terminate2.m' set the terminating event
%%% function in the ode45 solver. They actually encode the free-hinge BC.
%%% 2. 'BC.m' encodes the other boundary condition R = Rb and L = L0 and sigma = sigma_e.
%%% 3. 'shape.m' encodes the shape equations of membrane

%%% Output of the code is a txt file which has five columns
%%%      f        dpsi0        sigma0      L       dis
%%% The 5th column represents deviation from the boundary condition
%%% We only pick up solutions for which dis < 1e-6

%%% Latest Update by Rui Ma on 2020-9-24

clear;

% Parameters are nondimensionalized
p = 0.5;        % Turgor pressure
sigma_e = 0.001;  % Surface tension
C0 = 1.0;       % Spontaneous curvature
a0 = 1;
Rb = 2;         % Base radius

reverse = 0; % direction of the increment

fileID = fopen(['./force_height_curve_',...
    'C0_', num2str(C0),...
    '_a0_',num2str(a0),...
    '_sigmaEnd_',num2str(sigma_e),...
    '_Rb_',num2str(Rb),...
    '_reverse_',num2str(reverse),'.txt'],'w');


Z0 = 1;

if reverse
    Zc = Z0:-0.001:0;
else
    Zc = Z0:0.001:8;
end

R0 = 0.001;     % Initial values
psi0 = 0;

% Initial trial of (f,dpsi,sigma)
% The initial trials need to be tuned by hand.

                 
f = 0.3988241836;
dpsi0 = 3.6997998150;
sigma0 = -0.1285352490;
x0 = [f,dpsi0,sigma0];


options_min = optimset('fminsearch');
options_min.DiffMaxChange = 1e-6;
options_min.DiffMinChange = 1e-6;
options_min.TolFun = 1e-6;
options_min.TolX = 1e-6;


for Z = Zc
    sprintf('Now at membrane height L = %f.\n',Z)
    [x,fval] = fminsearch(@(x) BC(x,p,sigma_e,C0,R0,a0,Z,Rb),x0,options_min);
    x0 = x;
    fprintf(fileID,'%20.10f %20.10f %20.10f %20.10f %20.10f\n',[x,Z,fval]);
end



