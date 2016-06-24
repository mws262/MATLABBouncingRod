% Derive contact model with restitution
% This will write the DiscreteCollisionsPt1 and DiscreteCollisionsPt2 files
% which map the velocity of the rod through collisions with either
% endpoint.

%% Point 1
syms vgix vgfx vpix vpfx vgiy vgfy vpiy vpfy vgi vgf vci vcf wi wf m P px py e r l I th real;
%Variables are:
% vgi (x and y) = center of mass linear velocity before collision.
% vgf (x and y) = center of mass linear velocity after collision.
% vpi (x and y) = contact point linear velocity before collision.
% vpf (x and y) = contact point linear velocity after collision.
% wi = angular velocity before collision.
% wf = angular velocity after collision.
% m = rod mass.
% P = contact impulse.
% px = impulse x component.
% py = impulse y component.
% e = coefficient of restitution.
% r = vector from rod COM to collision point.
% l = rod length (we assume uniform mass distribution).
% I = moment of inertia.
% th = rod anle (part of state vector). CCW from vertical.

%Unit vectors:
i = [1 0 0]';
j = [0 1 0]';
k = [0 0 1]';

%Vector from COM to contact point.
r = l/2.*(sin(th)*i - cos(th)*j);

vgi = [vgix, vgiy, 0]';
vgf = [vgfx, vgfy, 0]';

%Impulse solved using linear momentum.
P = dot(m.*(vgf-vgi),j).*[0 1 0]'; %We only have a vertical impulse. Hence, dot with j.

%Express using angular momentum.
eqn1 = simplify(dot(cross(r,P) - I*(wf*k-wi*k),k)) % = 0

%Kinematics:
vpf = cross(wf*k,r) + vgf;
vpi = cross(wi*k,r) + vgi;

%Restitution:
eqn2 = simplify(dot(vpf,j) + e*dot(vpi,j)) %Restitution reflects the y component of the velocity at the contact point. Equation = 0.

%Solve for wf and vgfy (vgfx doesn't change. no friction...).
wf = simplify(solve(solve(eqn1,vgfy) - solve(eqn2,vgfy),wf)) %Solve both equations for vgfy, subtract the expressions, solve for wf.
%Plug expression for wf into equation 1.
eqn1new = subs(eqn1,wf);
%Solve for final y velocity.
vyf = simplify(solve(eqn1new,vgfy))

%Write a function.
matlabFunction(vyf, wf, 'file', 'DiscreteCollisionPt1');

%% Point 2
%%%% Being lazy -- just do the same thing to the other tip %%%%%
clear all;
syms vgix vgfx vpix vpfx vgiy vgfy vpiy vpfy vgi vgf vci vcf wi wf m P px py e r l I th real;
%Variables are:
% vgi (x and y) = center of mass linear velocity before collision.
% vgf (x and y) = center of mass linear velocity after collision.
% vpi (x and y) = contact point linear velocity before collision.
% vpf (x and y) = contact point linear velocity after collision.
% wi = angular velocity before collision.
% wf = angular velocity after collision.
% m = rod mass.
% P = contact impulse.
% px = impulse x component.
% py = impulse y component.
% e = coefficient of restitution.
% r = vector from rod COM to collision point.
% l = rod length (we assume uniform mass distribution).
% I = moment of inertia.
% th = rod anle (part of state vector). CCW from vertical.

%Unit vectors:
i = [1 0 0]';
j = [0 1 0]';
k = [0 0 1]';

%Vector from COM to contact point
r = l/2.*(-sin(th)*i + cos(th)*j);  %%%%ONLY LINE THAT CHANGES FROM ABOVE>

vgi = [vgix, vgiy, 0]';
vgf = [vgfx, vgfy, 0]';

%Impulse solved using linear momentum.
P = dot(m.*(vgf-vgi),j).*[0 1 0]'; %We only have a vertical impulse. Hence, dot with j.

%Express using angular momentum.
eqn1 = simplify(dot(cross(r,P) - I*(wf*k-wi*k),k)) % = 0

%Kinematics:
vpf = cross(wf*k,r) + vgf;
vpi = cross(wi*k,r) + vgi;

%Restitution:
eqn2 = simplify(dot(vpf,j) + e*dot(vpi,j)) %Restitution reflects the y component of the velocity at the contact point. Equation = 0.

%Solve for wf and vgfy (vgfx doesn't change. no friction...).
wf = simplify(solve(solve(eqn1,vgfy) - solve(eqn2,vgfy),wf)) %Solve both equations for vgfy, subtract the expressions, solve for wf.
%Plug expression for wf into equation 1.
eqn1new = subs(eqn1,wf);
%Solve for final y velocity.
vyf = simplify(solve(eqn1new,vgfy))

%Write a function.
matlabFunction(vyf, wf, 'file', 'DiscreteCollisionPt2');
















