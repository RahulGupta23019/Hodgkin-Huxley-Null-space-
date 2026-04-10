%%
Coplng_coeff=1e-4;%Coupling coefficient
Vperturb=2;%mV
Range_init=0;Range_finl=1;%Range of old-phases
%%
StandardDataCreation;
%%
Npertb_sites=21;
Old_phases=linspace(Range_init,Range_finl,Npertb_sites);
Pertb_index=round(iip*Old_phases);
ii=iio+Pertb_index;
New_phases=zeros(1,length(ii));

n=7;

%%
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