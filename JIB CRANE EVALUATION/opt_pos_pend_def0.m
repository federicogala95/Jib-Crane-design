% POSITION OF THE ROD TIE THAT MINIMIZE DEFORMATION RELATED TO POSSIBLE LOAD POSITION: 
%The script compares all the admissible deformation obtained by def_x_L and
%takes the one position of the x_pend which guarantees the minimum value of
%the mean deformation of the load position (mean cause it consider all
%the 25 possibile x_L associated with specific pend position)

%IT DOES NOT CONSIDER THE EFFECT OF LOAD ECCENTRICITY YET!
pos_def_opt=[];
def_x_L_theta0; 
matrix=[];
%The for cicle reduce the dimension of the matrix containing all admissible
%positions in order to get rid of zeros;
def_amm_mat1=def_amm_mat;
def_amm_mat1(1,:)=[];
matrix=def_amm_mat1;
%Since dimension of the variable "matrix" has changed we need to find out
%how many rows it got in order to be possible to do the for cicle;
%We then define the element "vec_1" as a reference vector that we use to
%compare mean value in the iteration ;
[row col]=size(matrix);
vec_1=matrix(1,:);

for z=1:row
    if mean(matrix(z,:))<mean(vec_1)
        vec_1=matrix(z,:);
        pos_def_opt=matrix(z,25);
    else
        pos_def_opt=vec_1(25);
    end
end
fprintf("The obtained matrix represents all the possible positions for the TIE ROD and the associated deformations\nThe scalar is the best TIE position through the possible ones ")

pos_def_opt
def_amm_pend=matrix
SF_0=vec_1/(40/1.5)
def_opt_0=vec_1
%Safe Factor related to the deformation when theta is equal to 0 degree;
%The resulting value of the cicle, named "pos_def_opt" should be equal to
%the searched position for the tie rod!

