%Bouncing rod demo
% Integrate with ODE45 and do event detection to transition between
% continuous dynamics of the rod before and after impact events.
%
% State vector z = [x,y,theta,xdot,ydot,thetadot]'
% 
% Matthew Sheen

close all;

% Run the contact deriver again -- uncomment if needed:
% deriveCollisions;

%% Physical parameters
p.l = 1; % Rod length
p.m = 1; % Rod mass
p.I = 1/12*p.m*p.l^2; % Rod inertia
p.g = -10; % Gravitational acceleration

p.mu = 0.1; % Friction coefficient
p.R = .7; % Restitution coefficient

tfinal = 8; % We'll simulate this many seconds

inits = [-5, 5, 3*rand(1,4)]'; %Initial conditions [x,y,theta,xdot,ydot,thetadot]

optionsFlight = odeset('AbsTol',1e-4,'Events',@contact); % Look for a contact event if the rod is in flight.
optionsSliding = odeset('AbsTol',1e-4); % No events can cause us to leave sliding in this model.

time = 0;
currentstate = inits;
tarray = [];
zarray = [];

slidingFlag = false;

% Keep integrating until we get to time, tfinal. Will have many transition
% events!

while (time < tfinal)
    %% Integrate the dynamics and exit when collisions occur
    if slidingFlag
        % If we start sliding on the ground, we stay sliding.
        [tcurrent,zcurrent] = ode45(@slidingPhase,[time tfinal],currentstate,optionsSliding,p);
    else
        % Integrate the flight phase until contact occurs.
        [tcurrent,zcurrent,TE,YE,IE] = ode45(@flightPhase,[time tfinal],currentstate,optionsFlight,p);
    end

    
    % Add all the new data to the overall array of states.
    tarray = [tarray;tcurrent(2:end,:)]; % For now, going 2:end to avoid duplicate data (ALTHOUGH NEEDED FOR VELOCITY, so FIX IT).
    zarray = [zarray;zcurrent(2:end,:)];

    %% Handle the collision (or entry into sliding phase).
    wi = zcurrent(end,6); % Pull out the (-) states at the collision instant
    vgiy = zcurrent(end,5);
    th = zcurrent(end,3);

    if IE == 1 % Bottom tip contact (according to vertical orientation of rod with theta = 0
        [vyf,wf] = DiscreteCollisionPt1(p.I,p.R,p.l,p.m,th,vgiy,wi); % Map velocities through the collision
        disp('bounce tip 1');
        currentstate(1:4) = zcurrent(end,1:4);
        currentstate(5) = vyf; % Replace the y component of velocity based on restitution/momentum.
        currentstate(6) = wf; % Replace the angular velocity based on restitution/momentum.
    elseif IE == 2 % Top tip contact
        [vyf,wf] = DiscreteCollisionPt2(p.I,p.R,p.l,p.m,th,vgiy,wi); % Map velocities through the collision
        disp('bounce tip 2');
        currentstate(1:4) = zcurrent(end,1:4);
        currentstate(5) = vyf; % Replace the y component of velocity based on restitution/momentum.
        currentstate(6) = wf; % Replace the angular velocity based on restitution/momentum.
    elseif IE ==3
        slidingFlag = true;
        disp('sliding')
        currentstate = zcurrent(end,1:4);
        currentstate(5) = 0;
        currentstate(6) = 0;
        IE = 0;
    end 
    
    time = tarray(end);


end

% Run animation
animate(tarray,zarray,p)
