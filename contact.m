function [value,isterminal,direction] = contact(t,Z,p)
% Checked by ODE45 to see if an event has occurred and what to do.

% If the COM is really close to the ground, we say it's now sliding.
slidingFlag = 1;
if abs(Z(2))<1e-9
    slidingFlag = 0;
end

% ODE45 checks if one of these values has gone negative.
value = [Z(2) + -p.l/2*cos(Z(3)), Z(2) + p.l/2*cos(Z(3)), sign(Z(2))*slidingFlag]; %Contact on one end and the other or the COM (sliding)
isterminal = [1, 1, 1]; % In all cases terminate from this instance of ODE45
direction = [-1, -1, -1]; % Only when it goes under. Should never get stuck under the ground!



end