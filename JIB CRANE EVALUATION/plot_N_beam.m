function []= plot_N_beam(num1,num2)
variazione_pos_carrello;
x=0:0.1:3.2;

N_plot=reshape(N_beam(num1,num2,:),1,33);
plot(x,N_plot,'b');


end