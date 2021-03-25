%FILLET WELDS IN THE TOP BRACKET(theta=0): In this script we analysis the stress
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

%EQUIVALENT STRESS DETERMINATION: There are two reactions F_v_weld and
%F_h_weld which generate respectively shear and tension stress, and also a
%bending moment M_z associated to F_v_weld  eccentricity.

I_weld_zz=(a*(c)^3)/6+(d*(a^3))/6+2*a*d*(d/2+a/2)^2;
sigma_weld_perp_n=F_h_weld/(2*a*c+2*a*d);
sigma_weld_perp_b=((F_v_weld*230)/I_weld_zz)*(c/2+(a/2));
sigma_weld_perp=sigma_weld_perp_n+sigma_weld_perp_b;
tau_weld_paral=F_v_weld/(2*a*c);

sigma_eq_weld_0_TOP=(sigma_weld_perp^2)^0.5;
sigma_eq_weld_0_TOP<0.85*235/2.5
sigma_eq_weld_0_TOP/(0.85*235/2.5)
