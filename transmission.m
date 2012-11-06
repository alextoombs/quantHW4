 function [t,r,T,R,psi,kleft,kright]=transmission(E,vpot,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Solve 1-D Schroedinger equation for complex transmission coefficient using FEM method
%
%   input:
%       E               energy at which to evaluate coefficents (in eV)
%       vpot(1,numnp)   potential array (in eV)
%       x(1,numnp)      coordinates of nodal points (in Angstroms)
%
%   returns:
%       t        	complex transmission coefficient
%       r           complex reflection coefficient
%       T       	real transmission coefficient
%       R           real reflection coefficient
%       psi(1,numnp)	complex wavefunction
%       kleft		wavenumber in left region
%       kright		wavenumber in right region
%
%  Assumptions: 
%		effective mass is set to that for GaAs
%		potential is vpot(1) everywhere to the left of the simulation region
%		potential is vpot(numnp) everywhere to the right of 
% 			the simulation region
%		wave in incident from the left 
%		wavefunction to right of simulation region has the form:
%			t*exp(ii*k*(x - x(numnp)))
%			This assumptions leads to problems if particle
%			is completely reflected.				
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by:  Craig Lent
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% method based on paper "The quantum transmitting boundary method"
%  C.S. Lent and D.J. Kirkner, J. Appl. Phys. 67, 6353 (1990).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
[n,numnp]=size(x);
%
%  setup space for arrays
%
VA=zeros(numnp,numnp);
TA=zeros(numnp,numnp);
MA=zeros(numnp,numnp);
CA=zeros(numnp,numnp);
PA=zeros(numnp,1);
% 
% set prefactors and find k
%
ii=sqrt(-1);
hbarc=1973;
c=2.998*10^(18);
mc2=511000;
meff=0.067;
xpref=hbarc*hbarc/(2*meff*mc2);
kleft= sqrt(2*meff*mc2*(E-vpot(1)    )/(hbarc*hbarc));
kright=sqrt(2*meff*mc2*(E-vpot(numnp))/(hbarc*hbarc));
%
for j=1:numnp-1
  h=x(j+1)-x(j);
  VA(j,j)= VA(j,j)+   h*((vpot(j)/4.0)+(vpot(j+1)/12.0));
  VA(j,j+1)=VA(j,j+1)+h*((vpot(j)/4.0)-(vpot(j+1)/12.0));
  VA(j+1,j)=VA(j+1,j)+h*((vpot(j)/4.0)-(vpot(j+1)/12.0));
  VA(j+1,j+1)=VA(j+1,j+1)+h*((vpot(j)/4.0)+(vpot(j+1)/12.0));
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
CA(1,1)=-ii*kleft;
CA(numnp,numnp)=-ii*kright;
CA=CA*xpref;
PA(1)=-2*ii*kleft;
PA=PA*xpref;
%  
% Form global matrix
%
KA=TA+VA-E*MA+CA;
%
%  Solve linear system
%
psi=KA\PA;
%
%  Find complex transmission coefficient
%
t=psi(numnp);  
r=( psi(1)-exp(ii*kleft*x(1)) )*exp(ii*kleft*x(1));
%
%  Find real coefficients
%
T=(kright/kleft)*abs(t)^2;
R=abs(r)^2;
