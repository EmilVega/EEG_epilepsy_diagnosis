% Load data
clc, close all, clear

M=csvread('data.csv',1,1);
y = M(:,end);
for s = 1:500
    for i = 1:23
        EEGDB.(['subject' num2str(s)]).(['chunk' num2str(i)]).data = M((s-1)*23+i,1:178);
        EEGDB.(['subject' num2str(s)]).(['chunk' num2str(i) ]).label = M((s-1)*23+i,179);
    end
end

% Original Matrix Normalization

M2=zeros(11500,179);

for i = 1:11500
    Max_r=max(abs(M(i,:)));
    M2(i,:)=M(i,:)/Max_r; 
end

clear i Max_r s

%% Simple features

clc
[lM2,n] = size(M2);
M3=zeros(lM2,36);  % Characterication on original data

for i=1:lM2
    M3(i,1:32)=features(M2(i,1:178));
    M3(i,33:36)=features_fs(M2(i,1:178),178);
end

%% DWT
clc

M4=zeros(lM2,192);     % Charactirzation on dwt data
for i=1:lM2
    M4(i,:)=features_dwt(M2(i,1:178));
end

clear i lM2 n

%% Delete Inf values columns
clc
X = [M3,M4];        % Feature matrix
[i,j]=size(X);
posc=[];
for f=1:i
    for c=1:j
            if(isinf(X(f,c))==1)
                posc=[posc(:,:),c];
            end 
    end
end

X(:,posc) = [];     % Final feature matrix without INF values

clear c f i j posc

% Normalization of features
clc

X_no_norm = X;
X= X./repmat(max(abs(X)),size(X,1),1);

%% Ranking of the best features - Got form Weka

% 132 151 196 88 169 139 165 163 157 150 134 181 216
% 152 198 211 201 221 215 212 217 167 46 185 18 108
% 67 28 69 220 17 58 114 59 146 218 115 107 83 84 178

T=table(X,char(y+97));
writetable(T,'FeatNorm_all.csv');
clear T

features=[132 151 196 88 169 139 165 163 157];

%% Experiment 1 - 1 vs All
% The classes 2,3,4 and 5 were assigned to a single class

clc

T=table(X,y==1);
writetable(T,'FeatNorm_2.csv');
clear T

test_2classes('FeatNorm_2.csv',features);

%% Experiment 2 - 1,2 
% The classes 3, 4 and 5 were removed

clc
pos = [];
for i=1:length(y)
    if(y(i)>2)
        pos=[pos,i];
    end
end

X2=X;
X2(pos,:)=[];
y2=y;
y2(pos)=[];

T=table(X2,y2==1);
writetable(T,'FeatNorm_2class_12.csv');

clear T pos i

test_2classes('FeatNorm_2class_12.csv',features);

%% Experiment 3 - 1,2 vs all
% The classes 3,4 and 5 were joined in a singles class

clc
y3=y;
for i=1:length(y)
    if(y(i)>2)
        y3(i)=3;
    end
end

T=table(X,y3);
writetable(T,'FeatNorm_3class_12.csv');
clear T pos i

test_3classes('FeatNorm_3class_12.csv',features);

%% Experiment 4 - 1,2,3
% The classes 4 and 5 were deleted

clc
pos = [];
for i=1:length(y)
    if(y(i)>3)
        pos=[pos,i];
    end
end

X4=X;
X4(pos,:)=[];
y4=y;
y4(pos)=[];

T=table(X4,y4);
writetable(T,'FeatNorm_3class_123.csv');
clear T pos i

test_3classes('FeatNorm_3class_123.csv',features);

%% Experiment 5 - 1 and 2 as class1, 3 as class2, 4 and 5 as class3

clc
y5 = y;
for i=1:length(y5)
    if(y5(i)<3)
        y5(i)=1;
    elseif (y5(i)==3)
        y5(i)=2;
    else
        y5(i)=3;
    end
end

 
T=table(X,y5);
writetable(T,'FeatNorm_3class_mix.csv');
clear T pos i

test_3classes('FeatNorm_3class_mix.csv',features);
