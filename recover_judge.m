function recover_num = recover_judge( x_solution, x_eq, r_c)
% This function judges whether the whole community recovers to its
% equilibrium
%

[m,n]=size(x_solution);
recover_flag=zeros(n,1);

for i=1:n
    recover_flag(i)=single_species_judge(x_solution(:,i),x_eq(i),r_c);
end

recover_num=max(recover_flag);

end

