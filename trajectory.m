clear
tspan = [0, 10];
ax_s = CubicTraj(tspan,  -5.9697, -6.5222)
ay_s = CubicTraj(tspan, -0.2559, -0.5516)
az_s = CubicTraj(tspan, -4.7210, -4.6875)

ax_p = CubicTraj(tspan, 6.6996, 6.7605)
ay_p = CubicTraj(tspan, -0.2559, -1.0635)
az_p = CubicTraj(tspan,  2.7334, 3.4819)
function a = CubicTraj(tspan, q0, qf)
  t0 = tspan(1);
  tf = tspan(2);
  
  A = [1, t0, t0^2,   t0^3
       0,  1, 2*t0, 3*t0^2
       1, tf, tf^2,   tf^3
       0,  1, 2*tf, 3*tf^2];
  B = [q0; 0; qf; 0];
  
  a = A\B;
  a = a.';
end