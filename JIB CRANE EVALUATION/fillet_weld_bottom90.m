%FILLET WELDS IN THE BOTTOM BRACKET(theta=90): In this script we analysis the stress
%distribution of the boom reactions and verify if the designed welds are
%actually capable of resisting shear and normal stresses

%GEOMETRY PARAMETERS:We are gonna use 2 vertical welds and 2
%horizzontal welds placed on the upper part of the bracket. In order to simplify the
%realization of the upper weld the external surface of the bracket along
%has been considered straigthly perpedicular to the coloumn surface:

inertiamoment;
variazione_pos_carrello;
h_weld=h_sez/2;
b_weld=b/2;
a=5; 
L=5*(2^0.5);

F_h_weld=Ra_x_mat(23,25);
F_v_weld=Ra_y_mat(23,25);
%EQUIVALENT STRESS DETERMINATION: When theta is equal to 90 we need to take
%into account of another bending moment M_y due to the fact that F_h is no more
%baricentric but it is applied excentrically respect to the weld plane


I_weld_zz=(a*(h_weld)^3)/6+(b_weld*(a^3))/6+2*a*b_weld*(h_weld+a/2)^2;
I_weld_yy=(a*(b_weld)^3)/6+(h_weld*(a^3))/6+2*a*h_weld*(b_weld+a/2)^2;
sigma_weld_perp_b=((-F_v_weld*80)/I_weld_zz)*(h_weld+(a/2))+((F_h_weld*80)/I_weld_yy)*(b_weld+(a/2));

tau_weld_paral_h=F_h_weld/(a*h_weld*2);
tau_weld_paral_v=F_v_weld/(2*a*b_weld);

sigma_eq_weld_90_BOTTOM=(tau_weld_paral_h^2+sigma_weld_perp_b^2)^0.5
sigma_eq_weld_90_BOTTOM<0.85*235/3
sigma_eq_weld_90_BOTTOM/(0.85*235/3)
