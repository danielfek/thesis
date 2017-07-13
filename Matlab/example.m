%% Solve the Cake eating problem

clc
clear
close all

%% Define Numerical Parameters
mpar.nk   = 100;  % number of points on the capital grid
mpar.nz   = 1;    % number of points on the productivity grid
mpar.mink = 0.1;  % lowest point on the capital grid
mpar.maxk = 2;    % highest point on the capital grid
mpar.crit = 1e-4; % Precision up to which to solve the value function

%% Define Economic parameters
par.beta  = 0.95; % Discount factor
par.alpha = 1;    % Curvature of production function
par.gamma = 1;    % Coefficient of relative risk aversion
par.delta = 1;    % Depreciation
par.cmin  = exp(-6.5);

prob.z     = 1;    % Transition probabilities for productivity
%% Display Model
TablePar={'Discount Factor:', par.beta; 'Returns to Scale', par.alpha; ...
    'Relative Risk Aversion', par.gamma; 'Depreciation', par.delta};

TablePar
%% Define utility functions

if par.gamma ==1
    util  = @(c)log(c);
    mutil = @(c) 1./c;
else
    util  = @(c) 1/(1-par.gamma).*c.^(1-par.gamma);
    mutil = @(c) 1./(c.^par.gamma);
end

%% Produce grids
grid.k = exp(linspace(log(mpar.mink),log(mpar.maxk),mpar.nk));
grid.z = 1;

%% Calculate Consumption and Utility for Capital Choices
[meshes.k,  meshes.kprime, meshes.z]= ndgrid(grid.k,grid.k,grid.z);
Y = meshes.z.*meshes.k.^par.alpha + (1-par.delta).*meshes.k;
C = Y-meshes.kprime;

U      = util(C); %Dimensions k x k' x z
U(C<0) = -Inf; % Disallow negative consumption
U(C>=0&C<par.cmin) = util(par.cmin); % Rig consumption level for the lowest consumption

%% Value Function Iteration

V     = zeros(mpar.nk,mpar.nz);
dist  = 9999;
count = 1;
while dist(count)>mpar.crit
    count       = count+1;                % count the number of iterations
    EV          = par.beta* V* prob.z';   % Calculate expected continuation value
    EVfull      = repmat(reshape(EV,[1 mpar.nk mpar.nz]),[mpar.nk 1 1]); % Copy Value to second dimension
    Vnew        = max(U + EVfull,[],2);   % Update Value Function
    dist(count) = max(abs(Vnew(:)-V(:))); % Calculate distance between old guess and update
    V           = squeeze(Vnew);          % Copy update to value function
end

%% Produce Policy functions
[~,policy]  = max(U + EVfull,[],2);
kprime      = grid.k(squeeze(policy));

%% Plots

figure(1)
semilogy((dist(2:end)))
title('Distance between two updates of V -logscale')

figure(2)
plot(grid.k,kprime)
hold on
plot(grid.k,grid.k,'k--')
legend({'Capital policy','45 degree line'})
