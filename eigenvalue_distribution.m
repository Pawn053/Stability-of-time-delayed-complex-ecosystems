% This file generates the eigenvalue distribution of community matrix for
% different types of communities

% This file can be used to generate Fig. 1d, Fig. 1f, Fig. 2b and Fig. 4c

clc; clear;
close all;

S=500; C=0.2; d=1; mu=0; sigma=0.15;

X_eq=1;

pm=1; pc=0; pe=0; pam=0; pcm=0;

for num_sample=1:10
    
    %A_interaction=interaction_existence_bipartite_nested(S,C,d);
    
    %A=interaction_matrix_bipartite_nested(A_interaction,mu,sigma);
    
    A_interaction=interaction_existence_FixedEdge(S,C,d);
    
    A=interaction_matrix(A_interaction,S,mu,sigma,pm,pc,pe,pam,pcm);
    
    X=diag(X_eq*ones(S,1));
    
    M=X*A;
    
    lambda_M=eig(M);
    
    lambda_M_real=real(lambda_M);
    lambda_M_imag=imag(lambda_M);
    
    figure(1);
    scatter(lambda_M_real,lambda_M_imag,20,'filled');
    hold on;
    grid on;
    axis equal;
    
end

[boundary_left, boundary_right, center, boundary_up, outlier] = eigenvalue_distribution_M_the(S, C, d,sigma ,pm, pc, pe, pam, pcm);

x0=center; y0=0; a=boundary_right-center; b=boundary_up;

plot_ellipse(x0,y0,a,b,0);
hold on;

scatter(outlier,0,50,'filled','MarkerFaceColor','k','MarkerEdgeColor','k');