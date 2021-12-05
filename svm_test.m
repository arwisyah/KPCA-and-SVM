function [cl]=svm_test(kernel,test,paramK)
load('hyperplane')
load('data_train')
%baca banyaknya klasifier
[~,m]=size(b);
[n,~]=size(kelas);

%melabelkan data (1,-1,0)
y=zeros(m,1);
for i=1:m
    training=[dat_tr{i}]';
    for j=1:n
        alp=al(j,i);
        if kernel==1
            y(i)=y(i)+((alp*kelas(j))*(((test*training(:,j))+1)^paramK));
        elseif kernel==2
            y(i)=y(i)+((alp*kelas(j))*(exp(-1*(2*(10^paramK))*(sum((test-training(:,j)').^2)))));
        end
    end
    bias=b(i);
    y(i)=y(i)+bias;
    %fungsi tujuan
    if y(i)>=1
        y(i)=1;
    elseif y(i)<=-1
        y(i)=-1;
    else
        y(i)=0;
    end
end

%melabelkan data (0,1,2,3,...,n+1) n=kelas data, dengan perulangan kombinasi
k=2;
h=1;
for i=1:15
    for j=k:15
        if y(h)==1
            class(h)=i;
        elseif y(h)==-1
            class(h)=j;
        else
            class(h)=0;
        end
    h=h+1;
    end
k=k+1;
end
%voting
%mencari frekuensi kelas

frek=zeros(15,1);
for i=1:m
    for j=1:15
        if class(i)==j
            frek(j)=frek(j)+1;
        end
    end
end
%mencari modus kelas (voting)
modus=0;
for i=1:15
    if modus<max(frek(i))
        cl=i;
        modus=max(frek(i));
    end
end
if modus==0
    cl=0;
end
end