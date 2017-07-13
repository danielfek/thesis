function [Vnew,kprime] = VFI_update_spline(V,Y,util,par,mpar,gri,prob)
V=reshape(V,[mpar.nk,mpar.nz]);
kprime = zeros(size(V));
Vnew   = zeros(size(V));
EV     = par.beta* V* prob.z';   % Calculate expected continuation value
ev_int= griddedInterpolant({gri.k,gri.z},EV ,'linear');
for zz=1:mpar.nz
    for kk=1:mpar.nk
        f             = @(k)(-util(Y(kk,zz)-k)-ev_int({k,gri.z(zz)}));
        [kp,v]=fminbnd(f,min(gri.k),Y(kk,zz));
        Vnew(kk,zz)=-v;
        kprime(kk,zz) = kp;
    end
end
Vnew=Vnew(:);
