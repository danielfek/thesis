function Excess_K = Aiyagari(r,mpar,par,gri,prob,meshes,util,mutil)

global value_aiyagari

par.r = r;         % Interest Rate

%% Define Aggregates
N= 7/8; %Average Employment
%N= 1;
%Aggregate capital
K = ((par.r+par.delta)/par.alpha)^(1/par.alpha)*N;
%Wage
W = (1-par.alpha)*(K/N)^(par.alpha);

%% Cash at Hand (Y)
Y = W.*meshes.z + (1+par.r).*meshes.k;

%% Initialize Value and Policy Functions
% V = zeros(mpar.nk,mpar.nz);
V = value_aiyagari;

%% Value Function Iteration

V=V(:);
dist_V = @(V)(V-VFI_update_spline(V,Y,util,par,mpar,gri,prob));
[V,~,iter,distF] = broyden(dist_V,V,mpar.crit,1e-14,500);
[~,kprime] = VFI_update_spline(V,Y,util,par,mpar,gri,prob);
value_aiyagari = V;

[~,idk]                 = histc(kprime,gri.k); % find the next lowest grid point on the asset grid
idk(kprime<=gri.k(1))   = 1; % make sure that "next lowest" is between first and next before last
idk(kprime>=gri.k(end)) = mpar.nk-1;
distance    = kprime-gri.k(idk); %between actual policy and next lowest gridpoint
weightright = distance./(gri.k(idk+1)-gri.k(idk)); % calculate the distance as fraction of distanc between grids
weightleft  = 1-weightright; % The actual policy is a convex combinations

Trans_array = zeros(mpar.nk,mpar.nz,mpar.nk,mpar.nz);
for zz=1:mpar.nz
    for kk=1:mpar.nk
        %Dimensions of trans array: 1: cap today; 2: labor income today, 3:
        %cap tomorrow, 4: income tomorrow
        Trans_array(kk,zz,idk(kk,zz),:)   = weightleft(kk,zz) + reshape(prob.z(zz,:),[1 1 1 mpar.nz]);
        Trans_array(kk,zz,idk(kk,zz)+1,:) = weightright(kk,zz) + reshape(prob.z(zz,:),[1 1 1 mpar.nz]);
    end
end
PK=reshape(Trans_array,[mpar.nk*mpar.nz, mpar.nk*mpar.nz]);
[x,d]=eigs(PK',1);
x=x./sum(x); % Transform the unit euclidean length eigenvector to a probability vector.

mar_k = sum(reshape(x,[mpar.nk, mpar.nz]),2); %Marginal dist of k
mar_z = sum(reshape(x,[mpar.nk, mpar.nz]),1); %Marginal dist of z (Uniform)

Excess_K = sum(mar_k'.*gri.k)-K;

fprintf('r=%1.5f and Excess(K)=%2.3f\n',r,Excess_K)

end
