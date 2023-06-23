function recover_num = single_species_judge(abundance,x_eq,r_c)
% This function judges whether a single species recovers to its equilibrium
%

m=max(size(abundance)); recover_status=ones(m,1);
flag=-300;

for i=1:m
    if(abs(abundance(i)-x_eq)<=r_c)
        recover_status(i)=0;
    end
end

for i=1:m
    if(recover_status(i)==0)
        status_behind=sum(recover_status(i:end));
        if(status_behind==0)
            flag=i;
            break;
        end
    end
end

if(flag==-300)
    recover_num=inf;
end

if(flag~=-300)
    recover_num=flag;
end

end

