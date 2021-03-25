function []=plot_M_col(num1,num2) %La funzione permette di plottare i M_col mettendo come input la posizione del pendolo
variazione_pos_carrello;
x=0:0.1:3.5;
M_plot=reshape(M_col(num1,num2,:),1,36);
plot(x,M_plot,'r');
end

