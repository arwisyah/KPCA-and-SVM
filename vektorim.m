function [k]=vektorim(e)
% "vektorim" adalah function yang bertugas melakukan preprocessing pada data sebelum siap
% digunakan
l=imread(e);
l=double(l);

%filter gambar menggukan gauss kernel (menghilangkan noise)
gauss_ker=[1 4 7 4 1;4 16 26 16 4; 7 26 41 26 7;4 16 26 16 4;1 4 7 4 1]/273;
im_gauss=conv2(l,gauss_ker,'same');

%normalisasi gambar dari 40*50 pixel menjadi matriks 8*10
h=mat2cell(im_gauss,5*ones(8,1),5*ones(10,1));
for i=1:8
    for j=1:10
    k(i,j)=mean2(h{i,j});
    end
end

%rescale data
k=k-240;

%membuat data menjadi vektor
k=reshape(k,1,[]);
end