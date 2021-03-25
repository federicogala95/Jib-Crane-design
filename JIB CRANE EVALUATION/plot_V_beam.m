function []=plot_V_beam(num1,num2) %La funzione permette di plottare i V_beam mettendo come input la posizione del pendolo
variazione_pos_carrello;
x=0:0.1:3.2;

V_plot=reshape(V_beam(num1,num2,:),1,33);
plot(x,V_plot,'g');


end
