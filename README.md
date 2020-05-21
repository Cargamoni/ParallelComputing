# Parallel OpenMP Kullanarak Matris Çarpımı

## Özet
Karadeniz Teknik Üniversitesi, Bilgisayar Mühendisliği Paralel Bilgisayarlar dersi projesi için buradayız. Burada hem sıralı bir şekilde lineer matris çarpımı, hemde OpenMP kullanılarak çoklu matris çarpımı yapılacaktır. Buradaki amaç tek CPU üzerinde yapılan işlemi parçalara bölerek en çok işlemi en kısa sürede yapmaktır. 

Dersin Sorumlusu: Dr. İbrahim SAVRAN

Projenin Konusu : Sistem Bilgisini İnceleme ve Matris Çarpımı

## Amaç
Bilgisayarınızın özelliklerini incelemek ve bu özelliklerin Matris çarpma işlemine etkisi.

Proje soru cevapları ve proje dosyalarını açıklamadan önce, projeyi çalıştırmak için gerekli olan kütüphane dosyalarını, derleme esnasında yapılması gerekenlere dair bilgilendirmeleri yapıalcaktır.

    NOT: Oneris her bir elemanı 1 olan matristir, evet ben uydurdum. (Vanris diye okunur).


## Nasıl Kullanılır ? 

### Gereksinimler
Proje üzerindeki çalışma, GNU/Linux sistemler üzerinde denenmiş ve çalıştırılmıştır. Windows sistem üzerinde bir takım değişiklikler yapılması gerekmektedir. Örnek olarak vermek gerekirse, GCC ile derleme işlemi için ya MinGW ya da CygWin yüklenip, BASH kabuğu üzerinde Bash betiklerinin çalıştırılabilir hale getirilmesi gerekmektedir.

    - GNU/Linux Gereksinimleri
        python2.7
        GCC
        OpenMP
            - libomp-dev paketi kurulu olmalıdır.
            - Derleme esnasında -fopenmp bayrağı kullanılmalıdır.
        Make
            - Bazı dağıtımlarda make kurulu gelmez, ekstra olarak yüklemeniz gerekir.

    - Windows Gereksinimleri
        python2.7
        MinGW veya CygWin (GCC, Make ve Bash)
        OpenMP
            - Normalde yüklü olarak geliyor, ancak nasıl kullanıldığını bilmiyorum.
            GNU/Linux sistemlerde çalıştığım için araştırılıp öğrenilebilir.

### Kullanımı
Aslında kullanımı gayet basit, öncelikle algoritmanın ve kodların çalıştığını Demo.sh çalıştırılarak görülebilir. Öncelikle bu komutu nasıl çalıştırıldığını ve çıktıya göz atalım. Bu bir Bash Betiğidir, çalıştırıldığı zaman içerisindeki Bash komutlarını sizin yerinize çalıştırılmaktadır. Bu oluşturulma esnasında olası hataların sebebi, gereksinimleri karşılayamamızdır, bir başka sebebi de bin veya data dizinleri proje dizini içerisinde yoksa, 'no such file or directory' hatası alınabilir.

Demo.sh Betiği, 2 adet 2x2 Matris, 2 adet 5x5 Matris, 2 adet 2x2 Oneris (1'lerden oluşan matris, evet ben uydurdum.) ve son olarak da 2 adet 5x5 Oneris oluşturur. Daha sonra bunlar üzerinde matris çarpımını yaparak ekrana yazdırır. Hem demo hemde asıl programın koşması sırasıyla şu şekildedir,

    RunMe.sh
    - Matris Oluşturulması
    - Derleme İşlemi
    - Hesaplama İşlemi
    - Hesaplama Sürelerinin Ekrana yazılması
    
    Demo.sh
    - Matris Oluşturulması
    - Derleme İşlemi
    - Hesaplama İşlemi
    - Sonuçların Ekrana Basılması

Proje dosyalarının içierisindeyken aşağıdaki komut ile beraber betik çalıştırılır.

    $ ./Demo.sh
    .-----------------------------------------------------.
    | KTÜ Bilgisayar Mühendisliği - Paralel Bilgisayarlar |
    |        Ahmetcan İRDEM - 357405 - II. Öğretim        |
    .-----------------------------------------------------.

    Test Matrisleri Oluşturuluyor, eğer test matrisleri mevcutsa yeniden oluşturulmayacaktır.

    Demonstrasyon için;
    5x5 Matris oluşturuluyor..
    Demonstrasyon için;
    5x5 Oneris oluşturuluyor..
    .----------------.
    | Derleme İşlemi |
    .----------------.
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/seq src/matrix.c src/sequential.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/omp src/matrix.c src/omp.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_seq src/f_matrix.c src/f_sequential.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_omp src/f_matrix.c src/f_omp.c

    .---------------.
    | Demonstrasyon |
    .---------------.
    Matris A:
    9474.76324142   372.770098359
    1756.59262156   2958.4630542

    Matris B:
    8731.12749238   4683.8546868
    1999.15220655   1127.46641697

    Sonuç Seri Duble:
    83470589.985624 44798699.981796
    21251452.073815 11563192.322749

    Sonuç OpenMP Double:
    83470589.985624 44798699.981796
    21251452.073815 11563192.322749

    Sonuç Seri Float:
    83470600.000000 44798700.000000
    21251452.000000 11563192.000000

    Sonuç OpenMP Float:
    83470600.000000 44798700.000000
    21251452.000000 11563192.000000

Demo betiği çalıştırıldığı zaman yukarıdaki gibi bir çıktı göreceksiniz, burada matris çarpımının doğru bir şekilde yapıldığını görebilirsiniz. İlerleyen adımlarda diğer sonuçları da gösterilmektedir. Burada bir kısmı yer almaktadır, lütfen Demo.sh betiğini çalıştırıp gözlemleyin. Aşağıda da projenin asıl yapılış amacının gerçeklenmesi gösterilecektir.

Betik sırasıyla 1000x1000, 2000x2000, 3000x3000, 4000x4000 ve son olarak 5000x5000 matris çarpımları yapmaktadır. Seri çarpım ile Paralel çarpım işlemleri arasındaki, ekstra olarak da Double ve Float veri tipleri arasındaki seri ve Paralel çarpım işlemlerinin ne kadar sürede tamamlandığı izlenmektedir. Bu sürelerin değerlendirilmesi yapılıp, üzerine FLOP/s hesaplamaları yapılacaktır. Aşağıdaki gibi çalıştırılabilir.

    $ ./RunMe.sh
    .-----------------------------------------------------.
    | KTÜ Bilgisayar Mühendisliği - Paralel Bilgisayarlar |
    |        Ahmetcan İRDEM - 357405 - II. Öğretim        |
    .-----------------------------------------------------.

    Test Matrisleri Oluşturuluyor, eğer test matrisleri mevcutsa yeniden oluşturulmayacaktır.

    .----------------.
    | Derleme İşlemi |
    .----------------.
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/seq src/matrix.c src/sequential.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/omp src/matrix.c src/omp.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_seq src/f_matrix.c src/f_sequential.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/f_omp src/f_matrix.c src/f_omp.c

    .------------------.
    | Hesaplama İşlemi |
    .------------------.
    .------------------------- 1000x1000 Double Matris çarpımı -------------------------.
    | Seri Çarpım Komut   = time bin/seq data/mat_1000x1000.txt data/mat_1000x1000b.txt |
    | OpenMP Çarpım Komut = time bin/omp data/mat_1000x1000.txt data/mat_1000x1000b.txt |
    .-----------------------------------------------------------------------------------.
    Seri çarpım ile geçem süre   :    0m5.762s REAL
    OpenMP ile geçen toplam süre :    0m3.636s REAL

    .-------------------------- 1000x1000 Float  Matris çarpımı --------------------------.
    | Seri Çarpım Komut   = time bin/f_seq data/mat_1000x1000.txt data/mat_1000x1000b.txt |
    | OpenMP Çarpım Komut = time bin/f_omp data/mat_1000x1000.txt data/mat_1000x1000b.txt |
    .-------------------------------------------------------------------------------------.
    Seri çarpım ile geçem süre   :    0m4.444s REAL
    OpenMP ile geçen toplam süre :    0m3.199s REAL

Diğer çarpım işlemlerinin sonuçları da betik çalıştırılarak sonuçlar kendi bilgisayarınızda gözlemleyebilirsiniz.

## Proje Soruları

### 1. Bilgisayarınızın FLOP/s kapasitesi nedir ?
lscpu komutuna göre Intel(R) Core(TM) i7-6700HQ mimarisinde 4 Adet Core 8 adet CPU mevcuttur. Her Core üzerinde de 2 Thread mevcuttur. CPU taban frekansı 2.6 GHz'dır. Denkleme bakacak olursak;

![FLOPS1](https://wikimedia.org/api/rest_v1/media/math/render/svg/8e2d9e4d6fbefcb55359c89dba359ba920554525)

veya daha genel kullanımdaki ve basitleştirilmiş formül için;

![FLOPS1](https://wikimedia.org/api/rest_v1/media/math/render/svg/4b9594923d35f31fac9244bbd3d3596c87fc05ca)

Alttaki formülü kullanacak olursak, bilgisayarımın her bir Cycle'da yaptığı FP64 (Double-Precision Floating-Point Format) yani Double veri tipi ile yapılan işlemi sayısı 16dır. Bunu formüle uygulayacak olursak FLOPS = 4 * 2.60 * 16 = 166.4 GFLOPS değeri bulunur. Sağlaması için aşağıdaki Intel kaynağından kontrol edilebilir. FP32 (Single-Precision Floating-Point Format) yani Float veri tipi ile yapılan işlemi sayısı 32dır. Bunu formüle uygulayacak olursak FLOPS = 4 * 2.60 * 32 = 332.8 GFLOPS değeri bulunur. Sağlaması için aşağıdaki Intel kaynağından kontrol edilebilir. FP64 ve FP32'nin ne olduğuna dair bilgi de aşağıdan ##Kaynaklar dan bakılabilir. 

    FP64 - FLOPS = 4 * 2.60 * 16 = 166.4 GFLOPS
    FP32 - FLOPS = 4 * 2.60 * 32 = 332.8 GFLOPS

## Kaynaklar
FLOP/s Wikipedia Kaynağı -> ![Buradan](https://en.wikipedia.org/wiki/FLOPS)
Intel CPU Metrik Kaynağı -> ![Buradan](https://www.intel.com/content/dam/support/us/en/documents/processors/APP-for-Intel-Core-Processors.pdf)
FP64 ve FP32     Kaynağı -> ![Burdan](https://medium.com/@moocaholic/fp64-fp32-fp16-bfloat16-tf32-and-other-members-of-the-zoo-a1ca7897d407)





The aim is to multiply two matrices together.To multiply two matrices, the number of columns of the first matrix has to match the number of lines of the second matrix. The calculation of the matrix solution has independent steps, it is possible to parallelize the calculation.

## Project Tree

    .
    |-- bin
    |   |-- seq
    |   |-- omp
    |   |-- f_seq
    |   `-- f_omp
    |-- data
    |   |-- mat_4_5.txt
    |   `-- mat_5_4.txt
    |-- src
    |   |-- matrix.c
    |   |-- matrix.h
    |   |-- mpi.c
    |   |-- omp.c
    |   |-- sequential.c
    |   |-- thread2.c
    |   `-- thread.c
    |-- Makefile
    |-- random_float_matrix.py
    |-- README.md
    |-- README.pdf
    `-- Test-Script.sh

The `README.*` contains this document as a Markdown and a PDF file.
The python script `random_float_matrix.py` generates `n x m` float matrices (This script is inspired by Philip Böhm's solution).
`./Test-Script.sh` is a script that generates test matrices with the python script, compiles the C-programs with `make` and executes the diffrent binaries with the test-matrices. The output of the script are the execution times of the particular implementations.

## Makefile
    CC=gcc
    CFLAGS= -Wall -std=gnu99 -g -fopenmp
    LIBS=src/matrix.c
    LIBS_F= src/f_matrix.c
    TUNE= -O2
    
    all: sequential omp thread2 mpi
    
    sequential:
    		$(CC) $(TUNE) $(CFLAGS) -o bin/seq $(LIBS) src/sequential.c
    
    omp:
    		$(CC) $(TUNE) $(CFLAGS) -o bin/omp $(LIBS) src/omp.c
    

`make` translates all implementations. The binary files are then in the `bin/` directory.
The implementation `thread2.c` is the final solution of the *thread* subtask. `thread.c` was my first runnable solution but it is not fast(every row has one thread). I decided to keep it anyway, for a comparable set.
For the compiler optimization I have chosen "-02", the execution time was best here.

## Example
Every implementation needs 2 matrix files as program argument to calculate the result matrix to `stdout` (`bin/seq mat_file_1.txt mat_file_2.txt`).
The `rows` are seperated by newlines(`\n`) and the columns are seperated by tabular(`\t`). The reason is the pretty output on the shell. All implementations calculate with floating-point numbers.

    [mp432@localhost]% cat data/mat_4_5.txt 
    97.4549968447	4158.04953246	2105.6723138	9544.07472156	2541.05960201
    1833.23353473	9216.3834844	8440.75797842	1689.62403742	4686.03507194
    5001.05053096	7289.39586628	522.921369146	7057.57603906	7637.9829023
    737.191477364	4515.30312019	1370.71005027	9603.48073923	7543.51110732
    
    [mp432@localhost]% cat data/mat_5_4.txt 
    8573.64127861	7452.4636398	9932.62634628	1261.340226
    7527.08499112	3872.81522875	2815.39747607	5735.65492468
    7965.24212592	7428.31976294	290.255638815	5940.92582147
    6175.98390217	5995.21703679	6778.73998746	9060.90690747
    2006.95378498	6098.70324661	619.384482373	1396.62426963
    
    [mp432@localhost]% bin/seq data/mat_4_5.txt data/mat_5_4.txt
    112949567.256707	105187212.450287	79556423.335490    126508582.287008	
    172162416.208937	150764506.000392	60962563.539173    127174399.969315	
    160826865.507086	158278548.934611	122920214.859773   125839554.344572	
    125675943.680898	136743486.943968	90204309.448167	   132523052.230353	

## Implementations

### Sequential

The sequential program is used to compare and correctness to the other implementations. The following is an excerpt from the source code. Here is computed the result matrix.

    for (int i = 0; i < result_matrix->rows; i++) {
        for (int j = 0; j < result_matrix->cols; j++) {
            for (int k = 0; k < m_1->cols; k++) {
                result_matrix->mat_data[i][j] += m_1->mat_data[i][k] *      
                m_2->mat_data[k][j];
            }
        }
    }

### Thread (POSIX Threads)
The `sysconf(_SC_NPROCESSORS_ONLN)` from `#include <unistd.h>` returns the number of processors, what is set as the thread number, to use the full capacity. The following excerpt shows the thread memory allocation.

    int number_of_proc = sysconf(_SC_NPROCESSORS_ONLN);
    ...
    // Allocate thread handles
    pthread_t *threads;
    threads = (pthread_t *) malloc(number_of_proc * sizeof(pthread_t));

### Open Multi-Processing (OpenMP)
The standard shared-memory model is the fork/join model.
The OpenMP implementation is just the sequential program with the omp pragma `#pragma omp parallel for` over the first for-loop. This pragma can only be used in the outer loop. Only there are independent calculations.
The performance increased about 40 percent compared to the sequential implementation. 

    #pragma omp parallel for
    for (int i = 0; i < result_matrix->rows; i++) {
        for (int j = 0; j < result_matrix->cols; j++) {
            for (int k = 0; k < m_1->cols; k++) {
                result_matrix->mat_data[i][j] += m_1->mat_data[i][k] *
                m_2->mat_data[k][j];
            }
        }
    }
    
### Message Passing Interface (MPI)
A difficulty it was the spread of the data to the worker.
At first, the matrix dimensions will be broadcast via `MPI_Bcast(&matrix_properties, 4, MPI_INT, 0, MPI_COMM_WORLD);` to the workers.

The size of the matrices is fixed. Now the 2-Dim matrix is converted into a 1-Dim matrix. So it is easier and safer to distribute the matrix data.

This function gets a matrix struct and returns an 1-Dim data array.

    double *mat_2D_to_1D(matrix_struct *m) {
        double *matrix = malloc( (m->rows * m->cols) * sizeof(double) );
        for (int i = 0; i < m->rows; i++) {
            memcpy( matrix + (i * m->cols), m->mat_data[i], m->cols * sizeof(double) );
        }
        return matrix;
    }

The second step is to broadcast the matrix data to the workers. Each worker computes its own "matrix area" with the mpi `rank`. Disadvantage of this implementation is that first all the data are distributed.
The third step is to collect the data via 

    MPI_Gather(result_matrix, number_of_rows, 
               MPI_DOUBLE, final_matrix,
               number_of_rows,  MPI_DOUBLE,
               0, MPI_COMM_WORLD);`

At the end, the master presents the result matrix.

> To compile and run the mpi implementation, it is necessary that `mpicc` and `mpirun` are in the search path. (e.g. `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib/  `)


## Performance Test
The `sirius cluster` was not available during task processing (specifically for the MPI program). Therefore, all performance tests were run on `atlas`.

    [mp432@atlas Parallel-Matrix-Multiplication-master]$ ./Test-Script.sh 
    generate test-matrices with python if no test data found
    
    generate 5x4 matrix...
    generate 100x100 matrix...
    generate 1000x1000 matrix...
    generate 5000x5000 matrix...
    compile...
    
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/seq src/matrix.c src/sequential.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/omp src/matrix.c src/omp.c
    gcc -O2 -Wall -std=gnu99 -g -fopenmp -pthread -o bin/thread2 src/matrix.c src/thread2.c
    mpicc -O2 -Wall -std=gnu99 -g -fopenmp -o bin/mpi src/matrix.c src/mpi.c
    
    calculate...
    
    * * * * * * * 100x100 Matrix
    with sequential    0m0.032s
    with omp           0m0.034s
    with thread2       0m0.032s
    with mpi(4p)       0m1.242s

    * * * * * * * 1000x1000 Matrix
    with sequential    0m11.791s
    with omp           0m4.182s
    with thread2       0m4.153s
    with mpi(4p)       0m12.682s
    
    * * * * * * * 5000x5000 Matrix
    with sequential    26m52.342s
    with omp           4m57.186s
    with thread2       5m5.767s
    with mpi(4p)       5m2.174s
    
The output times are the `real times` from the unix `time` command. 
You can see the advantages of parallel computation in the last matrix calculation. The parallel calculation is about 5 times faster (for large matrices).
