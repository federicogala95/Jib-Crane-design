% IPE A 270
I_beam_zz=4917*(10^4); %mm^4
I_beam_yy=358*(10^4); %mm^4
h_sez=267; %mm
h_i=249.6; %mm
t_w=5.5; %mm
t_f=8.7;%mm
b=135;
A_beam=39.2*10^2;%mm

%Calcolo dei momenti di inerzia della colonna realizzata unendo due travi
%ad I
Ig1_x=((t_f^3)*2*b)/12+((h_i/2+t_f/2)^2)*t_f*2*b;
Ig2_x=((h_i^3)*t_w)/12;
I_col_xx=2*Ig1_x+2*Ig2_x; % Momento inerzia colonna asse x

Ig1_z=(t_f*(2*b)^3)/12;
Ig2_z=((h_i^3)*t_w)/12 + t_w*h_i*((b/2)^2);
I_col_zz=2*Ig1_z+2*Ig2_z; % Momento inerzia colonna asse z
I=[I_beam_zz I_beam_yy I_col_xx I_col_zz];
