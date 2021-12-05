function [alpha,w,b]=svm_train(kernel,training,kelas,paramK,koef)
[n,d]=size(training); %membaca banyak & dimensi data
%step1: membuat fungsi tujuan svm untuk pemrograman kuadratik
%max z=sigmai=1->n(alpha(i))-sigmai=1->n(sigmaj=1->n(alpha(i)*alpha(j)*kelas(i)*kelas(j)*vektor(i)'*vektor(j)))

%menghitung matriks Hessian dari dot product dikalikan kelas
%untuk svm linear dot product dikalikan kelas= koefisien dari sigmai=1->n(sigmaj=1->n(alpha(i)*alpha(j)*kelas(i)*kelas(j)*vektor(i)'*vektor(j))
%untuk non-linear svm dot product dihitung menggunakan fungsi kernel
H=zeros(n,n);%matriks Hessian
for i=1:n
    for j=1:n
        if kernel==1 %kernel polynomial 
            H(i,j)=(((training(i,:)*training(j,:)')+1)^paramK)*kelas(i)*kelas(j);
        elseif kernel==2 %kernel rbf
            H(i,j)=(exp(-1*(2*(10^paramK))*(sum((training(i,:)-training(j,:)).^2))))*kelas(i)*kelas(j);
        end
    end
end

f=(-1)*ones(n,1); %koefisien sigmai=1->n(alpha(i)), minus karena problem maksimasi
lb=zeros(n,1); %ruas kanan kendala alpha(i)>=0 (lower bound), for all i=1->n
ub=(10^(koef))*ones(n,1); %ruas kanan kendala alpha(i)<C; koefisien var slack (upper bound), for all i=1->n

%step 2: pemrograman kuadratik menggunakan algoritma interior point
%untuk mencari alpha
%data yang memiliki alpha>0 akan menjadi support vector

%kelas data=y(i), mewakili koefisien ruas kiri dari kendala sigmai-->n(alpha(i)*y(i))=0

opts = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
[alpha] = quadprog(H+(eye(n,n)*10^(-15)),f,[],[],kelas',0,lb,ub,[],opts);

%step 3: cari w dan b
%mencari w (vektor normal terhadap hyperplane)
%w=sigmai->n(alpha(i)*kelas(i)*vektor(i))
%w hanya digunakan untuk linear kernel
w=zeros(d,1);
for k=1:d
    for i=1:n
    temp=alpha(i)*kelas(i)*training(i,k);
    w(k)=w(k)+temp;
    end
end

%menghitung b
%mencari jarak alpha min max
plus=1;
min=1;
plusAsmall=10^10;
minAsmall=10^10;
plusAlarge=0;
minAlarge=0;
for i=1:n
    if kelas(i)==1 %untuk support vector kelas 1
        alphaplus(plus)=alpha(i);
        plus=plus+1;
        if plusAsmall>alpha(i) %mencari alpha terkecil
           plusAsmall=alpha(i);
        end
        if plusAlarge<alpha(i) %mencari alpha terbesar
           plusAlarge=alpha(i);
        end
    else %untuk support vector kelas -1
        alphamin(min)=alpha(i);
        min=min+1;
        if minAsmall>alpha(i)  %mencari alpha terkecil
           minAsmall=alpha(i);
        end
        if minAlarge<alpha(i) %mencari alpha terbesar
           minAlarge=alpha(i);
        end
    end
end
jarakAplus=plusAlarge-plusAsmall;
jarakAmin=minAlarge-minAsmall;

%pemilihan support vector terbaik (paling dekat dengan hyperplane)
p=1;
m=1;
for i=1:n
     if alpha(i)>(plusAsmall+(0.99999999*jarakAplus))&&kelas(i)==1 %alpha mendekati 0 diabaikan
        svplus(p,:)=training(i,:);
        p=p+1;
     end
     if alpha(i)>(minAsmall+(0.99999999*jarakAmin))&&kelas(i)==-1 %alpha mendekati 0 diabaikan
        svmin(m,:)=training(i,:);
        m=m+1;
     end
end

%menghitung b optimal untuk setiap support vector
bp=0;
bm=0;
for i=1:n
    svpw=0;
    svmw=0;
    for j=1:p-1
        if kernel==1 %kernel polynomial
            svpw=svpw+((((svplus(j,:)*training(i,:)')+1)^paramK)*alpha(i)*kelas(i));
            bp=bp+(1-svpw);
        elseif kernel==2 %kernel rbf
            svpw=svpw+((exp(-1*(2*(10^paramK))*(sum((svplus(j,:)-training(i,:)).^2))))*alpha(i)*kelas(i));
            bp=bp+(1-svpw);
        end
    end
    for j=1:m-1
        if kernel==1 %kernel polynomial
            svmw=svmw+((((svmin(j,:)*training(i,:)')+1)^paramK)*alpha(i)*kelas(i));
            bm=bm+(-1-svmw);
        elseif kernel==2 %kernel rbf
            svmw=svmw+((exp(-1*(2*(10^paramK))*(sum((svmin(j,:)-training(i,:)).^2))))*alpha(i)*kelas(i));
            bm=bm+(-1-svmw);
        end
    end
end
%rata-rata b optimal, untuk mendapatkan b optimal global
b=(bp+bm)/((p-1)+(m-1));
end