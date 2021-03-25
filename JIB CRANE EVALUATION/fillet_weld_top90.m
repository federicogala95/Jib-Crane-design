%FILLET WELDS IN THE TOP BRACKET(theta=90): In this script we analysis the stress
%distribution of the tie rod reactions on the top bracket and verify if the designed welds are
%actually capable of resisting shear and normal stresses

%GEOMETRY PARAMETERES:We are gonna use 2 vertical  and 2 horizzontal welds
% placed around the bracket. In order to simplify the
%realization of the horizzontal welds the external surface of the bracket
%along that direction are considered straigthly perpedicular to the coloumn surface:

inertiamoment;
variazione_pos_carrello;
c=100;
d=100;
a=5;
F_h_weld=Ra_x_mat(23,25);
F_v_weld=Rb_mat(23,25)*sin(alpha_mat(23,25));

%EQUIVALENT STRESS DETERMINATION: In this case we need to take into account
%of both the presence of bending moments, applied along z and y axes, and a
%torque moment associated to load F_v



I_weld_yy=(a*(c)^3)/6+(d*(a^3))/6+2*a*d*(d/2+a/2)^2;
I_weld_zz=(a*(c)^3)/6+(d*(a^3))/6+2*a*d*(d/2+a/2)^2;

sigma_weld_perp_b=((F_h_weld*63)/I_weld_zz)*(c/2+(a/2))+((F_v_weld*63)/I_weld_yy)*(d/2+a/2);

tau_weld_paral_z=F_h_weld/(a*d*2);
tau_weld_paral_y=F_v_weld/(a*c*2);

if tau_weld_paral_z<=tau_weld_paral_y
    tau_weld_paral=tau_weld_paral_y
else
    tau_weld_paral=tau_weld_paral_z
end

tau_weld_tor=(F_v*189)/((a*c)*(a+d)+(a*d)*(a+c));


sigma_eq_weld_90_TOP=((tau_weld_tor+tau_weld_paral_z)^2+sigma_weld_perp_b^2)^0.5;
sigma_eq_weld_90_TOP<0.85*235/3
sigma_eq_weld_90_TOP/(0.85*235/3)
