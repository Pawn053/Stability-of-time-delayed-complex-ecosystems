% This file generates the response of a time-delayed system to external
% perturbations

% This file can be used to generate Fig. 1c, Fig. 1e, Fig. 2a, Fig. 3c-3f

clear; clc;
close all;

tau_c=1.5; time_end=500;

S=2; d=1; mu=0.1;

for i=1:S
    for j=i+1:S
        A(i,j)=mu;
        A(j,i)=-mu;
    end
end

for i=1:S
    
    A(i,i)=-d;
    
end

%%

lambda=eig(A);
lambda_real=real(lambda);
lambda_imag=imag(lambda);

syms z;

for i=1:S
    
    f(z)=z-lambda(i)*exp(-z*tau_c);
    
    stability_temp(i)=double(real(solve(f(z)==0)));
    
end

stability=-max(round(stability_temp,2))

%%
linewidth1=3;

%%

t_d_total=NaN; t_d_each=NaN;

x_eq=ones(S,1);

r=-A*x_eq;

perturb_num=1;
perturbation=1; r_c=abs(perturbation*0.001);

for i=1:S
    if(i==perturb_num)
        x0(i)=x_eq(i)+perturbation;
    end
    if(i~=perturb_num)
        x0(i)=x_eq(i);
    end
end

opts=ddeset('RelTol',1e-5,'AbsTol',1e-5,'InitialY',x0);

sol=dde23(@(t,y,Z)ddefun_gLV(t,y,Z,r,A),tau_c,x_eq,[0 time_end],opts);

x_simu=sol.y'; t_simu=sol.x;

deviation_simu=x_simu-1;

[m,n]=size(x_simu);

for i=1:m
    abundance_simu(i,1)=sum(x_simu(i,:));
end

total_abundance_flag=recover_judge(abundance_simu,S*x_eq,r_c);
if(total_abundance_flag~=inf)
    t_d_total=t_simu(total_abundance_flag);
end

each_abundance_flag=recover_judge(x_simu,x_eq,r_c);
if(each_abundance_flag~=inf)
    t_d_each=t_simu(each_abundance_flag)
end

t_before_perturb=1;
delta_before_perturb=0.01;
num_interval1=t_before_perturb/delta_before_perturb;

for i=1:num_interval1-1
    t_before(i)=delta_before_perturb*i;
    abundance_before(i)=S;
    
    for j=1:S
        
        x_before(i,j)=x_eq(j);
        
    end
end

t_plot=t_simu+t_before_perturb;
t_plot=[t_before,t_plot];
x_plot=[x_before;x_simu];

figure(1);
% set(gcf,'unit','normalized','position',[0,0,0.5*0.6,0.3*1.2]);
% [ha, pos] = tight_subplot(1, 1, [0.02,0.05], [0.15,0.05], [0.08,0.05]);
% %[ha, pos] = tight_subplot(行, 列, [上下间距,左右间距],[下边距,上边距 ], [左边距,右边距 ])
% 
% axes(ha(1));

color=colormap(lines(S));

for i=1:S
    %species(i)=plot(t_simu(1:t_before_perturb/delta),x_simu(1:t_before_perturb/delta,i),'linewidth',2,'color',color(i,:));
    %hold on;
    %species(i)=plot(t_simu(t_before_perturb/delta+1:end),x_simu(t_before_perturb/delta+1:end,i),'linewidth',2,'color',color(i,:));
    
    species_before(i)=plot(t_before,x_before(:,i),'linewidth',linewidth1,'color',color(i,:));
    hold on;
    species_after(i)=plot(t_simu+t_before_perturb,x_simu(:,i),'linewidth',linewidth1,'color',color(i,:));
    hold on;
    
end

t_d_label_y=0:0.001:1+r_c;
t_d_label_x=t_d_each*ones(length(t_d_label_y),1)+t_before_perturb;
plot(t_d_label_x,t_d_label_y,'--k','linewidth',1);
hold on;

t_p_label_y=0:0.01:1+perturbation;
t_p_label_x=t_before_perturb*ones(length(t_p_label_y),1);
plot(t_p_label_x,t_p_label_y,'--k','linewidth',1);

abundance_mean=ones(1,max(size(t_simu)));
abundance_up=ones(1,max(size(t_simu)))+r_c;
abundance_low=ones(1,max(size(t_simu)))-r_c;

fill([t_simu,fliplr(t_simu)],[abundance_low,fliplr(abundance_up)],[0.5 0.5 0.5],'FaceAlpha',0.3,'EdgeAlpha',0);
hold on;

%axis([min(t_simu)-range(t_simu)/10,max(t_simu)+range(t_simu)/10,min(min(x_simu))-max(range(x_simu))/5,max(max(x_simu))+max(range(x_simu))/5]);
axis([min(t_simu),max(t_simu),0,2.5]);

t1=text(6,2.3,['Stability=',num2str(stability)],'fontsize',25);
set(t1,'units','normalized','position',[0.6 0.9]);

xlim=get(gca,'xlim');
ylim=get(gca,'ylim');
set(gca,'ytick',[1 2]);
set(gca,'yticklabel',[1 2]);
%set(gca,'xtick',[0 1 2 3 4 5 6 7 8 9 10 11 12]);
%set(gca,'xticklabel',{'0','','2','','4','','6','','8','','10','','12'});
%set(gca,'xtick',[0 20 40 60]);
set(gca,'fontsize',25);