clear all

%testing hasil hyperplane dari svm untuk huruf hijaiyah

%input data
load('data_test')
[n,d]=size(test);
%testing menggunakan multiclass svm(strategi one vs one)
%sgn(w'*x)+b=c, c>=1 == kelas 1,c<=-1 == kelas -1, diuji pada seluruh kombinasi klasifier
%penentuan kelas ditentukan dengan metode voting
kernel=1;
paramK=5;
for i=1:n
    [kelas]=svm_test(kernel,test(i,:),paramK);
    class(i)=kelas;
end
%hitung error
salah=0;
bagi_kelas=mat2cell(class',(n/15)*ones(15,1));
for i=1:15
    kel=[bagi_kelas{i}];
    salah2=0;
    for j=1:n/15
        if kel(j)~=i
            salah=salah+1;
            salah2=salah2+1;
        end
    end
    acchur(i)=100-((salah2/(n/15))*100);
end
error=(salah/n)*100;
akurasi=100-error;