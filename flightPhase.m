function zdot = flightPhase(t,z,p)
% Flying dynamics
%This represents the phase in which the rod is completely in the air.
%State vector z = [x,y,theta,xdot,ydot,thetadot]'

%Only affected by gravity in the air:
zdot = [z(4),z(5),z(6),0,p.g,0]';

end