function []=plot_beam_static(num1_1,num2_2)
variazione_pos_carrello;
x=0.1:0.1:3.2;
V_plot=reshape(V_beam(num1_1,num2_2,:),1,32);
M_plot=reshape(M_beam(num1_1,num2_2,:),1,32);
N_plot=reshape(N_beam(num1_1,num2_2,:),1,32);
plot(x,V_plot,'g',x,M_plot,'r',x,N_plot,'b');

end


