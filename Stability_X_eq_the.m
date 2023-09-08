% This file generates the theoretically-estimated relationship 
% between system stability and equilibrium abundance

% This file can be used to generate Fig. 5

clear; clc;
close all;

syms z;

S=100; C=0.1; mu=0; sigma=0.1;

p_interaction{1}=[0 0 0 0 0];
p_interaction{2}=[0 0 1 0 0];
p_interaction{3}=[0 1 0 0 0];
p_interaction{4}=[1 0 0 0 0];

d=1; tau_c=0.7;

X_start=0.01; X_step=0.01; X_end=4;

flag1=1;
for community_type=1:4
    
    pm=p_interaction{community_type}(1);
    pc=p_interaction{community_type}(2);
    pe=p_interaction{community_type}(3);
    pam=p_interaction{community_type}(4);
    pcm=p_interaction{community_type}(5);
    
    flag2=1;
    for X_eq=X_start:X_step:X_end
        
        [boundary_left, boundary_right, center, boundary_up outlier] = eigenvalue_distribution_M_the(S, C, d,sigma ,pm, pc, pe, pam, pcm);
        
        boundary_left=X_eq*boundary_left;
        boundary_right=X_eq*boundary_right;
        center=X_eq*center;
        boundary_up=X_eq*boundary_up;
        outlier=X_eq*outlier;
        
        clear lambda;
        lambda(1)=boundary_left+0*i;
        lambda(2)=boundary_right+0*i;
        lambda(3)=outlier+0*i;
        lambda(4)=center+boundary_up*i;
        
        for flag3=1:4
            
            f(z)=z-lambda(flag3)*exp(-z*tau_c);
            
            stability_temp(flag3)=double(solve(f(z)==0));
            
            stability_temp(flag3)=real(stability_temp(flag3));
            
        end
        
        stability{flag1}(flag2)=max(stability_temp);
        stability_nodelay{flag1}(flag2)=max(real(lambda));
        
        flag2=flag2+1;
        
    end
    
    flag1=flag1+1
    
end

X_plot=X_start:X_step:X_end;

figure(1);

for community_type=1:4
    
    p1{community_type}=plot(X_plot,-stability{community_type},'linewidth',3);
    hold on;
    
end

l1=legend([p1{1},p1{2},p1{3},p1{4}],{'Random','+/-','-/-','+/+'});
set(l1,'location','best','box','off');

set(gca,'fontsize',25);

figure(2);

for community_type=1:4
    
    p2{community_type}=plot(X_plot,-stability_nodelay{community_type},'linewidth',3);
    hold on;
    
end

l1=legend([p2{1},p2{2},p2{3},p2{4}],{'Random','+/-','-/-','+/+'});
set(l1,'location','best','box','off');

set(gca,'fontsize',25);
