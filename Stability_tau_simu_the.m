% This file generates theoretical and simulated relationships between
% system stability and delay length for different types of communities

% This file can be used to generate Fig. 3a, Fig. 3b and Fig. 4a

clear; clc;
close all;

syms z;

S=50; C=0.1; mu=0; sigma=0.05;

p_interaction{1}=[0 0 0 0 0];
p_interaction{2}=[0 0 1 0 0];
p_interaction{3}=[0 1 0 0 0];
p_interaction{4}=[1 0 0 0 0];

d=1; X_eq=1; S_step_the=1;

tau_start=0.1; tau_step=0.1; tau_end=2;

num_sample=50;

flag1=1;
for community_type=1:4
    
    pm=p_interaction{community_type}(1);
    pc=p_interaction{community_type}(2);
    pe=p_interaction{community_type}(3);
    pam=p_interaction{community_type}(4);
    pcm=p_interaction{community_type}(5);
    
    flag2=1;
    for tau_c=tau_start:tau_step:tau_end
        
        for num=1:num_sample
            
            A_interaction=interaction_existence_FixedEdge(S,C,d);
            A=interaction_matrix(A_interaction,S,mu,sigma,pm,pc,pe,pam,pcm);
            M=diag(X_eq)*A;
            
            lambda_simu=eig(M);
            
            lambda_simu_real=real(lambda_simu);
            lambda_simu_imag=imag(lambda_simu);
            
            [m,n]=size(lambda_simu_real);
            
            clear stability_temp_num;
            for temp=1:max(m,n)
                
                lambda_temp=lambda_simu_real(temp)+i*lambda_simu_imag(temp);
                
                f(z)=z-lambda_temp*exp(-z*tau_c);
                
                stability_temp_num(temp)=double(solve(f(z)==0));
                
                stability_temp_num(temp)=real(stability_temp_num(temp));
                
            end
            
            stability_temp(num)=max(stability_temp_num);
            
        end
        
        stability_simu_mean{flag1}(flag2)=mean(stability_temp);
        stability_simu_std{flag1}(flag2)=std(stability_temp);
        
        [boundary_left, boundary_right, center, boundary_up outlier] = eigenvalue_distribution_M_the(S, C, d,sigma ,pm, pc, pe, pam, pcm);
        
        clear lambda_the;
        lambda_the(1)=boundary_left+0*i;
        lambda_the(2)=boundary_right+0*i;
        lambda_the(3)=outlier+0*i;
        lambda_the(4)=center+boundary_up*i;
        
        for flag3=1:4
            
            f(z)=z-lambda_the(flag3)*exp(-z*tau_c);
            
            stability_the_temp(flag3)=double(solve(f(z)==0));
            
            stability_the_temp(flag3)=real(stability_the_temp(flag3));
            
        end
        
        stability_the{flag1}(flag2)=max(stability_the_temp);
        
        stability_nodelay{flag1}(flag2)=max(real(lambda_the));
        
        flag2=flag2+1;
        
    end
    
    flag1=flag1+1
    
end

tau_plot=tau_start:tau_step:tau_end;

color=colormap(lines(4));

for community_type=1:4
    
    p{community_type}=plot(tau_plot,-stability_simu_mean{community_type},'linewidth',3,'color',color(community_type,:));
    hold on;
    p{community_type}=plot(tau_plot,-stability_the{community_type},'--','linewidth',3,'color',color(community_type,:));
    hold on;
    
end

l1=legend([p{1},p{2},p{3},p{4}],'Random','+/-','-/-','+/+');
set(l1,'location','best','box','off');