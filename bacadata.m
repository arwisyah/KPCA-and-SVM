clc
clear all

%input data train
h=0;
g=0;
for i='A':'C'
    for j=1:10
        h1=5;
        h2=4;
        h3=3;
        h4=2;
        h5=1;
        for k=1:4
            %nilai m dapat diubah tergantung kebutuhan validasi silang
            m=k;
            if k>=2
                m=k+1;
            end
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\1\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            train1((6*k-h1),:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\2\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            train1((6*k-h2),:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\3\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            train1(6*k-h3,:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\4\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            train1((6*k-h4),:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\5\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            train1((6*k-h5),:)=l;
            h1=h1+1;
            h2=h2+1;
            h3=h3+1;
            h4=h4+1;
            h5=h5+1;
        end
        for p=1:20
            train2((p+h),:)=train1(p,:);
        end
        h=h+20;
    end
    for p=1:200
        train((p+g),:)=train2(p,:);
    end
    g=g+200;
    h=0;
end

%feature extraction menggunakan pca untuk data training
%membuat rentang data ditengah (normalisasi data terhadap titik pusat 0,0)
Xtrain=bsxfun(@minus,train,mean(train));
%mencari PC (principal component) dari training set
[PCtrain,score,latent]=pca(train);
%reduksi 10 dimensi data dari 80 (hanya memakai 70 PC)
PCtrain=PCtrain(:,1:70);
%transformasi training set kedalam PC space
train=Xtrain*PCtrain;

%untuk one vs one
%bagi data per huruf
q=mat2cell(train,20*ones(30,1));
%memasukkan data berpasangan menggunakan perulangan kombinasi
k=2;
h=1;
for i=1:30
    v=q(i);
    for j=k:30
        y=q(j);
        dat_tr1{h,1}=vertcat(v,y);
        h=h+1;
    end
    k=k+1;
end
h=h-1;
o=cell2mat(reshape([dat_tr1{:}],[],1));
dat_tr=mat2cell(o,40*ones(h,1));

save('data_train','dat_tr','train','PCtrain')

%input data test
h=0;
g=0;
for i='A':'C'
    for j=1:10
        h1=5;
        h2=4;
        h3=3;
        h4=2;
        h5=1;
        %pengulangan k dapat ditambah sesuai dengan penambahan jumlah data
        %testing
        for k=1:1
            %nilai m dapat diubah tergantung kebutuhan validasi silang
            m=2;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\1\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            test1((6*k-h1),:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\2\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            test1((6*k-h2),:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\3\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            test1(6*k-h3,:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\4\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            test1((6*k-h4),:)=l;
            a='Gbr ';
            b=int2str(j-1);
            c=int2str(m);
            d='.png';
            url='D:\Kuliah\Tugas Akhir\Code\data gambar\Hijaiyah\5\';
            e=horzcat(url,a,i,b,'-',c,d);
            l=vektorim(e);
            test1((6*k-h5),:)=l;
            h1=h1+1;
            h2=h2+1;
            h3=h3+1;
            h4=h4+1;
            h5=h5+1;
        end
        for p=1:5
            test2((p+h),:)=test1(p,:);
        end
        h=h+5;
    end
    for p=1:50
        test((p+g),:)=test2(p,:);
    end
    g=g+50;
    h=0;
end
%feature extraction menggunakan pca untuk data testing
%membuat rentang data ditengah (normalisasi data terhadap titik pusat 0,0)
Xtest=bsxfun(@minus,test,mean(test));
%transformasi testing set kedalam PC space (PC yang sudah didapat dari training set)
test=Xtest*PCtrain;

save('data_test','test')