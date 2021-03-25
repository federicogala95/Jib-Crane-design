%FILLET WELDS IN THE BOOM BRACKET: In this script we analysis the stress
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
F_h_weld=-Ra_y_mat(23,25);
F_v_weld=Rb_mat(23,25)*cos(alpha_mat(23,25));

%EQUIVALENT STRESS DETERMINATION: We need to take into account of a bending moment M_z due to the fact that F_h is not
%baricentric but it is applied excentrically

 sigma_weld_perp_n=F_h_weld/(2*a*c+2*a*d);

I_weld_xx=(a*(c)^3)/6+(d*(a^3))/6+2*a*d*(d/2+a/2)^2;
sigma_weld_perp_b=((F_v_weld*114)/I_weld_zz)*(d/2+a/2);

tau_weld_paral_x=F_v_weld/(a*d*2);

sigma_eq_weld_BOOM=((abs(sigma_weld_perp_b)+abs(sigma_weld_perp_n))^2)^0.5;
sigma_eq_weld_BOOM<0.85*235/3
sigma_eq_weld_BOOM/(0.85*235/3)
