function []= plot_N_col(num1,num2)
variazione_pos_carrello;
x=0:0.1:3.5;

N_plot=reshape(N_col(num1,num2,:),1,36);
plot(x,N_plot,'b');


end