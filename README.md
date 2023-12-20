# readme_mobile

## Link Downloads
[https://install.appcenter.ms/orgs/pbp/apps/readme/distribution_groups/public](https://install.appcenter.ms/orgs/pbp/apps/readme/distribution_groups/public)

## Kelompok F04

1. Fikri Budianto - 2206025306
2. Serafino Theodore Axel Rori - 2206082644
3. Ayundha Sachi Mulia - 2206083275
4. Shanahan Danualif Erwin - 2206817420
5. Muhammad Haekal Kalipaksi - 2206817490

## Deskripsi Aplikasi `README`

Aplikasi `README` adalah aplikasi yang berharap untuk meningkatkan pemahaman tentang bahasa, sastra, dan literasi di
Indonesia. Aplikasi `README` selaras dengan tema Kongres Bahasa Indonesia XII, yaitu "Literasi dalam Kebhinekaan untuk
Kemajuan Bangsa." Aplikasi `README` memberikan platform bagi pengguna untuk meminjam buku, membaca buku, memberikan
ulasan, dan berdiskusi buku dengan pengguna lain. Selain itu, pengguna juga dapat melihat profil pengguna lain, sehingga
dapat melihat buku yang sudah dibaca, ulasan yang ditulis, dan diskusi yang dilakukan oleh pengguna. Berikut adalah
manfaat dari aplikasi `README`:

- Meningkatkan literasi, dengan memberikan akses terhadap buku yang disediakan oleh Project Gutenbergs.
- Menciptakan interaksi antar pengguna, dengan memberikan fitur ulasan dan diskusi. Diharapkan pengguna dapat
  mendapatkan rekomendasi buku dengan membaca ulasan dan diskusi.

## Daftar Modul

### 1. Profil

*Modul `Profil` akan dikerjakan oleh: **Serafino Theodore Axel Rori***

Modul Profil adalah bagian dari aplikasi yang memungkinkan pengguna untuk membuat dan mengelola profil pribadi mereka.
Di sini, pengguna dapat menambahkan informasi pribadi seperti nama, foto profil, deskripsi singkat, buku yang sedang
dibaca, dan genre favorite. Modul ini juga memungkinkan pengguna untuk melihat riwayat aktivitas mereka di aplikasi,
seperti buku yang telah mereka baca dan pinjam dan ulasan yang mereka berikan. Selain itu dapat di edit juga profilnya.

### 2. Pinjam Buku

*Modul `Pinjam Buku` akan dikerjakan oleh: **Fikri Budianto***

Modul Pinjam Buku adalah fitur yang memungkinkan pengguna untuk mencari dan meminjam buku dari perpustakaan digital atau
fisik. Pengguna dapat mencari buku berdasarkan judul, penulis, atau kategori, lalu meminjam buku tersebut untuk dibaca.
Modul ini juga dapat menampilkan buku yang sedang dipinjam serta waktu buku selesai dibaca.

### 3. Review Buku

*Modul `Review Buku` akan dikerjakan oleh: **Ayundha Sachi Mulia***

Modul Review Buku adalah fitur untuk memberikan bintang atau nilai dan ulasan terhadap buku yang telah dibaca. Pengguna
dapat berbagi pendapat mereka mengenai buku yang dibaca dan memberikan rekomendasi ke pengguna lainnya berdasarkan minat
mereka. Fitur ini juga memungkinkan pengguna untuk melihat ulasan buku dari pengguna lain.

### 4. Katalog Buku

*Modul `Katalog Buku` akan dikerjakan oleh: **Muhammad Haekal Kalipaksi***

Modul Katalog Buku adalah fitur yang menampilkan daftar lengkap buku yang tersedia. Pengguna dapat menjelajahi katalog
tersebut untuk mencari buku sesuai kategori, melihat informasi tentang buku, dan juga membaca sinopsis singkat mengenai
buku yang dilihat. Pengguna, dapat mengurutkan buku berdasarkan jumlah pembaca atau jumlah disukai, serta pengguna dapat
menerapkan filter buku berdasarkan kategori.Pengguna dapat membuka detail buku, yang berisi informasi detail buku,
tombol untuk membaca dan meminjam buku, tombol untuk menyukai buku, ulasan buku, pengguna yang sedang membaca buku, dan
banyak diskusi buku.

### 5. Forum Diskusi Buku

*Modul `Forum Diskusi Buku` akan dikerjakan oleh: **Shanahan Danualif Erwin***

Modul Forum Diskusi Buku adalah wadah komunitas dimana pengguna dapat berpartisipasi dalam percakapan tentang buku.
Pengguna dapat membuat topik diskusi tentang buku tertentu, berbagi pendapat mereka, bertanya pertanyaan, dan
berinteraksi dengan pengguna lain yang memiliki minat serupa. Modul ini mempromosikan dialog dan pertukaran ide antara
pengguna yang gemar membaca. 

### 6. Autentikasi

*Modul `Autentikasi` akan dikerjakan secara bersama oleh **Muhammad Haekal Kalipaksi***

Sistem autentikasi utama aplikasi `README` untuk register, login, dan logout.


## Role atau peran pengguna

### Guest

Role Guest adalah pengguna yang belum melakukan login saat masuk aplikasi. Guest hanya dapat mengakses module:

1. Katalog Buku, tapi tidak bisa melihat detail buku, hanya judulnya saja.
2. Authentikasi (Register)

### User

Role User adalah pengguna utama di aplikasi ini, user dapat mengakses module:

1. Profil
2. Pinjam Buku
3. Review Buku
4. Katalog Buku
5. Forum Diskusi Buku
6. Autentikasi


### Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester

web service url = [https://readme-app.fly.dev/](https://readme-app.fly.dev/)

1. Profil : terintegrasi dengan module `UserProfile`
2. Pinjam Buku : terintegrasi dengan module `pinjambuku`
3. Review Buku : terintegrasi dengan module `ReviewBuku`
4. Katalog Buku : terintegrasi dengan module `KatalogBuku`
5. Forum diskusi buku : terintegrasi dengan module `ForumDiskusi`
6. Autentikasi : terintegrasi dengan module `authentication`

**Alur Pengintegrasian**

- Melakukan `http request` ke endpoint, dengan method:
  - `GET`
  - `POST`
    Request Body : `Form / JSON`
  
- Request diproses di web service django sesuai dengan algoritma dan model yang sudah dibuat
  
- web service django memberikan response, seluruh response dalam bentuk `JSON`


### Berita Acara
[https://docs.google.com/spreadsheets/d/17FP0NJsBjl3GNLE40fH_KiROTmdIbfxEupEhamdSloI/edit?usp=sharing](https://docs.google.com/spreadsheets/d/17FP0NJsBjl3GNLE40fH_KiROTmdIbfxEupEhamdSloI/edit?usp=sharing)












