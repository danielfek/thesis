%% Aiyagari Model with no borrowing constraint. 
clc; 
clear; close all

global value_aiyagari

%% 1. Define parameters
% Numerical parameters
mpar.nk   = 50; % Number of points on the asset grid
mpar.nz   = 2; % Number of points on the log-income grid
mpar.crit = 1e-6; % Numerical precision
mpar.maxk = 3000; % 
mpar.maxk = 300; % tighter grid that works fine!
mpar.mink = 0.01;

% Economic Parameters
par.gamma = 1;     % Coeffcient of relative risk aversion
par.beta = 95/100;   % Discount factor
par.delta = 10/100;   % Depreciation
par.alpha= 1/3;     % Output-capital elasticity

%% Generate grids
gri.k     = exp(linspace(log(mpar.mink),log(mpar.maxk),mpar.nk));  %Define asset grid on log-linearspaced
%prob.z    = [0.5 0.5;0.925 0.075];
prob.z     = [0.7 0.3; 0.3 0.7];
%prob.z = [8/10 2/10;2/10 8/10];
gri.z     = [1 2];

%%% lower income risk (but same mean)
%fprintf('Solve model with less income risk \n')
%mup = prob.z^999; mup = mup(1,:)';
%muz = gri.z*mup;
%gri.z     = [muz/mup(1)/10 1-muz/mup(2)/10]; %low-risk grid 


%% Meshes and Cash at Hand (Y)
[meshes.k,  meshes.z]= ndgrid(gri.k,gri.z);

%% Define utility functions / marginal utility
if par.gamma ==1
    util  = @(c)log(c);
    mutil = @(c) 1./c;
else
    util  = @(c) 1/(1-par.gamma).*c.^(1-par.gamma);
    mutil = @(c) 1./(c.^par.gamma);
end

%% Initialize Value and Policy Functions
value_aiyagari = zeros(mpar.nk,mpar.nz);

%%
fun_excess = @(r)Aiyagari(r,mpar,par,gri,prob,meshes,util,mutil);
%options = optimset('tolX',1e-6);
options = optimset('display','iter','TolX',1e-8,'MaxIter',20);
r_interval = [0.01 (1-par.beta)/par.beta]; %upper bound: complete market eqm rate
%r_interval = [0.010 0.030];  % speed-up
% r_interval = [0.012 0.018];  % speed-up
% r_interval = [0.015 0.0155];  % speed-up
[r_aiyagari,fval,exitflag,output] = fzero(fun_excess,r_interval,options);

fprintf('Done!\n')



