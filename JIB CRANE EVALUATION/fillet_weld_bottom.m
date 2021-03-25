%FILLET WELDS IN THE BOTTOM BRACKET: In this script we analysis the stress
%distribution of the boom reactions and verify if the designed welds are
%actually capable of resisting shear and normal stresses

%GEOMETRY PARAMETERS:We are gonna use 2 vertical welds and 1 horizzontal
%one placed on the upper part of the bracket. In order to simplify the
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

sigma_weld_perp_n=F_h_weld/(2*a*h_weld+b_weld*a);
I_weld=(a*h_weld^3)/6+(b_weld*a^3)/24+a*b_weld*(b_weld/2+a/2)^2;
sigma_weld_perp_b=(F_v_weld*50/I_weld)*(h_weld/2+a/2);
tau_weld_paral=F_v_weld/(2*a*h_weld);
sigma_weld_perp=sigma_weld_perp_n+sigma_weld_perp_b;
sigma_eq_weld=(tau_weld_paral^2+sigma_weld_perp^2)^0.5;
sigma_eq_weld<0.85*235/2.5
sigma_eq_weld/(0.85*235/2.5)
