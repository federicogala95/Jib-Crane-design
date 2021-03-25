%BOLT JOINT VERIFICATION: this script verify if the bolt on the steel plates is resistent
%enough to support the boom reactions and turns as output both the result of the verification andminimum required preload N0 and    :
variazione_pos_carrello;
F_v=Ra_y_mat(23,25); %load acting along x axis
F_h=Ra_x_mat(23,25); %load acting along y axis 
T=F_v*175; %torque moment acting on the plates due to the excentricity of the vertical load

%BOLT DATA: M10*60 BNHM1050Z from FORTRESS CATALOGUE (in millimeter)
d=20; %hole diameter
l=60; %length
p=2.5; %pitch
n=6; %number of the applied bolts considered equal
d_0=30; % head diameter
l_t=46; % thread length
E=210*(10^3); %Young's module N/mm^2
%PLATES DATA:
b=150;
h=100;
t=10;

%DETERMINATION OF THE CRITICALLY LOADED BOLT:

V_v=((F_v^2+F_h^2)^(.5))/n;
r=(37.5^2+25^2)^.5; %distance through the centroid and the centre of the bolt (same one for every bolt due to simmetry)
V_t=T*r/(4*(r^2)+2*(25^2));
V_i=((V_v*cos(atan(F_v/F_h))+V_t*cos(pi/2-atan(25/37.5)))^2+(V_v*sin(atan(F_v/F_h))+V_t*sin(pi/2-atan(25/37.5)))^2)^.5

%FRICTION ANALYSIS: Lets now determine the rigid elastic coefficient for
%the flanges and bolt in order to determine N_o

k_b=(pi*d^2/4)*E/(2*10+6.6)
%Diameter for the k_i relation:
D_1=d_0+2*10/sind(30);
D_2=d_0+2*(10+3.3)/sin(30);
D_3=D_1;

k_1=pi*E*d*tand(30)/(log((D_1-d)/(D_1+d)*(d_0+d)/(d_0-d)));
k_2a=pi*E*d*tand(30)/(log((D_2-d)/(D_2+d)*(D_1+d)/(D_1-d)));
k_2b=pi*E*d*tand(30)/(log((D_2-d)/(D_2+d)*(D_3+d)/(D_3-d)));
k_3=pi*E*d*tand(30)/(log((D_3-d)/(D_3+d)*(d_0+d)/(d_0-d)));

k_f=(1/k_1+1/k_2a+1/k_2b+1/k_3)^(-1)

%FORCE ACTING AT THE PLATES INTERFACE:
f=0.2;
S_res=245;
SF_slippage=3;
N_0_min=V_i*SF_slippage/f
N_0_min/S_res<800*0.8







