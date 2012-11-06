% Homework4Transmission.m
% 
% Alex Toombs
% Quantum Mechanics
% Homework 4
% Due:  10/12/12

%% Set barrier parameters
Emin=0; % minimum energy in eV
Emax=2; % max energy in eV
Ne=100; 
V0=1;  % eV

L=100; % well width in angstroms
N1=100;
N2=100;
N3=100;

%% Initialize arrays, define potential
N=N1+N2+N3;
x=linspace(0,L,N);
v=[zeros(1,N1), V0*ones(1,N2), zeros(1,N3)];

%% Find transmission coefficient of barrier
T=zeros(1,Ne);
Ea=linspace(Emin,Emax,Ne);
for ie=1:Ne
    [t,r,T(ie),R,psi]=transmission(Ea(ie),v,x);
end

%% Plot T(E) from 0 to 2 eV
plot(Ea,T,'-o');
xlabel('Energy (eV)');
ylabel('Transmission Coefficient T(E)');