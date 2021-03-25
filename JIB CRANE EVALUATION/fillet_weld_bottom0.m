%FILLET WELDS IN THE BOTTOM BRACKET (theta=0): In this script we analysis the stress
%distribution of the boom reactions and verify if the designed welds are
%actually capable of resisting shear and normal stresses

%GEOMETRY PARAMETERS:We are gonna use 2 vertical and 2 horizzontal welds. In order to simplify the
%realization of the horizzontal welds the external surface of the bracket
%along that direction has been considered straigthly perpedicular to the coloumn surface:

inertiamoment;
variazione_pos_carrello;
h_weld=h_sez/2;
b_weld=b/2;
a=5; 
L=5*(2^0.5);

F_h_weld=Ra_x_mat(23,25);
F_v_weld=Ra_y_mat(23,25);

%EQUIVALENT STRESS DETERMINATION: We consider both the vertical and the
%horizzontal reaction that create shear and tension on the weld surfaces.In
%addiction it has been considered the bending moment M_z associated to the
%eccentricity through the vertical reaction point of application (PIN) and
%the fillet welded surface

sigma_weld_perp_n=F_h_weld/(2*a*h_weld+b_weld*a*2);
I_weld=(a*h_weld^3)/6+(b_weld*a^3)/6+2*a*b_weld*(h_weld+a/2)^2;
sigma_weld_perp_b=(-F_v_weld*80/I_weld)*(h_weld+a/2);
sigma_weld_perp=sigma_weld_perp_n+sigma_weld_perp_b;

tau_weld_paral=F_v_weld/(2*a*h_weld);
tau_weld_hort=0;

sigma_eq_weld_0_BOTTOM=(tau_weld_hort^2+sigma_weld_perp^2)^0.5;
sigma_eq_weld_0_BOTTOM<0.85*235/3
sigma_eq_weld_0_BOTTOM/(0.85*235/3)
