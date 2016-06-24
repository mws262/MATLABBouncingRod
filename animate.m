function animate(time,zarray,p)
%PLAYBACK SPEED
playback = 1;

xmin = -6;
xmax = 10;

fig = figure;
fig.Position =[100,100,800,800];
fig.Color = [1,1,1];

axis equal
hold on
%Create the rod:
width = p.l*0.05;
xdat1 = 1*width*[-1 1 1 -1];
ydat1 = p.l*[0.5 0.5 -0.5 -0.5];
rod = patch(xdat1,ydat1, [0 0 0 0],'b');

%Make the ground:
xdat2 = [-100 100 100 -100];
ydat2 = [-width*1.5 -width*1.5 -0.5 -0.5];
ground = patch(xdat2,ydat2, [0 0 0 0],'g');

%Timer label:
timer = text(-5,14,'0.0','FontSize',28);

plot(zarray(:,1),zarray(:,2),'--k');

hold off
axis([xmin,xmax,-0.4,15])

%Animation plot loop:
tic; %Start the clock
while toc<time(end)/playback
    if ~ishandle(fig)
        break;
    end
    tstar = playback*toc; %Get the time (used during this entire iteration)
    %On screen timer.
    set(timer,'string',strcat(num2str(tstar,2),'s'))
    zstar = interp1(time,zarray,tstar); %Interpolate data at this instant in time.
    
    %Rotation matrices to manipulate the vertices of the patch objects
    %using theta1 and theta2 from the output state vector.
    rot1 = [cos(zstar(3)), -sin(zstar(3)); sin(zstar(3)),cos(zstar(3))]*[xdat1;ydat1];
    set(rod,'xData',rot1(1,:)+zstar(1));
    set(rod,'yData',rot1(2,:)+zstar(2));
 
    % Update
    drawnow;
end
end
