function [vecs,eigs]=Bound(vpot,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Solve 1-D Schroedinger bound-state problem using FEM method
%
%   input:
%       vpot(1,numnp)  potential array (in eV)
%       x(1,numnp)     coordinates of nodal points (in Angstroms)
%
%   returns:
%       eigs(numnp-2)        sorted eigenvalues eigenvalues (smallest to largest)
%                               units are eV
%       vecs(numnp,numnp-2)  sorted eigenvectors (unnormalized)
%                               plot(x,vecs(:,k)) plots the kth eigenvector
%
%  Boundary condition assumed is vanishing of wavefunction at x(1) and x(numnp)
%  effective mass is set to that for GaAs--you can change it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by:  Craig Lent 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE OF USE:  square well with V=0 inside
%
% numnp=100;  
% L=100;
% x=[0:numnp-1]*(L/(numnp-1));
% vpot=zeros(1,numnp);
% [vecs,eigs]=Bound(vpot,x);
% for i=1:4
%  plot(x,vecs(:,i))
%  xlabel('x (Ang.)');ylabel('Psi');
%  title(['Bound eigenstate ',num2str(i),', E=',num2str(eigs(i)), 'eV'])
%  pause;
% end
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Get size of arrays
%
[n,numnp]=size(x);  

%% set physical constants
%
hbarc=1973;           % h-bar times the speed of light (eV-Angstroms)
c=2.998*10^(18);      % the speed of light in Angstroms/sec
mc2=511000;    		  % electron rest mass (eV)
meff=0.067;			  % effective mass of electron

xpref=hbarc*hbarc/(2*meff*mc2);

%%  setup space for arrays

VA=zeros(numnp,numnp);
TA=zeros(numnp,numnp);
MA=zeros(numnp,numnp);

%% calculate FEM matrices
for j=1:numnp-1
  h=x(j+1)-x(j);
  VA(j,j)= VA(j,j)+   h*((vpot(j)/4.0)+(vpot(j+1)/12.0));
  VA(j,j+1)=VA(j,j+1)+h*((vpot(j)/12.0)+(vpot(j+1)/12.0));
  VA(j+1,j)=VA(j+1,j)+h*((vpot(j)/12.0)+(vpot(j+1)/12.0));
  VA(j+1,j+1)=VA(j+1,j+1)+h*((vpot(j)/12.0)+(vpot(j+1)/4.0));
%
  TA(j,j)=TA(j,j)+(1/h);
  TA(j+1,j+1)=TA(j+1,j+1)+(1/h);
  TA(j,j+1)=TA(j,j+1)-(1/h);
  TA(j+1,j)=TA(j+1,j)-(1/h);
%
  MA(j,j)=MA(j,j)+(1/3)*h;
  MA(j+1,j+1)=MA(j+1,j+1)+(1/3)*h;
  MA(j+1,j)=MA(j+1,j)+(1/6)*h;
  MA(j,j+1)=MA(j,j+1)+(1/6)*h;
end
TA=TA*xpref;
  
%% Form Hamiltonian matrix
%
HA=TA+VA;
%
% Remove first and last row and column.
%
H=HA([2:numnp-1],[2:numnp-1]);
M=MA([2:numnp-1],[2:numnp-1]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Find eigenvectors and eigenvalues and sort them
%
%
[vec,D]=eig(H,M);
[eigs,kk]=sort(diag(D));
vecs=real(vec(:,kk));
%
% add zeros at first and last nodal point
%
vecs=[ zeros(1,numnp-2);
        vecs;
       zeros(1,numnp-2);];


%%  normalize the wavefunctions
%
for iv=1:numnp-2
    psi=vecs(:,iv);
    norm=trapz(x,psi.^2);
    vecs(:,iv)=vecs(:,iv)/sqrt(norm);
end

%%%%%% End of function Bound.m  %%%%%%%%%


