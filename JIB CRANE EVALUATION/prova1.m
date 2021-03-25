%EVOLUZIONE DEL FILE STATICA_TRAVE_I IN CUI CERCHIAMO DI OTTIMIZZARE LA POSIZIONE DEL CARRELLO PER MINIMIZZARE 
%TAGLIO, TRAZIONE E MOMENTO FLETTENTE SULLE SEZIONI:
 %dove a definisce la posizione del pendolo e b definisce 
%la posizione del caricos


h=2.5; %metri-->distanza tra il terreno e la trave orizzonatale (BEAM);
h_tot=3.5; %metri--> altezza della colonna (COLUMN);
L=9800; %Newton-->carico mobile lungo la BEAM
w=30.7*9.8; %N/m QUINTA ITERAZIONE  da catalogo a cui sono associati anche E ed I insieme alle dimensioni degli spessori;
max_V=[];
max_M=[];
l_tot=3.2; %metri--> lunghezza della trave orizzontale;
l_w=1.6 ; %metri-->distanza del punto di applicazione della forza peso equivalente;
x_pend=0:0.1:3; %metri -->possibili posizione in cui disporre il pendolo semplice insieme alle quali cambia anche la lunghezza della fune utilizzata;
h_fune=1; %metri -->da (RIVEDERE) --> h_fune=h_tot-h);
x_L=0.6:0.1:3; %metri--> possibili posizione occupate dal carico L durante il funzionamento;
x=0:0.1:3.2; %metri--> numero di discretizzazioni che si è deciso di adottare per analizzare la trave;
y=0:0.1:3.5; %metri--> numero di discretizzazioni  che si è deciso di adottare per analizzare la colonna;
M_col=zeros(31,25,36);
V_col=zeros(31,25,36);
N_col=zeros(31,25,36);
N1_col=[];
N2_col=[];
M_beam=zeros(length(x_pend),length(x_L),length(x)); %matrice che contiene i valori dei momenti M lungo la t.orizzontale al variare di x_L e x_pend
V_beam=zeros(length(x_pend),length(x_L),length(x));%matrice che contiene i valori dei tagli V lungo la t.orizzontale al variare di x_L e x_pend
%matrici in cui sono contenuti i valori assunti dalle reazioni dei vincoli al variare di x_L e x_pend
N_beam=zeros(length(x_pend),length(x_L),length(x));
Rb_mat=zeros(31,25);
alpha_mat=zeros(31,25);
Ra_x_mat=zeros(31,25);
Ra_y_mat=zeros(31,25);
Rd_y_mat=zeros(31,25);
Rd_x_mat=zeros(31,25);
Md_mat=zeros(31,25);


%SOLUZIONE DELLA STATICA

for z=1:length(x_pend) %diversamente da prima consideriamo le possibili posizioni del carrello;
    for i=1:length(x_L)
         alpha_1=atan(h_fune/x_pend(z));%Nella prima parte definiamo le reazioni dei vincoli associati alla trave orizzontale;
             
         Rb=(w*l_tot*l_w+L*x_L(i))/(sin(alpha_1)*(x_pend(z)+0.001));
         Ra_x=Rb*cos(alpha_1);
         Ra_y=w*l_tot-Rb*sin(alpha_1)+L;
         
         Rd_x=Rb*cos(alpha_1)-Ra_x;             %Definiamo le reazioni associate all'incastro alla base della trave;
         Rd_y=Ra_y+Rb*sin(alpha_1)+w*2*3.5;
         Md=Rb*cos(alpha_1)*h_tot-Ra_x*h;
         Rb_mat(z,i)=Rb;
         alpha_mat(z,i)=alpha_1;
         Ra_x_mat(z,i)=Ra_x;
         Ra_y_mat(z,i)=Ra_y;
         Rd_y_mat(z,i)=Rd_y;
         Rd_x_mat(z,i)=Rd_x;
         Md_mat(z,i)=Md;
         
         
%CALCOLO DEL TAGLIO E DEL MOMENTO SULLA TRAVE: in questo caso è
%diverso perchè bisogna considerare il caso più generale di tre
%possibili intervalli per le funzioni di V e M:
%1)inizio:Rb/L;
%2)Rb:L oppure L:Rb;
%3)L/Rb:fine;
%Conviene per ogni ciclo compiuto dal for inizializzare i vettori
%impiegati per evitare di avere incongruenze legate alla dimensione;
     x=[];
     x1=[];
     x2=[];
     x3=[];
     M1_beam=[];
     M2_beam=[];
     M3_beam=[];
     V1_beam=[];
     V2_beam=[];
     V3_beam=[];
     %Nel definire le condizioni di if si sono presi in considerazione 3
     %intervalli rispetto ai quali cambia l'andamento di V e M;
     %Con i secondi if si è tenuto conto degli errori del sistema nel generare 
     %i vettori x1 x2 quando si hanno x_L(i) e x_pend(z) a ridosso tra loro
     %con differenza di 0.1.
     
     if x_pend(z)<x_L(i) 
         if num2str(x_pend(z)+0.1)==num2str(x_L(i))
             x1=0:0.1:x_pend(z);
             M1_beam=Ra_y*x1-w*(x1.^2)*(1/2);
             V1_beam=-w*x1+Ra_y;

             x2=x_pend(z)+0.1;
             V2_beam=Ra_y+Rb*sin(alpha_1)-w*x2;
             M2_beam=Ra_y*x2+Rb*sin(alpha_1)*(x2-x_pend(z))-w*(x2.^2)*(1/2);

             x3=(x_L(i)+0.1):0.1:l_tot;
             V3_beam=Ra_y+Rb*sin(alpha_1)-L-w*x3;
             M3_beam=Ra_y*x3+Rb*sin(alpha_1)*(x3-x_pend(z))-L*(x3-x_L(i))-w*(x3.^2)*(1/2);
             
             
             

         else      
         
             x1=0:0.1:x_pend(z);
             M1_beam=Ra_y*x1-w*(x1.^2)*(1/2);
             V1_beam=-w*x1+Ra_y;

             x2=(x_pend(z)+0.1):0.1:x_L(i);
             V2_beam=Ra_y+Rb*sin(alpha_1)-w*x2;
             M2_beam=Ra_y*x2+Rb*sin(alpha_1)*(x2-x_pend(z))-w*(x2.^2)*(1/2);

             x3=(x_L(i)+0.1):0.1:l_tot;
             V3_beam=Ra_y+Rb*sin(alpha_1)-L-w*x3;
             M3_beam=Ra_y*x3+Rb*sin(alpha_1)*(x3-x_pend(z))-L*(x3-x_L(i))-w*(x3.^2)*(1/2);
         end
         
     elseif x_pend(z)>x_L(i) 
         if num2str((x_L(i)+0.1))==num2str(x_pend(z))
             
             x1=0:0.1:x_L(i);
             V1_beam=Ra_y-w*x1;
             M1_beam=Ra_y*x1-w*(x1.^2)*(1/2);

             x2=x_L(i)+0.1;
             V2_beam=Ra_y-L-w*x2;
             M2_beam=Ra_y*x2-L*(x2-x_L(i))-w*(x2.^2)*(1/2);

             x3=(x_pend(z)+0.1):0.1:l_tot;
             V3_beam=Ra_y-L+Rb*sin(alpha_1)-w*x3;
             M3_beam=Ra_y*x3-L*(x3-x_L(i))+Rb*sin(alpha_1)*(x3-x_pend(z))-w*(x3.^2)*(1/2);


         
         else
             x1=0:0.1:x_L(i);
             V1_beam=Ra_y-w*x1;
             M1_beam=Ra_y*x1-w*(x1.^2)*(1/2);

             x2=(x_L(i)+0.1):0.1:x_pend(z);
             V2_beam=Ra_y-L-w*x2;
             M2_beam=Ra_y*x2-L*(x2-x_L(i))-w*(x2.^2)*(1/2);

             x3=(x_pend(z)+0.1):0.1:l_tot;
             V3_beam=Ra_y-L+Rb*sin(alpha_1)-w*x3;
             M3_beam=Ra_y*x3-L*(x3-x_L(i))+Rb*sin(alpha_1)*(x3-x_pend(z))-w*(x3.^2)*(1/2);
         end


     elseif num2str(x_pend(z))==num2str(x_L(i)) 
         
         x1=0:0.1:x_L(i);
         V1_beam=Ra_y-w*x1;
         M1_beam=Ra_y*x1-w*(x1.^2)*(1/2);

         x2=x_L(i)+0.1:0.1:l_tot;
         V2_beam=Ra_y-L+Rb*sin(alpha_1)-x2*w;
         M2_beam=Ra_y*x2+(x2-x_pend(z))*(-L+Rb*sin(alpha_1))-w*(x2.^2)*(1/2);
     end
     
     %Definiamo quindi gli elementi di V_col e M_col che non modificano la
     %posizione come per la trave orizzontale ma cambiano i moduli con i e z;
     
      V1_col=zeros(1,26);
      V2_col=Rb*cos(alpha_1)*ones(1,10);
      
      M1_col=Md*ones(1,26);
      y2=y(27:end);
      M2_col=Md-Rb*cos(alpha_1)*(y2-h);
      
      y_rev=3.5:-0.1:0; %DISTINGUIAMO LO SFORZO NORMALE ASSOCIATO AL PESO E QUELLO ASSOCIATO ALLE REAZIONI DEI VINCOLI
      N1_col_b=ones(1,26)*(-Ra_y-Rb*sin(alpha_1)); %applicazione non baricentrica --> GENERA MOMENTO FLETTENTE
      N2_col_b=-ones(1,10)*Rb*sin(alpha_1);
      
      N1_col_w=-y_rev(1:26)*2*w; %applicazione baricentrica --> NON GENERA MOMENTO FLETTENTE
      N2_col_w=-y_rev(27:end)*2*w;
      
      N1_col=N1_col_b+N1_col_w;
      N2_col=N2_col_b+N2_col_w;
      
     
     %Definiamo le matrici 3D M, N e V contenenti tutte le possibili
     %configurazioni lungo x (trave) e y (colonna) al variare delle posizioni di
     %pendolo (fune) e carico L;
     
     N_beam_post=zeros(1,(33-length(x_pend)));
     V_beam(z,i,:)=[V1_beam V2_beam V3_beam];
     M_beam(z,i,:)=[M1_beam M2_beam M3_beam]; 
     N_beam(z,i,:)=[-Ra_x*ones(1,length(x_pend)) N_beam_post];
     
     V_col(z,i,:)=[V1_col V2_col];
     M_col(z,i,:)=[M1_col M2_col];
     N_col(z,i,:)=[N1_col N2_col];
     N_col_w(z,i,:)=[N1_col_w N2_col_w];
     N_col_b(z,i,:)=[N1_col_b N2_col_b];
     
    end
end

M_min=8000*ones(1,25*31);
V_min=8000*ones(1,25*31);
%Con i seguenti cicli for andiamo a determinare per quale possibile
%cposizione del pendolo si ha la distribuzione minima di M e V sulla trave
%considerando l'eventuale spostamento del carico L;basilius-besler

for z=2:length(x_pend) %RICORDATI CHE NELLA POSIZIONE (1,1) SI OTTENGONO VALORI STRANI DAL MOMENTO CHE Rb TENDE AD INF. --> escludine i risultati
    M_sum_var_L=[];
    V_sum_var_L=[];
    for j=1:length(x_L)
        M_sum_var_L=[M_sum_var_L M_beam(z,j,:)];
        V_sum_var_L=[V_sum_var_L V_beam(z,j,:)];
    end
    
    M_sum_var_L=reshape(M_sum_var_L,1,25*33);
    V_sum_var_L=reshape(V_sum_var_L,1,25*33);

    if sum(abs(M_sum_var_L))<sum(abs(M_min))
        M_min=M_sum_var_L;
        pos_opt_pend_M=z;
    end
    if sum(abs(V_sum_var_L))<sum(abs(V_min))
        V_min=V_sum_var_L;
        pos_opt_pend_V=z;
    end
end

 

    
        
 
             
   
         
         
        

    
         

     
     
     

