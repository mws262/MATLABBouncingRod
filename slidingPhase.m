function zdot = slidingPhase(t,z,p)
% Sliding dynamics
%This represents the phase in which the rod sliding on the ground.
%State vector z = [x,y,theta,xdot,ydot,thetadot]'

%No forces!
zdot = [z(4),z(5),z(6),0,0,0]';

end