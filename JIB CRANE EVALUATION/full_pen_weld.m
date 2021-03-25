%ADMISSIBLE STRESS ANALYSIS FOR THE STRUCTURE SECTION:
%We first consider the position for the TIE ROD obtained by using "def_x_L"
%(23) with all 25 different load positions both for the BEAM and COLUMN;

%VARIABLES:
variazione_pos_carrello;
inertiamoment;
sigma_x_beam=[];
sigma_eq_beam=[];
sigma_eq_col=[];
tau_beam=[];
sigma_x_col_0=[];
tau_col_0=[];
pos_tie_rod=23;
%DETERMINATION OF THE EQUIVALENT STRESS ON THE WELDED SPOT OF THE SECTION: we are obviously giving more
%importance to M_beam and N_beam since they have a much higher impact in
%the calculus for sigma equivalent (TRESCA METHOD);




 
 %COLUMN ANALYSIS: As for the previous casse we first determine the most
 %stressed section through the possible positions of the load;
 M_in_col=M_col(23,1,1);
 N_in_col=N_col(23,1,1);
 V_in_col=V_col(23,1,1);
 M_max_c=[];
 N_max_c=[];
 V_max_c=[];
 M_in_vec_col=[];
 N_in_vec_col=[];
 V_in_vec_col=[];
 
 for j=1:25
    for i=1:36
        if (abs(M_col(23,j,i))+abs(N_col(23,j,i))+abs(V_col(23,j,i)))>(abs(M_in_col)+abs(N_in_col)+abs(V_in_col))
            M_in_col=M_col(23,j,i);
            N_in_col=N_col(23,j,i);
            V_in_col=V_col(23,j,i);
            M_in_vec_col=[M_in_col i];
            N_in_vec_col=[N_in_col i];
            V_in_vec_col=[V_in_col i];
            
            
        end
    end
        M_max_c=[M_max_c ; M_in_vec_col];
        N_max_c=[N_max_c; N_in_vec_col];
        V_max_c=[V_max_c; V_in_vec_col];
      
end      
pos_analysis_stress_c=M_max_c(:,2);


%STRESS ANALYSIS OF THE COLUMN: theta=0


for k=1:length(pos_analysis_stress_c)
     v=pos_analysis_stress_c(k);
     sigma_x_col_0(k)=(1000*M_col(23,k,v)*(-h_sez/2+t_f))/(I_col_zz)+(N_col_b(23,k,v)*(h_sez/2-t_f)*(h_sez/2+(2*I_col_zz/(2*A_beam*h_sez))))/I_col_zz+(N_col(23,k,v)/(2*A_beam));
     tau_col_0(k)=2*V_col(23,k,v)*(b/2)*(h_i/2+t_f/2)/I_col_zz;
     sigma_eq_fweld_0(k)=((sigma_x_col_0(k)^2)+3*((tau_col_0(k)^2)))^(1/2);
end
 
sigma_eq_fweld_0


%STRESS ANALYSIS OF THE COLUMN: theta=90 
Jt_ap=1/3*(t_f^3)*4*b+1/3*(t_w^3)*2*h_i;
Jt_c=4*(((b-t_w)*(h_i-t_f))^2)/((2*b/t_f)+(2*h_i/t_w));
G=81*10^3; %N/mm^2
torque_const=[];
for k=1:length(pos_analysis_stress_c)
     v=pos_analysis_stress_c(k);
     sigma_x_col_90(k)=(1000*M_col(23,k,v)*(-b/2))/(I_col_xx)+(N_col_b(23,k,v)*(h_sez/2-t_f)*(h_sez/2+(2*I_col_zz/(2*A_beam*h_sez))))/I_col_zz+(N_col(23,k,v)/(2*A_beam));
     tau_col_shear_90(k)=V_col(23,k,v)*((h_i/2)^2)/I_col_xx+V_col(23,k,v)*(b^2/8)/I_col_xx; 
     
     torque_const(k)=(V_col(23,k,v)*h_sez/2)/((Jt_ap+Jt_c)*G);
     t_flux(k)=((V_col(23,k,v)*(h_sez/2))*(Jt_c/(Jt_c+Jt_ap)))/(2*(b-t_f)*(h_i-t_w));
     tau_col_torque_90(k)=2*G*torque_const(k)*(t_f/2) +(t_flux(k)/t_f); 
     sigma_eq_fwelds_90(k)=((sigma_x_col_90(k)^2)+3*((tau_col_shear_90(k)+tau_col_torque_90(k))^2))^(1/2);
end
sigma_eq_fwelds_90

