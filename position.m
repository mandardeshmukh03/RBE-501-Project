clear all;
clc;
T06_rr=[1 0  0 -1.1843;
        0 0 -1 -0.2561;
        0 1  0 0.0116;
        0 0  0  1];
%stretch can
arm_s0=[-4.785401; -4.732601 ;-0.000152 ;1];
arm_s0_w=T06_rr*arm_s0 %world reference
arm_sf=[-5.337879; -4.699055;0.295521;1];
arm_sf_w=T06_rr*arm_sf %world reference
%put can
arm_p0=[7.883873;2.721816;-0.000182 ;1];
arm_p0_w=T06_rr*arm_p0 %world reference
arm_pf=[7.944834; 3.470301;0.807434;1];
arm_pf_w=T06_rr*arm_pf %world reference
