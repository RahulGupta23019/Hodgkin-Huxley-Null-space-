Ti=0;Tf=100;Ntme=10000001;
t=linspace(Ti,Tf,Ntme);
dt=(Tf-Ti)/(Ntme-1);

V=zeros(1,Ntme);
M=zeros(1,Ntme);
N=zeros(1,Ntme);
H=zeros(1,Ntme);
V(1)=0.000000000954277;
M(1)=0.052932485265060;
N(1)=0.317676914048829;
H(1)=0.596120753523087;


%parameters
Cm=1;
Vna=-115;
Vk=12;
Vl=-10.59892097;
gNa=120;
gK=36;
gL=0.3;
Temp=6.3;
Temp_factor=(3^((Temp-6.3)/10));
Iamp=-8.75;
I=Iamp*ones(1,Ntme);
I(1:10000)=0.0;

for i=1:Ntme-1
    
    V(i+1)=V(i)+dt*(1/Cm)*(I(i)-(gK*(N(i)^4)*(V(i)-Vk))-(gNa*(M(i)^3)*H(i)*(V(i)-Vna))-(gL*(V(i)-Vl)));
    
    Am=Temp_factor*(0.1*(V(i)+25))/(exp((V(i)+25)/10)-1);
    Bm=Temp_factor*4*exp(V(i)/18);
    M(i+1)=M(i)+dt*(Am*(1-M(i))-Bm*M(i));
    
    An=Temp_factor*(0.01*(V(i)+10))/(exp((V(i)+10)/10)-1);
    Bn=Temp_factor*0.125*exp(V(i)/80);
    N(i+1)=N(i)+dt*(An*(1-N(i))-Bn*N(i));
    
    Ah=Temp_factor*0.07*exp(V(i)/20);
    Bh=Temp_factor*1/(exp((V(i)+30)/10)+1);
    H(i+1)=H(i)+dt*(Ah*(1-H(i))-Bh*H(i));
    
end

iio=3969101;%initial 0 phase time index 
iip=1541238;%time-period in terms of number of time indices

Vstd=V(iio:(iio+iip));
Mstd=M(iio:(iio+iip));
Nstd=N(iio:(iio+iip));
Hstd=H(iio:(iio+iip));

Vo=-4.96; Mo=0.093; No=0.396; Ho=0.42;%Steady focus within limit cycle.

filename='StandardData.mat';
save(filename,'Vstd','Mstd','Nstd','Hstd','Vo','Mo','No','Ho');

figure(1);plot(Vstd,Hstd);
figure(2);plot(t(iio:(iio+iip)),Vstd);
