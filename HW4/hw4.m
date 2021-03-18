
%% 
[train_images, train_labels] = mnist_parse('train-images.idx3-ubyte', 'train-labels.idx1-ubyte');
[test_images, test_labels] = mnist_parse('t10k-images.idx3-ubyte', 't10k-labels.idx1-ubyte');
train_images = reshape(train_images,[784 60000]);
test_images = reshape(test_images,[784 10000]);

train_wave = dcwavelet(train_images);
test_wave = dcwavelet(test_images);

%% 
[U,S,V] = svd(train_wave,'econ');

%%
for k = 1:9
    subplot(3,3,k)
    ut1 = reshape(U(:,k),14,14);
    ut2 = rescale(ut1);
    imshow(ut2)
end
%%
plot(diag(S),'ko','Linewidth',2)
set(gca,'Fontsize',16,'Xlim',[0 80])

%%
PCA=S*V';
%%
ones = []; twos=[]; threes=[];
feature=60;
for j=1:60000
    if train_labels(j) == 1
       ones(:,end+1) = PCA(1:feature,j);
    elseif train_labels(j) == 2
       twos(:,end+1) = PCA(1:feature,j);
    elseif train_labels(j) == 3
        threes(:,end+1) = PCA(1:feature,j);
    end
end
sz = 5958;
%% 1 2
ones = ones(1:feature,1:sz);
twos = twos(1:feature,1:sz);
mo = mean(ones,2);
mt = mean(twos,2);
sw=0;
for k = 1:sz
    sw = sw + (ones(:,k) - mo)*(ones(:,k) - mo)';
end

for k=2:sz
    sw = sw + (twos(:,k) - mt)*(twos(:,k) - mt)';
end
Sb = (mo-mt)*(mo-mt)'; 
[V2, D] = eig(Sb,sw);
[lambda, ind] = max(abs(diag(D)));
w = V2(:,ind);
w = w/norm(w,2);

vone = w'*ones;
vtwo = w'*twos;

if mean(vone)>mean(vtwo)
   w = -w;
   vone = -vone;
   vtwo = -vtwo;
end

%%
plot(vone,zeros(5958),'ob','Linewidth',2)
hold on
plot(vtwo,ones(5958),'dr','Linewidth',2)
%%
sortone = sort(vone);
sorttwo = sort(vtwo);
t1 = length(sortone);
t2 = 1;
while sortone(t1)>sorttwo(t2)
      t1 = t1 - 1;
       t2 = t2 + 1;
end
threshold = (sortone(t1) + sorttwo(t2))/2;

%%
subplot(1,2,1)
histogram(sortone,30); hold on, plot([threshold threshold], [0 10],'r')
set(gca,'Xlim',[-3 4],'Ylim',[0 10],'Fontsize',14)
title('one')
subplot(1,2,2)
histogram(sorttwo,30); hold on, plot([threshold threshold], [0 10],'r')
set(gca,'Xlim',[-3 4],'Ylim',[0 10],'Fontsize',14)
title('two')
%%
U = U(:,1:feature);
test_proj = U'*test_wave; 

test = [];
label = [];
for i = 1:1000
if test_labels(i) == 1 || test_labels(i) == 2
test(:,end+1) = test_proj(:,i);
label(:,end+1) = test_labels(i);
end
end
val = w'*test;
ResVec = (val>threshold);
err = abs(ResVec - label);
errNum = sum(err);
sucRate = 1 - errNum/60000

%% 
one_two = [ones twos]
one_two_label=[ones([1 5958]) twos([1 5959])]
tree=fitctree(one_two', one_two_label,'CrossVal','on');
%%
SVM = fitcsvm(one_two',one_two_label);
CV = crossval(SVM);
SVMLoss = kfoldLoss(CV)