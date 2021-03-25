function []=plot_M_beam(num1,num2) %La funzione permette di plottare i M_beam mettendo come input la posizione del pendolo
variazione_pos_carrello;
x=0:0.1:3.2;
M_plot=reshape(M_beam(num1,num2,:),1,33);
plot(x,M_plot,'r');


end
