% This file generates the stability contour plot

% This file can be used to generate Fig. 1d, Fig. 1f, Fig. 2b, Fig. 4b and
% Fig. 4c

clear; clc;
close all;

tau=0.4;

range_start=-8; range_step=0.1; range_end=8;

flag1=1;
for a=range_start:range_step:range_end
    flag2=1;
    for b=range_start:range_step:range_end
        lambda=a+b*i;
        syms x;
        if(tau~=0)
            z(flag1,flag2)=real(double(solve(x-lambda*exp(-x*tau))));
        end
        if(tau==0)
            z(flag1,flag2)=a;
        end
        flag2=flag2+1;
    end
    flag1=flag1+1
end

[A,B]=meshgrid(range_start:range_step:range_end,range_start:range_step:range_end);
figure(1);
surf(A,B,z);
figure(2);
contourf(B,A,z,[-1.6:0.4:0]);
