# DOKUMENTASI KPCA-and-SVM

Repositori ini berisi implementasi kode untuk penelitian berjudul **"Pengenalan tulisan tangan huruf hijaiyah menggunakan ekstraksi fitur KPCA dan algoritma klasifikasi SVM"**. Model ini dirancang untuk mendeteksi **15 kelas huruf tunggal** tanpa harakat dan tidak memperhatikan jumlah titik.

---

## 🎯 Tujuan Proyek
Membangun model klasifikasi citra yang mampu mengenali dan mengelompokkan karakter tulisan tangan huruf hijaiyah secara tepat menggunakan kombinasi **Kernel Principal Component Analysis (KPCA)** untuk ekstraksi fitur dan **Support Vector Machine (SVM)** untuk klasifikasi.

## 📂 Struktur & Penjelasan File

| Nama File / Folder | Deskripsi |
| :--- | :--- |
| 📁 **Data Bentuk** | Berisi file citra (*image*) tulisan tangan huruf hijaiyah. Terdiri dari 80 folder penulis, di mana setiap penulis menuliskan 5 sampel per huruf. |
| 📄 **vektorim.m** *(Function)* | Berfungsi untuk menghilangkan *noise* pada gambar menggunakan **Gaussian Kernel** dan mentransformasi data gambar menjadi bentuk vektor. |
| 📄 **Baca Data.m** *(Script)* | Membaca data menggunakan fungsi `vektorim()`, membagi data menjadi *training* dan *testing*, melakukan kernelisasi data, mengekstraksi fitur KPCA dengan fungsi bawaan MATLAB `pca()`, lalu menyimpan dataset siap pakai dalam format `.mat`. |
| 📄 **svm_train.m** *(Function)* | Berfungsi untuk membuat model SVM menggunakan fungsi optimasi MATLAB `quadprog()`. |
| 📄 **svm_test.m** *(Function)* | Berfungsi untuk memprediksi hasil klasifikasi dengan strategi *One Against One* (OAO). |
| 📄 **training.m** *(Script)* | Digunakan untuk membangun model *multiclass* SVM dengan strategi *One Against One* menggunakan fungsi `svm_train()`. |
| 📄 **testing.m** *(Script)* | Digunakan untuk menguji data *testing* menggunakan model yang diperoleh dari proses *training* dan memprediksi kelas menggunakan fungsi `svm_test()`. |

---

## 🚀 Alur Penggunaan

Ikuti langkah-langkah berikut secara berurutan untuk menjalankan program:

1. **Konfigurasi Parameter:** Tentukan parameter-parameter yang akan digunakan dalam melatih model serta parameter pembagian (*split*) dataset.
2. **Pra-pemrosesan Data:** Jalankan script `Baca Data.m`.
3. **Pelatihan Model:** Jalankan script `training.m`.
4. **Pengujian Model:** Jalankan script `testing.m`.

---

## 📊 Hasil Percobaan & Parameter Terbaik

Berdasarkan pengujian menggunakan metode *leave-one-out* (mensimulasikan data dunia nyata dengan data yang sama sekali tidak dikenali oleh model dan tidak dimasukkan saat pengujian), model ini menghasilkan **akurasi sebesar 76%** menggunakan kombinasi parameter terbaik berikut:

* **Ekstraksi Fitur (KPCA):** RBF Kernel dengan parameter \(\sigma = 10^{-5}\)
* **Klasifikasi (SVM):** Polinomial Kernel dengan derajat \(p = 5\)
* **Soft-Margin (SVM):** Parameter penalti \(C = 10^{-1}\)

---

## 📚 Sitasi Skripsi

Jika Anda menggunakan kode atau merujuk penelitian dalam repositori ini, silakan gunakan format sitasi berikut:

### Format APA 7th Edition:
> Syahdwinata, A. W. (2018). *Pengenalan tulisan tangan huruf hijaiyah menggunakan ekstraksi fitur KPCA dan algoritma klasifikasi SVM* (Thesis Diploma). UIN Sunan Gunung Djati Bandung. [https://digilib.uinsgd.ac.id/18853/](https://digilib.uinsgd.ac.id/18853/)

---