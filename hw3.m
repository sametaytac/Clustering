fileID = fopen('sat.data','r');
%take input
sizeA = [37 6435];
formatSpec = '%f';
Big=fscanf(fileID,formatSpec,sizeA);
Big=Big';
fclose(fileID);
initclass=Big(:,37);
dataset=Big(:,[1:36]);
%assign random c values
% for i=1:6,
% cinitial(i,:)=randi(150,1,36);
% end
cinitial=[12 60 1 34 1 29 22 41 27 21 90 136 141 34 73 57 79 40 11 66 27 4 144 65 145 115 2 103 106 97 83 33 116 35 56 134;129 61 48 92 137 137 89 50 128 67 136 5 80 108 27 51 29 49 61 83 8 83 42 37 37 24 144 141 123 110 27 55 29 1 48 105;94 82 66 44 76 115 115 87 113 97 19 76 53 14 23 30 101 65 105 39 2 80 42 142 136 59 4 101 126 146 9 68 88 103 108 98;110 57 88 18 9 147 43 90 145 28 29 52 140 59 41 23 60 57 20 66 14 93 2 86 119 36 68 86 10 75 97 34 126 146 127 76;42 112 36 144 94 91 26 14 39 129 137 105 109 35 87 122 61 149 14 49 77 10 109 84 80 125 129 119 48 68 113 17 17 41 79 146;107 47 44 128 137 96 39 14 126 88 143 10 88 43 125 29 67 60 124 102 32 48 21 101 86 26 23 72 137 83 5 9 121 68 58 119];
%call k_means,cluster number is 6
[ck_means,Uk_means]=k_means(cinitial,6,dataset);

%call hierarchicalc,for 200 data and 6 cluster
cinit=dataset((1:200),:);
[c_hier,U_hier]=hierarchicalc(cinit,6);

%Merge cluster of data with natural classes
for i=1:6,
Cvalues_h{i}=[cinit,initclass(1:200)].*repmat(U_hier(:,i),1,37);
Cvalues_h{i}(all(Cvalues_h{i}==0,2),:)=[];
end


%calculate purity of each cluster
for i=1:6,
    Countclass=[0,0,0,0,0,0,0];
        if length(Cvalues_h{i})==37
        Purity(i)=1;
    else
    for j=1:length(Cvalues_h{i}),
        Countclass(Cvalues_h{i}(j,37))=Countclass(Cvalues_h{i}(j,37))+1;
    end

    Purity(i)=max(Countclass)/length(Cvalues_h{i});
    end
end
%calculate entropy
    entropy=-sum(Purity.*log(Purity));
    
    
    
%dendrogram for all dataset    
tree1 = linkage(dataset,'complete');

figure()
dendrogram(tree1,0)
%dendrogram for datas using in hierachical clustering
tree2 = linkage(dataset((1:200),:),'complete');
figure()
dendrogram(tree2,0)