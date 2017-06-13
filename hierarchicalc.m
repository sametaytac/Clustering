function [c,U] = hierarchicalc( cinit,ccount )
%Take input as initial clusters and cluster number desired
%Initialization 
c=cinit;
U=eye(length(c));
while 1

[r,col]=size(c);

Cvalues=[];
%Find out which data belong which cluster by using U matrix
for i=1:r,
Cvalues{i}=cinit.*repmat(U(:,i),1,36);
Cvalues{i}(all(Cvalues{i}==0,2),:)=[];
end
%If desired cluster number is reached,break
if(r==ccount)
    break;
end
delta=[];
Call=[];
%Use Ward's minimum varience method
for i=1:r-1,
    for j=i+1:r;
    Call=[Cvalues{i};Cvalues{j}];
    Cmean=c(i,:)+c(j,:)/2;
    delta(i,j) = sum(euclid(Call,repmat(Cmean, size(Call, 1),1)).^2)-sum(euclid(Cvalues{i},repmat(c(i,:), size(Cvalues{i}, 1),1)).^2)-sum(euclid(Cvalues{j},repmat(c(j,:), size(Cvalues{j}, 1),1)).^2);
    

    end
end
%Find nearest two clusters
    delta(find(delta==0))=Inf;
    [num] = min(delta(:));
    
[x y] = ind2sub(size(delta),find(delta==num));
%Merge two cluster and delete them from U and c matrix
    U=[U,U(:,x)+U(:,y)];
    if(x>y)
    U(:,x)=[];
    U(:,y)=[];
    else
    U(:,y)=[];
    U(:,x)=[];
    end
    c=[c;Cmean];
    if(x>y)
    c(x,:)=[];
    c(y,:)=[];
    else
    c(x,:)=[];
    c(y,:)=[];
    end
end

end

