#!/bin/bash
echo ".-----------------------------------------------------."
echo "| KTÜ Bilgisayar Mühendisliği - Paralel Bilgisayarlar |"
echo ".-----------------------------------------------------."
echo
echo "Test Matrisleri Oluşturuluyor, eğer test matrisleri mevcutsa yeniden oluşturulmayacaktır."
echo

#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/seq src/matrix.c src/sequential.c
#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/omp src/matrix.c src/omp.c
#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_seq src/f_matrix.c src/f_sequential.c
#gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_omp src/f_matrix.c src/f_omp.c

if [ ! -f data/mat_2x2.txt ]; then
    echo "Demonstrasyon için;"
    echo "2x2 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 2 2 > data/mat_2x2.txt
fi

if [ ! -f data/mat_2x2b.txt ]; then
    python generator/random_float_matrix.py 2 2 > data/mat_2x2b.txt
fi

if [ ! -f data/mat_5x5txt ]; then
    echo "Demonstrasyon için;"
    echo "5x5 Matris oluşturuluyor.."
    python generator/random_float_matrix.py 5 5 > data/mat_5x5.txt
fi

if [ ! -f data/mat_5x5b.txt ]; then
    python generator/random_float_matrix.py 5 5 > data/mat_5x5b.txt
fi

if [ ! -f data/one_2x2.txt ]; then
    echo "Demonstrasyon için;"
    echo "2x2 Oneris oluşturuluyor.."
    python generator/one_float_matrix.py 2 2 > data/one_2x2.txt
fi

if [ ! -f data/one_2x2b.txt ]; then
    python generator/one_float_matrix.py 2 2 > data/one_2x2b.txt
fi

if [ ! -f data/one_5x5txt ]; then
    echo "Demonstrasyon için;"
    echo "5x5 Oneris oluşturuluyor.."
    python generator/one_float_matrix.py 5 5 > data/one_5x5.txt
fi

if [ ! -f data/one_5x5b.txt ]; then
    python generator/one_float_matrix.py 5 5 > data/one_5x5b.txt
fi

echo ".----------------."
echo "| Derleme İşlemi |"
echo ".----------------."
make
echo
echo ".---------------."
echo "| Demonstrasyon |"
echo ".---------------."
echo "Matris A:"
cat data/mat_2x2.txt
echo
echo "Matris B:"
cat data/mat_2x2b.txt
echo
echo "Sonuç Seri Duble:"
cal_t=$(bin/seq data/mat_2x2.txt data/mat_2x2b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Double:"
cal_t=$(bin/omp data/mat_2x2.txt data/mat_2x2b.txt)
echo "$cal_t"
echo
echo "Sonuç Seri Float:"
cal_t=$(bin/f_seq data/mat_2x2.txt data/mat_2x2b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Float:"
cal_t=$(bin/f_omp data/mat_2x2.txt data/mat_2x2b.txt)
echo "$cal_t"
echo

echo ".------------------."
echo "| Demonstrasyon  2 |"
echo ".------------------."
echo "Matris A:"
cat data/mat_5x5.txt
echo
echo "Matris B:"
cat data/mat_5x5b.txt
echo
echo "Sonuç Seri Duble:"
cal_t=$(bin/seq data/mat_5x5.txt data/mat_5x5b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Double:"
cal_t=$(bin/omp data/mat_5x5.txt data/mat_5x5b.txt)
echo "$cal_t"
echo
echo "Sonuç Seri Float:"
cal_t=$(bin/f_seq data/mat_5x5.txt data/mat_5x5b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Float:"
cal_t=$(bin/f_omp data/mat_5x5.txt data/mat_5x5b.txt)
echo "$cal_t"
echo

echo ".------------------."
echo "| Demonstrasyon  3 |"
echo ".------------------."
echo "Oneris A:"
cat data/one_2x2.txt
echo
echo "Oneris B:"
cat data/one_2x2b.txt
echo
echo "Sonuç Seri Duble:"
cal_t=$(bin/seq data/one_2x2.txt data/one_2x2b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Double:"
cal_t=$(bin/omp data/one_2x2.txt data/one_2x2b.txt)
echo "$cal_t"
echo
echo "Sonuç Seri Float:"
cal_t=$(bin/f_seq data/one_2x2.txt data/one_2x2b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Float:"
cal_t=$(bin/f_omp data/one_2x2.txt data/one_2x2b.txt)
echo "$cal_t"
echo

echo ".------------------."
echo "| Demonstrasyon  4 |"
echo ".------------------."
echo "Oneris A:"
cat data/one_5x5.txt
echo
echo "Oneris B:"
cat data/one_5x5b.txt
echo
echo "Sonuç Seri Duble:"
cal_t=$(bin/seq data/one_5x5.txt data/one_5x5b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Double:"
cal_t=$(bin/omp data/one_5x5.txt data/one_5x5b.txt)
echo "$cal_t"
echo
echo "Sonuç Seri Float:"
cal_t=$(bin/f_seq data/one_5x5.txt data/one_5x5b.txt)
echo "$cal_t"
echo
echo "Sonuç OpenMP Float:"
cal_t=$(bin/f_omp data/one_5x5.txt data/one_5x5b.txt)
echo "$cal_t"
echo
