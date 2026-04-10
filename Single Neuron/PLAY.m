%%
load('StandardData.mat');
%%
Vperturb=-60;%mV
Range_init=0;Range_finl=1;%Range of old-phases

iio=3969101;%initial 0 phase time index 
iip=1541238;%time-period in terms of number of time indices

Npertb_sites=21;
Old_phases=linspace(Range_init,Range_finl,Npertb_sites);
Pertb_index=round(iip*Old_phases);
ii=iio+Pertb_index;
New_phases=zeros(1,length(ii));

n=15;

%%
Ti=0;Tf=300;Ntme=30000001;
t=linspace(Ti,Tf,Ntme);
dt=(Tf-Ti)/(Ntme-1);

for iter=1:length(ii)
    HHsimulate;
end
%%
figure; hold on;
for iter=1:length(ii)
    if New_phases(iter)~=10
        plot(Old_phases(iter),New_phases(iter),'o','MarkerFaceColor','r','MarkerEdgeColor','none');
    else
        xline(Old_phases(iter),'k','LineWidth',2);
    end
end

xlim([0,1]);ylim([0,1]);
xlabel('\phi');ylabel('\psi');
axis square;