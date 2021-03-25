function []=plot_V_col(num1,num2) %La funzione permette di plottare i V_col mettendo come input la posizione del pendolo
variazione_pos_carrello;
x=0:0.1:3.5;

V_plot=reshape(V_col(num1,num2,:),1,36);
plot(x,V_plot,'r');


end
