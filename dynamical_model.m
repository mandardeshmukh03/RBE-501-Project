clear
syms theta1 theta2 theta3 theta4 theta5 theta6
u = symunit;
a = [0; -0.612; -0.5723;0; 0;0];
alpha = [90; 0; 0; 90; -90;0]*u.degree; % in degree unit
d = [0.1273; 0; 0; 0.163941; 0.1157;0.0922];
theta = [theta1; theta2; theta3; theta4; theta5 ;theta6]; 
n = length(theta);
for index = 1:n
    A(index,:,:) = dhparam2matrix(theta(index), d(index), a(index), alpha(index));
end

Temp = eye(4)*sym(1);
for index = 1:n
   Temp = simplify(Temp*squeeze(A(index,:,:)));
   T(index, :, :) = Temp;
end
T01 = squeeze(T(1,:,:));
T02 = squeeze(T(2,:,:));
T03 = squeeze(T(3,:,:));
T04 = squeeze(T(4,:,:));
T05 = squeeze(T(5,:,:));
T06 = squeeze(T(6,:,:));

z0 = [0; 0; 1];
z1 = T01(1:3,3);
z2 = T02(1:3,3);
z3 = T03(1:3,3);
z4 = T04(1:3,3);
z5 = T05(1:3,3);


o01 = T01(1:3,4);
J1v = jacobian(o01, [theta1,theta2, theta3,theta4,theta5,theta6]);
J1w = [z0,zeros(3,5)];
Jc1 = [J1v; J1w];

o02 = T02(1:3,4);
J2v = jacobian(o02, [theta1,theta2, theta3,theta4,theta5,theta6]);
J2w = [z0, z1, zeros(3,4)];
J2 = [J2v; J2w];

o03 = T03(1:3,4);
J3v = jacobian(o03, [theta1,theta2, theta3,theta4,theta5,theta6]);
J3w = [z0, z1, z2,zeros(3,3)];
J3 = [J3v; J3w];

o04 = T04(1:3,4);
J4v = jacobian(o04, [theta1,theta2, theta3,theta4,theta5,theta6]);
J4w = [z0, z1, z2,z3,zeros(3,2)];
J4 = [J4v; J4w];

o05 = T05(1:3,4);
J5v = jacobian(o05, [theta1,theta2, theta3,theta4,theta5,theta6]);
J5w = [z0, z1, z2,z3,z4,zeros(3,1)];
J5 = [J5v; J5w];

o06 = T06(1:3,4);
J6v = jacobian(o06, [theta1,theta2, theta3,theta4,theta5,theta6]);
J6w = [z0, z1, z2,z3,z4,z5];
J6 = [J6v; J6w];

syms m1 m2 m3 m4 m5 m6
D = simplify(m1*(J1v.'*J1v) +  m2*(J2v.'*J2v) + m3*(J3v.'*J3v)+m4*(J4v.'*J4v)+m5*(J5v.'*J5v)+m6*(J6v.'*J6v));

%kinetic energy
syms theta1(t) theta2(t) theta3(t) theta4(t) theta5(t) theta6(t)
q = [theta1; theta2; theta3; theta4;theta5;theta6];
dq = diff(q, t);
K = simplify(0.5*dq.'*D*dq);

syms theta1 theta2 theta3 theta4 theta5 theta6
dDdq = zeros(6,6,6)*sym(1);
dDdq(:,:,1) = simplify(diff(D, theta1));
dDdq(:,:,2) = simplify(diff(D, theta2));
dDdq(:,:,3) = simplify(diff(D, theta3));
dDdq(:,:,4) = simplify(diff(D, theta4));
dDdq(:,:,5) = simplify(diff(D, theta5));
dDdq(:,:,6) = simplify(diff(D, theta6));
Cs = simplify(0.5*(shiftdim(dDdq,1) + shiftdim(dDdq,2)+shiftdim(dDdq,3)+shiftdim(dDdq,4)+shiftdim(dDdq,5) - dDdq));
syms theta1(t) theta2(t) theta3(t) theta4(t) theta5(t) theta6(t)
C = zeros(6,6)*sym(1);
q = [theta1, theta2, theta3,theta4,theta5,theta6];
dq = diff(q, t);

for k = 1:6
    C(k,:) = simplify(dq*Cs(:,:,k));
end
%get g
syms theta1 theta2 theta3 theta4 theta5 theta6 g
P1 = m1*g*eval(T01(3,4));
P2 = m2*g*eval(T02(3,4));
P3 = m3*g*eval(T03(3,4));
P4 = m4*g*eval(T04(3,4));
P5 = m5*g*eval(T05(3,4));
P6 = m6*g*eval(T06(3,4));
P = simplify(P1 + P2 + P3+P4+P5+P6);
G = simplify(jacobian(P, [theta1 theta2 theta3 theta4 theta5 theta6]).');

params = [theta1 theta2 theta3 theta4 theta5 theta6  m1 m2 m3 m4 m5 m6 g];
values = [0 0 0 0 0 0 7.1 12.7 4.27 2 2 0.365 9.8];
D_n = simplify(subs(D, params, values))
C_n = simplify(subs(C, params, values))
G_n = simplify(subs(G, params, values))

function T = dhparam2matrix(theta, d, a, alpha)
%dhparam2matrix takes a set of DH parameters for a link and returns a 4x4 homogeneous 
%transformation matrix
%    takes a set of DH parameters for a link and returns a 4x4 homogeneous transformation 
%    matrix

T = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta)
     sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta)
              0,             sin(alpha),             cos(alpha),           d
              0,                      0,                      0,           1];
T = simplify(T);
end

