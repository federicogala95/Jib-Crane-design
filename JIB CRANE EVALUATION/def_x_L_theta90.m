%Determinazione delle deformazioni in regime elastico del punto di
%applicazione del carico
%IT DOES NOT CONSIDER THE EFFECT OF LOAD ECCENTRICITY YET!

inertiamoment;
variazione_pos_carrello;

def=[];
def_amm_mat=zeros(31,25); %matrice delle deformazioni del punto di applicazione del carico ammissibili;
phi_AD=0;  %angolo di deformazione della colonna AD;
A_tie_r=(30^2*pi/4); %mm^2 RICORDATI DI CAMBIARE LE DIMENSIONI DEL TIE ROD 
pos_amm=[];
x_L_mm=x_L*1000; % mm
x_pend_mm=x_pend*1000;
h_mm=h*1000;
l_tot_mm=l_tot*1000;
w_mm=p__b/1000;
def_amm=[];
def_vec=[];
v_AD=0;
v_fune=0;
v_AC=0;
v_AB_L=0;
v_AB_w=0;
v_BE_L=0;
v_BE_w=0;
for z=2:length(x_pend)
    for j=1:length(x_L)
        phi_AD=(1000*Md_mat(z,j)*h_mm)/(E*I_col_zz);
        phi_AD_mat(z,j)=phi_AD;
        v_AD=phi_AD*x_L_mm(j);
        
        v_fune=(Rb_mat(z,j)*sin(alpha_mat(z,j))*((1000^2+(x_L_mm(j))^2))^(1/2))/(E*A_tie_r);
        
        v_AC=atan((((1000^3)*Rb_mat(z,j)*cos(alpha_mat(z,j)))/(3*E*I_col_zz))/x_pend_mm(z))*x_L_mm(j); 
        
        if x_pend(z)>x_L(j)
           
            v_AB_L=(L*x_pend_mm(z)*((1/3)*(x_pend_mm(z)-x_L_mm(j))*(2*x_pend_mm(z)-x_L_mm(j)))^(3/2))/(3*E*I_beam_zz*x_pend_mm(z));
            
            if x_L(j)<(x_pend(z))/2
                v_AB_w=((w_mm*(x_pend_mm(z))^3)/(24*E*I_beam_zz))*x_L_mm(j);
            elseif x_L(j)>(x_pend(z))/2
                v_AB_w=((w_mm*(x_pend_mm(z))^3)/(24*E*I_beam_zz))*(x_pend_mm(z)-x_L_mm(j));
            end
            
        elseif x_pend(z)<x_L(j)
            v_BE_w=((w_mm*(l_tot_mm-x_pend_mm(z))^3)/(6*E*I_beam_zz))*(x_L_mm(j)-x_pend_mm(z));
            v_BE_L=(L*(x_L_mm(j)-x_pend_mm(z))^2)/(2*E*I_beam_zz); %RIVEDERE
        
        else
            v_AB_L=0;
            v_AB_w=0;
            

        end
        
    def(z,j)=v_AD+v_fune+v_AC+v_AB_w+v_AB_L+v_BE_w+v_BE_L;
    def_vec=[def_vec;v_AD v_fune v_AC v_AB_w v_AB_L v_BE_w v_BE_L];
    end
end
        
    for z=1:length(x_pend)
        for j=1:length(x_L)
            if def(z,j)<40/1.5
                def_amm=[def_amm def(z,j)];
                pos_amm=[pos_amm ; z j ];
                def_amm_mat(z,j)=def(z,j);
            end
        end
    end
   
        
            

            
            
            
            
            
            
            
    