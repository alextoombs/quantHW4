function y = firstPlot(handles, Ein);

% firstPlot.m
% 
% Alex Toombs
% Quantum Mechanics
% Homework 4
% Due:  10/12/12
%
% Plots V(x), T(E), and/or log(T(E)), depending upon dropdown choice
% Also plots the local density of states or the probability for a given
%    barrier height.

%% Initialize parameters
num = 250;  % number of nodal points

L = num;    % total graph length
a = get(handles.aslide,'Value');   % well width in Angstroms
d = get(handles.dslide,'Value'); % distance between wells in Angstroms
E = get(handles.vslide,'Value');    % depth of well in eV

plotType = get(handles.plotselect,'Value');
probType = get(handles.probplotselect,'Value');
Ea = linspace(0, E, num);

%% Set potential of barriers
x=[0:num-1]*L/(num-1);
vpot=zeros(1,L);

for j = 1 : L
    if((j < L/2 + a) && (j > L/2)) || ((j > L/2 + a + d) && (j < L/2 + 2*a + d))
        vpot(j) = E; % set matrix value to 0 where well isn't
    end
end

%% Plot solutions of plot 1
switch plotType
    case 1 % Plot the potential of the double barrier system
        
        %solve for bound states of well of depth Vb
        v2=zeros(1,num);
        [vecs,eigs]=Bound(v2,x); 
        
        for i=1:4
            plot(handles.plot1,x,vecs(:,i),'r',x,vpot,'b');  % plot ith eigenvector
        end
        xlabel(handles.plot1,'x (Angstroms)');
        ylabel(handles.plot1,'V(x) (eV)');
        title(handles.plot1,['Double Barrier Potential in eV']);
        axis([0 E+0.2 0 num]);
    case 2 % Plot the transmission of the double barrier system
        % Solve for transmission
        for ie=1:num
            [t,r,T(ie),R,psi]=transmission(Ea(ie),vpot,x);
        end
        
        plot(handles.plot1,Ea,T,'-o');
        xlabel(handles.plot1,'Energy (eV)');
        ylabel(handles.plot1,'Transmission Coefficient T(E)');
        title(handles.plot1,['Transmission Coefficient as a Function of Barrier Height']);
    case 3 % Plot the log of the transmission coefficient
        % Solve for transmission
        for ie=1:num
            [t,r,T(ie),R,psi]=transmission(Ea(ie),vpot,x);
        end
        loglog(handles.plot1,Ea,T);
        xlabel(handles.plot1,'Energy (eV)');
        ylabel(handles.plot1,'Log of Transmission Coefficient T(E)');
        title(handles.plot1,['Log of Transmission Coefficient as a Function of Barrier Height']);
end

%% Plot solutions of plot 2
switch probType
    case 1 % Local density of states
        % set up grid
        % Solve for transmission
        for ie=1:num
            [t,r,T(ie),R,psitemp]=transmission(Ea(ie),vpot,x);
            psi(ie,:) = real(psitemp);
        end

        pcolor(handles.plot2,psi); 
        shading interp;
        axis square;
    case 2 % Probability density
        [t,r,T,R,psi]=transmission(Ein,vpot,x);
        %solve for probability density
        p = abs(psi).^2;
        
        plot(handles.plot2,x,p);
        xlabel(handles.plot2,'x (Angstroms)');
        ylabel(handles.plot2,'Probability Density P(x)');
        title(handles.plot2,['Probability Density at this Energy']);
end
