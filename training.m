clc
clear all

%percobaan SVM menggunakan data huruf hijaiyah
load('data_train')
%inisialisasi kelas target
kelas=vertcat(ones(320,1),(-1*ones(320,1)));
n=size(dat_tr);
kernel=1;
paramK=5;
koef=-1;
%mencari klasifier untuk setiap pasangan kelas
for i=1:n
    [alp,weight,bias]=svm_train(kernel,[dat_tr{i}],kelas,paramK,koef);
    w(:,i)=weight;
    b(i)=bias;
    al(:,i)=alp;
end
%simpan hyperplane hasil svm
save('hyperplane','w','b','al','kelas','kernel','paramK')