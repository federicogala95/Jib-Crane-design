%EVOLUZIONE DEL FILE STATICA_TRAVE_I IN CUI CERCHIAMO DI OTTIMIZZARE LA POSIZIONE DEL CARRELLO PER MINIMIZZARE 
%TAGLIO E MOMENTO FLETTENTE SULLE SEZIONI:
function [ M_beam_sol ] = stat_M_beam(a,b) %dove a definisce la posizione del pendolo e b definisce 
%la posizione del caricos

variazione_pos_carrello;
        
  M_beam_sol=M_beam(a,b,:);
  V_beam_sol=V_beam(a,b,:);
  M_col_sol=M_col(a,b,:);
  V_col_sol=V_col(a,b,:);
end
        

    
         

     
     
     

