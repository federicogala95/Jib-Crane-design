function [pos_max]=pos_max_vec(vec)
for i=1:length(vec)
    if vec(i)==max(vec)
        pos_max=i;
    end
end