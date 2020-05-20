#!/bin/bash
echo ".-----------------------------------------------------."
echo "| KTÜ Bilgisayar Mühendisliği - Paralel Bilgisayarlar |"
echo "|        Ahmetcan İRDEM - 357405 - II. Öğretim        |"
echo ".-----------------------------------------------------."
echo
echo "Test Matrisleri Oluşturuluyor, eğer test matrisleri mevcutsa yeniden oluşturulmayacaktır."
echo

#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/seq src/matrix.c src/sequential.c
#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/omp src/matrix.c src/omp.c
#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_seq src/f_matrix.c src/f_sequential.c
#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_omp src/f_matrix.c src/f_omp.c

if [ ! -f data/mat_1000x1000.txt ]; then
    echo "1000x1000 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 1000 1000 > data/mat_1000x1000.txt
fi

if [ ! -f data/mat_1000x1000b.txt ]; then
    python generator/random_float_matrix.py 1000 1000 > data/mat_1000x1000b.txt
fi

if [ ! -f data/mat_2000x2000.txt ]; then
    echo "2000x2000 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 2000 2000 > data/mat_2000x2000.txt
fi
if [ ! -f data/mat_2000x2000b.txt ]; then
    python generator/random_float_matrix.py 2000 2000 > data/mat_2000x2000b.txt
fi

if [ ! -f data/mat_3000x3000.txt ]; then
    echo "3000x3000 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 3000 3000 > data/mat_3000x3000.txt
fi
if [ ! -f data/mat_3000x3000b.txt ]; then
    python generator/random_float_matrix.py 3000 3000 > data/mat_3000x3000b.txt
fi

if [ ! -f data/mat_4000x4000.txt ]; then
    echo "4000x4000 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 4000 4000 > data/mat_4000x4000.txt
fi
if [ ! -f data/mat_4000x4000b.txt ]; then
    python generator/random_float_matrix.py 4000 4000 > data/mat_4000x4000b.txt
fi

if [ ! -f data/mat_5000x5000.txt ]; then
    echo "5000x5000 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 5000 5000 > data/mat_5000x5000.txt
fi
if [ ! -f data/mat_5000x5000b.txt ]; then
    python generator/random_float_matrix.py 5000 5000 > data/mat_5000x5000b.txt
fi

echo ".----------------."
echo "| Derleme İşlemi |"
echo ".----------------."
make


echo
echo ".------------------."
echo "| Hesaplama İşlemi |"
echo ".------------------."
echo ".------------------------- 1000x1000 Double Matris çarpımı -------------------------."
echo "| Seri Çarpım Komut   = time bin/seq data/mat_1000x1000.txt data/mat_1000x1000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/omp data/mat_1000x1000.txt data/mat_1000x1000b.txt |"
echo ".-----------------------------------------------------------------------------------."
cal_t=$((time bin/seq data/mat_1000x1000.txt data/mat_1000x1000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :    $cal_t"
cal_t=$((time bin/omp data/mat_1000x1000.txt data/mat_1000x1000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :    $cal_t"
echo

echo ".-------------------------- 1000x1000 Float  Matris çarpımı --------------------------."
echo "| Seri Çarpım Komut   = time bin/f_seq data/mat_1000x1000.txt data/mat_1000x1000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/f_omp data/mat_1000x1000.txt data/mat_1000x1000b.txt |"
echo ".-------------------------------------------------------------------------------------."
cal_t=$((time bin/f_seq data/mat_1000x1000.txt data/mat_1000x1000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :    $cal_t"
cal_t=$((time bin/f_omp data/mat_1000x1000.txt data/mat_1000x1000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :    $cal_t"
echo

echo ".------------------------- 2000x2000 Double Matris çarpımı -------------------------."
echo "| Seri Çarpım Komut   = time bin/seq data/mat_2000x2000.txt data/mat_2000x2000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/omp data/mat_2000x2000.txt data/mat_2000x2000b.txt |"
echo ".-----------------------------------------------------------------------------------."
cal_t=$((time bin/seq data/mat_2000x2000.txt data/mat_2000x2000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :     $cal_t"
cal_t=$((time bin/omp data/mat_2000x2000.txt data/mat_2000x2000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :     $cal_t"
echo

echo ".-------------------------- 2000x2000 Float  Matris çarpımı --------------------------."
echo "| Seri Çarpım Komut   = time bin/f_seq data/mat_2000x2000.txt data/mat_2000x2000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/f_omp data/mat_2000x2000.txt data/mat_2000x2000b.txt |"
echo ".-------------------------------------------------------------------------------------."
cal_t=$((time bin/f_seq data/mat_2000x2000.txt data/mat_2000x2000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :    $cal_t"
cal_t=$((time bin/f_omp data/mat_2000x2000.txt data/mat_2000x2000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :    $cal_t"
echo

echo ".------------------------- 3000x3000 Double Matris çarpımı -------------------------."
echo "| Seri Çarpım Komut   = time bin/seq data/mat_3000x3000.txt data/mat_3000x3000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/omp data/mat_3000x3000.txt data/mat_3000x3000b.txt |"
echo ".-----------------------------------------------------------------------------------."
cal_t=$((time bin/seq data/mat_3000x3000.txt data/mat_3000x3000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :     $cal_t"
cal_t=$((time bin/omp data/mat_3000x3000.txt data/mat_3000x3000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :     $cal_t"
echo

echo ".-------------------------- 3000x3000 Float  Matris çarpımı --------------------------."
echo "| Seri Çarpım Komut   = time bin/f_seq data/mat_3000x3000.txt data/mat_3000x3000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/f_omp data/mat_3000x3000.txt data/mat_3000x3000b.txt |"
echo ".-------------------------------------------------------------------------------------."
cal_t=$((time bin/f_seq data/mat_3000x3000.txt data/mat_3000x3000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :    $cal_t"
cal_t=$((time bin/f_omp data/mat_3000x3000.txt data/mat_3000x3000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :    $cal_t"
echo

echo ".------------------------- 4000x4000 Double Matris çarpımı -------------------------."
echo "| Seri Çarpım Komut   = time bin/seq data/mat_4000x4000.txt data/mat_4000x4000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/omp data/mat_4000x4000.txt data/mat_4000x4000b.txt |"
echo ".-----------------------------------------------------------------------------------."
cal_t=$((time bin/seq data/mat_4000x4000.txt data/mat_4000x4000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :     $cal_t"
cal_t=$((time bin/omp data/mat_4000x4000.txt data/mat_4000x4000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :     $cal_t"
echo

echo ".-------------------------- 4000x4000 Float  Matris çarpımı --------------------------."
echo "| Seri Çarpım Komut   = time bin/f_seq data/mat_4000x4000.txt data/mat_4000x4000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/f_omp data/mat_4000x4000.txt data/mat_4000x4000b.txt |"
echo ".-------------------------------------------------------------------------------------."
cal_t=$((time bin/f_seq data/mat_4000x4000.txt data/mat_4000x4000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :    $cal_t"
cal_t=$((time bin/f_omp data/mat_4000x4000.txt data/mat_4000x4000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :    $cal_t"
echo

echo ".------------------------- 5000x5000 Double Matris çarpımı -------------------------."
echo "| Seri Çarpım Komut   = time bin/seq data/mat_5000x5000.txt data/mat_5000x5000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/omp data/mat_5000x5000.txt data/mat_5000x5000b.txt |"
echo ".-----------------------------------------------------------------------------------."
cal_t=$((time bin/seq data/mat_5000x5000.txt data/mat_5000x5000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :     $cal_t"
cal_t=$((time bin/omp data/mat_5000x5000.txt data/mat_5000x5000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :     $cal_t"
echo

echo ".-------------------------- 5000x5000 Float  Matris çarpımı --------------------------."
echo "| Seri Çarpım Komut   = time bin/f_seq data/mat_5000x5000.txt data/mat_5000x5000b.txt |"
echo "| OpenMP Çarpım Komut = time bin/f_omp data/mat_5000x5000.txt data/mat_5000x5000b.txt |"
echo ".-------------------------------------------------------------------------------------."
cal_t=$((time bin/f_seq data/mat_5000x5000.txt data/mat_5000x5000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "Seri çarpım ile geçem süre   :    $cal_t"
cal_t=$((time bin/f_omp data/mat_5000x5000.txt data/mat_5000x5000b.txt)  2>&1 > /dev/null | grep real | awk '{print $2 " " toupper($1)}')
echo "OpenMP ile geçen toplam süre :    $cal_t"
echo

