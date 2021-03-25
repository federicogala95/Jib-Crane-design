function []=plot_col_static(num1_1,num2_2)
variazione_pos_carrello;
x=0:0.1:3.5;
V_plot=reshape(V_col(num1_1,num2_2,:),1,36);
M_plot=reshape(M_col(num1_1,num2_2,:),1,36);
N_plot=reshape(N_col(num1_1,num2_2,:),1,36);
plot(x,V_plot,'g',x,M_plot,'r',x,N_plot,'b');

end



