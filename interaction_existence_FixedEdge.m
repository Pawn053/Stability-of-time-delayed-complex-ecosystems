function A_interaction = interaction_existence_FixedEdge(S,C,d)
% This function generates the matrix that determines whether two species
% interact with each other or not

temp=zeros(S,S);

edge_sum=round(0.5*S*(S-1)*C);

for i=1:S
    for j=i+1:S
        if(i~=j)
            p1=rand();
            if(p1<C)
                temp(i,j)=1;
                temp(j,i)=1;
            end
        end
    end
end

edge_sum_flag=0.5*sum(sum(temp));
while(edge_sum_flag~=edge_sum)
    if(edge_sum_flag>edge_sum)
        degree_flag=sum(temp);
        max_degree_num=find(degree_flag==max(degree_flag));
        remove_num1=1+(max(size(max_degree_num))-1)*rand();
        remove_num1=round(remove_num1);
        max_degree_num=max_degree_num(remove_num1);
        remove_num2=1+(max(degree_flag)-1)*rand();
        remove_num2=round(remove_num2);
        count_remove=0;
        for i=1:S
            if(temp(max_degree_num,i)==1)
                count_remove=count_remove+1;
            end
            if(count_remove==remove_num2)
                remove_node=i;
                break;
            end
        end
        temp(max_degree_num,remove_node)=0;
        temp(remove_node,max_degree_num)=0;
    end
    
    if(edge_sum_flag<edge_sum)
        degree_flag=sum(temp);
        min_degree_num=find(degree_flag==min(degree_flag));
        connect_num1=1+(max(size(min_degree_num))-1)*rand();
        connect_num1=round(connect_num1);
        min_degree_num=min_degree_num(connect_num1);
        connect_num2=1+((S-1)-min(degree_flag)-1)*rand();
        connect_num2=round(connect_num2);
        count_connect=0;
        for i=1:S
            if(temp(min_degree_num,i)==0)&&(i~=min_degree_num)
                    count_connect=count_connect+1;
            end
            if(count_connect==connect_num2)
                connect_node=i;
                break;
            end
        end
        temp(min_degree_num,connect_node)=1;
        temp(connect_node,min_degree_num)=1;
    end
    edge_sum_flag=0.5*sum(sum(temp));
end

for i=1:S
    temp(i,i)=-d;
end

A_interaction=temp;

end

