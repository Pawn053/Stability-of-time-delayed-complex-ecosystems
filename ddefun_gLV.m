function dx = ddefun_gLV(t,y,Z,r,A)
%This function gives the gLV dynamics used in our paper
%

[m1,n1]=size(y);

for i=1:m1
    for j=1:n1
        if(abs(y(i,j))<=1e-3)
            y(i,j)=0;
        end
    end
end

tau1=Z(:,1);

dx=diag(y)*(r+A*tau1);

%dx=A*(tau1-1);

end

