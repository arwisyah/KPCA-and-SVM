# KPCA-and-SVM
Tujuan: Agoritma klasifikasi dibuat untuk membuat model yang dapat mengenali tulisan huruf hijaiyah berdasarkan hurufnya (15 kelas huruf tunggal tanpa harakat dan tidak memperhatikan jumlah titik).

Penjelasan masing-masing file:

-Folder "Data Bentuk" berisikan file data image tulisan tangan huruf hijaiyah. Terdapat 80 folder (penulis), setiap penulis menuliskan 5 tulisan per huruf hijaiyah.

-Function vektorim() digunakan untuk menghilangkan noise pada gambar menggunakan gauss kernel dan mentransformasi data gambar menjadi vektor.

-Script "Baca Data" digunakan untuk membaca data menggunakan function vektorim(), membagi data training dan testing, kernelisasi data, ekstraksi fitur KPCA menggunakan function matlab pca() lalu menyimpan dataset yang sudah siap dipakai dalam format .mat.

-Function svm_train() digunakan untuk membuat model svm menggunakan function matlab quadprog().

-Function svm_test() digunakan untuk memprediksi hasil klasifikasi dengan strategi One Against One.

-Script "training" digunakan untuk membangun model multiclass svm dengan strategi One Against One menggunakan function svm_train.

-Script "testing" digunakan untuk menguji data test menggunakan model multiclass svm yang diperoleh dari script "training" dan memprediksi kelas menggunakan function svm_test().

Algoritma Penggunaan:
1. Tentukan parameter-parameter yang akan digunakan dalam melatih model serta parameter split dataset.
2. Jalankan script "Baca Data"
3. Jalankan script "training"
4. Jalankan script "testing"

catatan: Setelah dilakukan percobaan pada data leave one (data yang tidak dikenali sama sekali oleh model, bahkan tidak dimasukkan pada saat testing, untuk mensimulasi data pada dunia nyata), parameter terbaik yang digunakan adalah parameter KPCA RBF dengan parameter sigma=10^-5, Kernel SVM polinomial p=5, parameter soft-margin SVM C=10^-1 dengan akurasi sebesar 76%
