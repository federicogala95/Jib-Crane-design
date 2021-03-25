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
%DETERMINATION OF THE MOST STRESSED SECTION: we are obviously giving more
%importance to M_beam and N_beam since their have a much higher impact in
%the calculus for sigma equivalent (TRESCA METHOD);
M_in_b=M_beam(23,1,1);
N_in_b=N_beam(23,1,1);
M_max_b=[];
N_max_b=[];
N_in_vec=[];
M_in_vec=[];
most_stressed=[];
pos_analysis_stress=[];

for j=1:25
    for i=1:32
        if (abs(M_beam(23,j,i))+abs(N_beam(23,j,i)))>(abs(M_in_b)+abs(N_in_b))
            M_in_b=M_beam(23,j,i);
            N_in_b=N_beam(23,j,i);
            M_in_vec=[M_in_b i];
            N_in_vec=[N_in_b i];
            
        end
    end
        M_max_b=[M_max_b ; M_in_vec];
        N_max_b=[N_max_b ; N_in_vec];
      
end      
            
     pos_analysis_stress_b=M_max_b(:,2);
     
     
     
%We obtained a vector 1X24 containing the most stressed section of the BEAM for each possible position of the
%LOAD;

%STRESS ANALYSIS OF THE BEAM:
 %We now start the analysis of stresses for the sections founded through
 %the previous for cycle. It is important to consider the presence 
 %the bending moment, strain and normal reaction, which is not applied in
 %the centroid and ,as a consequence, it generates a bending moment;
 
 for k=1:length(pos_analysis_stress_b)
     v=pos_analysis_stress_b(k);
     sigma_x_beam(k)=(N_beam(23,k,v)/A_beam)+N_beam(23,k,v)*(h_i/2)*(h_i/2+(2*I_beam_zz/(A_beam*h_sez)))/(I_beam_zz)+(1000*M_beam(23,k,v)*(h_i/2))/(I_beam_zz);
     tau_beam(k)=V_beam(23,k,v)/(t_w*h_i);
     sigma_eq_beam(k)=((sigma_x_beam(k)^2)+4*((tau_beam(k)^2)))^(1/2);
 end
 
 
 %COLUMN ANALYSIS: As for the previous case we first determine the most
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
     sigma_x_col_0(k)=(1000*M_col(23,k,v)*(-h_sez/2))/(I_col_zz)+(N_col_b(23,k,v)*(h_sez/2)*(h_sez/2+(2*I_col_zz/(2*A_beam*h_sez))))/I_col_zz+(N_col(23,k,v)/(2*A_beam));
     tau_col_0(k)=2*V_col(23,k,v)*(b/2)*(h_i/2+t_f/2)/I_col_xx+V_col(23,k,v)/I_col_xx*((h_i^2)/8);
     sigma_eq_col_0(k)=((sigma_x_col_0(k)^2)+4*((tau_col_0(k)^2)))^(1/2);
end
 
%STRESS ANALYSIS OF THE COLUMN: theta=90 
for k=1:length(pos_analysis_stress_c)
     v=pos_analysis_stress_c(k);
     sigma_x_col_90(k)=(1000*M_col(23,k,v)*(-h_sez/2))/(I_col_zz)+(N_col_b(23,k,v)*(h_sez/2)*(h_sez/2+(2*I_col_zz/(2*A_beam*h_sez))))/I_col_zz+(N_col(23,k,v)/(2*A_beam));
     tau_col_90(k)=V_col(23,k,v)*((h_i/2)^2)/I_col_zz+V_col(23,k,v)*(b^2/8)/I_col_zz+V_col(23,k,v)*((b^2)/8); %ADD THE TAU RELATED TO TORQUE
     sigma_eq_col_90(k)=((sigma_x_col_90(k)^2)+4*((tau_col_90(k)^2)))^(1/2);
end
%V_col(23,k,v)*((h_i/2)^2)/I_col_zz+V(23,k,v)*(b^2/8)/I_col_zz+V(23,k,v)*(b^2/8);

