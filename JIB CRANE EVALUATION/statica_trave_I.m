%DEFINIZIONE DELLE FORZE IN GIOCO AL VARIARE DELLA POSIZIONE DEL CARICO L E
%DEL CAVO APPROSSIMATO A PENDOLO SEMPLICE INCLINATO CON ANGOLO ALPHA:
M=[];
V=[];
x=[];
L=9800; %Newton
w=214; %N/m prima approssimazione da catalogo
max_V=[];
max_M=[];
l_tot=3.2; %metri
l_w=1.6 ; %distanza del punto di applicazione della forza peso equivalente
x_pend=3;%posizione pendolo CASO1
h_fune=1; %da RIVEDERE
x_L=0.6:0.1:3; %SOLUZIONE DELLA STATICA
for i=1:length(x_L)
    alpha=atan(h_fune/x_pend);
    Rb=(w*l_tot*l_w+L*x_L(i))/(sin(alpha)*x_pend);
     Ra_x=Rb*cos(alpha);
     Ra_y=w*l_tot-Rb*sin(alpha)+L;
     
     if x_L(i)<x_pend
         x1=0:0.1:x_L(i);
         V1=Ra_y-w*x1;
         M1=Ra_y*x1-w*(x1.^2)*(1/2);
         x2=x_L(i)+0.1:0.1:x_pend;
         V2=Ra_y-w*x2-L;
         M2=Ra_y*x2-w*(x2.^2)*(1/2)-L*(x2-x_L(i));
         x3=x_pend+0.1:0.1:l_tot;
         V3=Rb*sin(alpha)+Ra_y-w*x3;
         M3=-w*(x3.^2)*(1/2)+Ra_y*x3-L*(x3-x_L(i))+Rb*sin(alpha)*(x3-x_pend);
    
     elseif x_L(i)==x_pend
         x1=0:0.1:x_L(i);
         V1=Ra_y-w*x1;
         M1=Ra_y*x1-w*(x1.^2)*(1/2);
         x2=x_L(i)+0.1:0.1:l_tot;
         V2=Rb*sin(alpha)+Ra_y-w*x2;
         M2=-w*(x2.^2)*(1/2)+Ra_y*x2-L*(x2-x_L(i))+Rb*sin(alpha)*(x2-x_pend);
         M3=[];
         V3=[];
         x3=[];
     end
         
     x=[x1 x2 x3];
     V(i,:)=[V1 V2 V3];
     M(i,:)=[M1 M2 M3];
     
     j=i;
end
v=max(abs(M(1,:)));
q=max(abs(V(1,:)));
for j=1:length(x_L)
    if max(abs(M(j,:)))>=v 
        v=max(abs(M(j,:)));
        conf_M_max=j;
        posizione_x_max_M=pos_max_vec(abs(M(j,:)));

    end
end
for k=1:length(x_L)
    if max(abs(V(k,:)))>=q 
        q=max(abs(V(k,:)));
        conf_V_max=k;
        posizione_x_max_V=pos_max_vec(abs(V(k,:)));
    end
    
end
mean_vec_max=max(abs(V(1,:)+M(1,:)));
j=[];
for j=1:length(x_L)
    if max(abs(V(j,:)+M(j,:)))>=mean_vec_max
        mean_vec_max=max(abs(V(j,:)+M(j,:)));
        mean_vec=abs(V(j,:)+M(j,:));
        conf_mean_max=j;
        pos_max_mean=pos_max_vec(mean_vec);
    end
end
figure(1)
plot(x,M(conf_M_max,:),'r')
hold on
plot(x,V(conf_V_max,:),'b')
plot(x,mean_vec,'g')

fprintf('Il momento flettente sulla trave, assume valore massimo %f in x pari a %f, quando il carico L è posizionato il x_L=%f\n',max(max(abs(M))),x(posizione_x_max_M),x_L(conf_M_max));

fprintf('Il taglio sulla trave, assume valore massimo %f in x pari a %f, quando il carico L è posizionato il x_L=%f\n',max(max(abs(V))),x(posizione_x_max_V),x_L(conf_V_max));

fprintf('La configurazione in cui si rigestrano simultaneamente le maggiori sollecitazioni di M e V è quella per il cui il carico L si trova a x_L=%f\n',x_L(conf_mean_max));

         

     
     
     

