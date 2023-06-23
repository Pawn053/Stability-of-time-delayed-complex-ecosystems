function A_original = interaction_matrix(A_interaction,S,mu,sigma,pm,pc,pe,pam,pcm)
% This function generates the interaction matrix for different types of
% communities

A_original=zeros(S,S); temp=A_interaction;

if(pm+pc+pe+pam+pcm==0)
    for i=1:S
        for j=i+1:S
            if(A_interaction(i,j)==1)
                temp(i,j)=normrnd(mu,sigma);
                temp(j,i)=normrnd(mu,sigma);
            end
        end
    end
end

if(pm+pc+pe+pam+pcm==1)
    for i=1:S
        for j=i+1:S
            if(A_interaction(i,j)==0)
                p2=0;
            end
            if(A_interaction(i,j)==1)
                p2=rand();
            end
            if(p2~=0)
                if(p2<=pm)
                    temp(i,j)=abs(normrnd(mu,sigma));
                    temp(j,i)=abs(normrnd(mu,sigma));
                end
                if(p2>pm)&&(p2<=pm+pc)
                    temp(i,j)=-abs(normrnd(mu,sigma));
                    temp(j,i)=-abs(normrnd(mu,sigma));
                end
                if(p2>pm+pc)&&(p2<=pm+pc+pe)
                    p3=rand();
                    if(p3>=0.5)
                        temp(i,j)=abs(normrnd(mu,sigma));
                        temp(j,i)=-abs(normrnd(mu,sigma));
                    end
                    if(p3<0.5)
                        temp(i,j)=-abs(normrnd(mu,sigma));
                        temp(j,i)=abs(normrnd(mu,sigma));
                    end
                end
                if(p2>pm+pc+pe)&&(p2<=pm+pc+pe+pam)
                    p4=rand();
                    if(p4>=0.5)
                        temp(i,j)=-abs(normrnd(mu,sigma));
                        temp(j,i)=0;
                    end
                    if(p4<0.5)
                        temp(i,j)=0;
                        temp(j,i)=-abs(normrnd(mu,sigma));
                    end
                end
                if(p2>pm+pc+pe+pam)
                    p5=rand();
                    if(p5>=0.5)
                        temp(i,j)=abs(normrnd(mu,sigma));
                        temp(j,i)=0;
                    end
                    if(p5<0.5)
                        temp(i,j)=0;
                        temp(j,i)=abs(normrnd(mu,sigma));
                    end
                end
            end
        end
    end
end

A_original=temp;

end

