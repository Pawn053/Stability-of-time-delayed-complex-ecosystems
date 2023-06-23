function [boundary_left, boundary_right, center, boundary_up, outlier] = eigenvalue_distribution_M_the(S, C, d,sigma ,pm, pc, pe, pam, pcm)
%UNTITLED9 此处显示有关此函数的摘要
%   此处显示详细说明

E_abs=sqrt(2/pi)*sigma;

if(pm+pc+pe+pam+pcm == 0)
    
    boundary_left=-d-sigma*sqrt(S*C);
    boundary_right=-d+sigma*sqrt(S*C);
    
    center=-d;
    boundary_up=sigma*sqrt(S*C);
    
    outlier=-d;
    
end

if(pm+pc+pe+pam+pcm == 1)
    
    E=C*E_abs*(pm-pc+0.5*(pam-pcm));
    V=C*sigma^2*(1-0.5*(pam+pcm))-E^2;
    beta=sqrt(S*V);
    tau=C*E_abs^2*(2*(pm+pc)+pam+pcm-1)-E^2;
    tau=tau/V;
    
    center=-d-E;
    boundary_left=center-beta*(1+tau);
    boundary_right=center+beta*(1+tau);
    boundary_up=beta*(1-tau);
    
    %outlier=-d+(S-1)*E+(tau*V)/E;
    outlier=-d+(S-1)*E;
    
end

end

