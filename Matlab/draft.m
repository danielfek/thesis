clc
clear
close all

%% Parameters and functional forms

alpha  = 1/3;                   % capital income share
b      = 0;                     % borrowing constraint
%betta  = 98/100;                % discount factor
%thetta = 2.857/100             % probability of dying
%beta   = betta*(1-thetta);      % subjective discount factor
beta   = 97/100;
delta  = 5/100;                 % depreciation rate of physical capital
gamma  = 1;                   % inverse elasticity of intertemporal substitution
rho    = 8/10;                  % persistence parameter prodictivity
N      = 2;                     % number of possible productivity realizations
y1     = 1/2;                % low productivity realization
y2     = 2/3;               % high productivity realization
%y1     = 95/100;                % low productivity realization
%y2     = 105/100;               % high productivity realization

% transition probability matrix (productivity)
pi     = zeros(N,N);

% probabilities have to sum up to 1
pi(1,1) = rho;                  % transition from state 1 to state 1
pi(1,2) = 1-rho;                % transition from state 2 to state 1
pi(2,1) = 1-rho;                % transition from state 1 to state 2
pi(2,2) = rho;                  % transition from state 2 to state 2

% (inverse) marginal utility functions
up    = @(c) c.^(-gamma);        % marginal utility of consumption
invup = @(x) x.^(-1/gamma);      % inverse of marginal utility of consumption


%% Discretization

% asset grid
M  = 250;                        % number of asset grid points
aM = 45;                         % maximum asset level
A  = linspace(b,aM,M)';          % equally-spaced asset grid from a_1=b to a_M *** Binding 

% productivity grid
Y  = [y1,y2]';                   % grid for productivity

% vectorize the grid in two dimensions
Amat = repmat(A,1,N);            % values of A change vertically
Ymat = repmat(Y',M,1);           % values of Y change horizontally
   

%% Endogenous functions

% current consumption level
C0 = @(cp0,r) invup(beta*(1+r)*up(cp0)*pi');

% current asset level, c0 = C0(cp0(anext,ynext))

A0 = @(anext,y,c0,r,w) 1/(1+r)*(c0+anext-y.*w);


%% Solve for the stationary equilibrium

% convergence criterion for consumption iteration
crit = 10^(-6);

% parameters of the simulation

I = 10^(4);             % number of individuals
T = 10^(4);             % number of periods

% stationary rate slightly below 1/beta-1

r0 = [0.010 (1/beta-1)];
%r0  = (1/beta-1)-[10^(-12),10^(-4)];



% set up an anonymous function
fprintf('Start solving the Aiyagari model... \n');
tic;
myfun   = @(r) s_equi(r,crit,I,T,Amat,Ymat,alpha,b,delta,rho,A0,C0,pi);
options = optimset('display','iter','TolX',1e-8,'MaxIter',20);

rstar   = fzero(myfun,r0,options);
fprintf('Done with the Aiyagari model in %f sec. \n',toc);


% get the simulated asset levels
fprintf('Fetching the wealth distribution... \n');
[r,at,ct,incm] = s_equi(rstar,crit,I,T,Amat,Ymat,alpha,b,delta,rho,A0,C0,pi);

%% 5. plot the wealth distribution

% use the last 100 periods
figure
[n,xout] = hist(ct(:,T-100:T),M);     % choose M bins
bar(xout,n/sum(n));                   % relative frequency is n/sum(n)
title(sprintf('Consumption distribution, rho = %2.1f',rho));
xlabel('Consumption level')
ylabel('Relative frequency')

figure
[n,xout] = hist(at(:,T-100:T),M);     % choose M bins
bar(xout,n/sum(n));                   % relative frequency is n/sum(n)
title(sprintf('Wealth distribution, rho = %2.1f',rho));
xlabel('Asset level')
ylabel('Relative frequency')



