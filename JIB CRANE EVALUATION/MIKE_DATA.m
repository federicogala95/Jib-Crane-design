%%DATA FOR THE SCRIPT:
h_sez=267; %mm
h_i=249.6; %mm
t_w=5.5; %mm
t_f=8.7;%mm
b=135; %mm
A_beam=39.2*10^2;%mm %%

%MIKE DATA:
A=2330; %mm
h = 2500;
C = 3500; 
b = 150;

%Column Cross Section:
f__c = 120; %mm
h__c = 230;
a__c = 10;
s__c = 10;
e__c = 5;

%Boom Cross Section:
b__d = 91; %mm
h__d = 177;
a__d = 4.3;
e__d = 6.5;
%Normal Stress Excentricity:
S__c = (h__c+2*s__c)/2; %mm^2
S__b = h__d/2; %mm^2

alpha = atan((C-h-2*S__b-b)/(A-b)); %rad
L__a = (A-b)/(cos(alpha));
L = 3200;
L__b = L - b;


%Tie rod diameter:
d__a = 18; %mm^2

%Moments of Inertia and Torsion:
I__xd = 1.063 * 10^7;

I__xc = 2*((1/12)*a__c*h__c^3+((1/2)*f__c-(1/2)*a__c-e__c)^2*a__c*h__c) + 2*((1/12)*f__c*s__c^3+((1/2)*h__c+(1/2)*s__c)^2*s__c*f__c);

I__yc = 2*((1/12)*a__c^3*h__c+((1/2)*h__c+(1/2)*s__c)^2*a__c*h__c)+2*((1/12)*f__c^3*s__c+((1/2)*f__c-(1/2)*a__c-e__c)^2*s__c*f__c);

A__a = (1/4)*pi*d__a^2;

A__b = 2*(b__d*e__d+a__d*((1/2)*h__d-e__d));

A__c = 2*(a__c*h__c+f__c*s__c);

A__m = (f__c-2*e__c-a__c)*(h__c+s__c);

J__tc = 4*A__m^2/((2*(f__c-2*e__c-a__c))/s__c+(2*(h__c+s__c))/a__c);


%Normal Stress Excentricity:
S__c = (h__c+2*s__c)/2; %mm^2
S__b = h__d/2; %mm^2

%Moment of Inertia along the boom and the column: 
I_col_xx=1.4418e+07; %mm^4     %10630000.00; previous value
I_col_zz=5.4858e+07; %mm^4    %225475000/3 previous value
J__tc=576000000/17; %mm^4
I_beam_zz=I__xd;
%Material:

E = 210000;
gamma__a = 77110;
phi = 2.5; 
sigma__ys = 355;
sigma__eq = sigma__ys/phi;
nu = 0.3;
G = E/(2*(1+nu));
%Volumes (Tie Rod, Boom, Column):
V__a = L__a*A__a*10^(-9);
V__b = L__b*A__b*10^(-9);
V__c = C*A__c*10^(-9);

%Weigth Linear Distribution:
p__a = V__a*gamma__a/L__a*1000;
p__b = V__b*gamma__a/L__b*1000;
p__c = V__c*gamma__a/C*1000;
P__a = p__a*L__a;
P__b = p__b*L__b;
P__c = p__c*C;


