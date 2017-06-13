function [ c,U ] = k_means( c,ccount,dataset )
%take input as initial centers,number of clusters,dataset 

%initilaze U with zeros
U=zeros(length(dataset),ccount);
Uold=ones(length(dataset),ccount);
it=1;
%start while stop when max iteration number reached or U=Uold
while it<1000 && ~isempty(find(U~=Uold))
   it=it+1; 
Uold=U;
for i=1:6435,
    for j=1:ccount,
        teta(i,j)=euclid(dataset(i,:),c(j,:));
    end
end
%took min teta values
[V,B]=(min(teta,[],2));


U=zeros(6435,ccount);
%assign data to nearest cluster
for i=1:6435,
    U(i,B(i))=1;
end

%update c values
for i=1:ccount,
    for j=1:36,
        c(i,j)=sum(dataset(:,j).*U(:,i))/(sum(U(:,i))+1);
    end
end
end

end

