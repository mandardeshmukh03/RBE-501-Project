clear
syms theta1 theta2 theta3 theta4 theta5 theta6
u = symunit;
a = [0; -0.612; -0.5723;0; 0;0];
alpha = [90; 0; 0; 90; -90;0]*u.degree; % in degree unit
d = [0.1273; 0; 0; 0.163941; 0.1157;0.0922];
theta = [theta1; theta2; theta3; theta4; theta5 ;theta6]; 
n = length(theta);
for index = 1:n    
    T(index,:,:) = dhparam2matrix(theta(index), d(index), a(index), alpha(index));    
    disp(['The homogenous transformation matrix A', num2str(index), ' is '])    
    disp(dhparam2matrix(theta(index), d(index), a(index), alpha(index))) 
end
T06 = eye(4); 
for index = 1:n 
     Tit = squeeze(T(index,:,:)); 
      T06 = simplify(T06*Tit);
end 
T06_r = subs(T06, [theta1 theta2 theta3 theta4 theta5 theta6], zeros(1, n))
simplify(T06_r)
T06_rr=[1 0  0 -1.1843;
        0 0 -1 -0.2561;
        0 1  0 0.0116;
        0 0  0  1]

function T = dhparam2matrix(theta, d, a, alpha)
%dhparam2matrix takes a set of DH parameters for a link and returns a 4x4 homogeneous transformation matrix
%    takes a set of DH parameters for a link and returns a 4x4 homogeneous transformation matrix

T = [cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta)
     sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta)
              0,             sin(alpha),             cos(alpha),           d
              0,                      0,                      0,           1];
T = simplify(T);
end