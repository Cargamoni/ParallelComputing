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

Alttaki formülü kullanacak olursak, bilgisayarımın her bir Cycle'da yaptığı FP64 (Double-Precision Floating-Point Format) yani Double veri tipi ile yapılan işlemi sayısı 16dır. Bunu formüle uygulayacak olursak FLOPS = 4 * 2.60 * 16 = 166.4 GFLOPS değeri bulunur. Sağlaması için aşağıdaki Intel kaynağından kontrol edilebilir. FP32 (Single-Precision Floating-Point Format) yani Float veri tipi ile yapılan işlemi sayısı 32dır. Bunu formüle uygulayacak olursak FLOPS = 4 * 2.60 * 32 = 332.8 GFLOPS değeri bulunur. Sağlaması için aşağıdaki Intel kaynağından kontrol edilebilir. FP64 ve FP32'nin ne olduğuna dair bilgi de [Kaynaklar'dan](https://github.com/Cargamoni/ParallelComputing#kaynaklar) bakılabilir. 

    FP64 - FLOPS = 4 * 2.60 * 16 = 166.4 GFLOPS
    FP32 - FLOPS = 4 * 2.60 * 32 = 332.8 GFLOPS

### 2. Sisteminizdeki Cache belleğin özelliklerini açıklayınız, I-Cache - D-Cache kapasiteleri nedir ?
Yine lscpu komutuna göre Intel(R) Core(TM) i7-6700HQ mimarisinde L3 Cache 6MB, L2 Cache 1MB, L1 Cache'de 256KB'dır. L1 Cache içerisinde I-Cache ve D-Cache bulunur ve her biri L1 Cache miktarının yarısı olan 128KB'dır.

![Cache](https://gateoverflow.in/?qa=blob&qa_blobid=8952829199030697923)

Önbellek neden vardır ? CPU ve RAM arasında uzun bir köprü olduğunu düşünün, sık sık kullandığınız bell başlı bir veri veya veriler var, ya da bir veri diğerlerinden çok daha önemli ve hızlıca erişmenize ihtiyacınız var. Bu durumda uzun köprüyü kat etmek yerine kendi içerisindeki ufak depolama alanlarında CPU bu verileri depolar ve ihtiyacı olduğu zamanlarda uzun bir yol kat etmek yerine buradan kullanır. 

### 3. Tampon bellekler için 4-yönlü (4-way) ne demektir?
Bazı önbellekler, çökme sıklığını azaltmak için ek bir tasarım özelliği içerir. Bu yapısal tasarım özelliği, önbellekleri yol adı verilen daha küçük eşit birimlere bölen bir değişikliktir. Hala dört KB'lik bir önbellektir; ancak, ayarlanan dizin artık birden fazla önbellek satırına hitap etmektedir - her şekilde bir önbellek satırına işaret etmektedir. 256 satırlık bir yol yerine, önbellek 64 satırlık dört yol içerir. Aynı küme dizinine sahip dört önbellek satırının aynı kümede olduğu söylenir, bu da “küme dizini” adının kaynağıdır.

Set dizini tarafından işaret edilen önbellek çizgileri kümesi ilişkisel olarak ayarlanır. Ana bellekten bir veri veya kod bloğu, program davranışını etkilemeden bir kümedeki dört yoldan birine tahsis edilebilir; diğer bir deyişle, verilerin bir küme içindeki önbellek satırlarında depolanması programın yürütülmesini etkilemez. Ana bellekten gelen iki ardışık blok, aynı şekilde veya iki farklı şekilde önbellek satırları olarak saklanabilir. Dikkat edilmesi gereken önemli bir nokta, ana bellekteki belirli bir konumdaki veri veya kod bloklarının bir kümenin üyesi olan herhangi bir önbellek satırında saklanabilmesidir. Bir küme içindeki değerlerin yerleştirilmesi, aynı kodun veya veri bloğunun aynı anda bir kümedeki iki önbellek satırını işgal etmesini önlemek için özeldir.

![4way](https://ars.els-cdn.com/content/image/3-s2.0-B9781558608740500137-f12-08-9781558608740.gif?_)

### 4. Projede nxn boyutlu 2 matrisin çarpımının yapmanız istenmiştir. Proejnin hem seri hemde parapelel kodlamasını yapınız.
#### Seri Hesaplama Kodu
Matrislerin çarpma işlemini yapan kdun bölümü bu şekildedir. Kaynak kodun sadece bir bölümü buradadır detaylı açıklama için kaynak kodunu inceleyebilirsiniz. Burada result_matrix sonucun tutulduğu matristir.

    for (int i = 0; i < result_matrix->rows; i++) {
        for (int j = 0; j < result_matrix->cols; j++) {
            for (int k = 0; k < m_1->cols; k++) {
                result_matrix->mat_data[i][j] += m_1->mat_data[i][k] *      
                m_2->mat_data[k][j];
            }
        }
    }


#### Open Multi-Processing (OpenMP)
Standart paylaşımlı bellek modeli olan join/fork ile çalışmaktadır. Basit bir şekilde seri hesaplama koduna `#pragma omp paraller for` ile sağlanmıştır. Bu pragma keywordu sadece for dışında kullanılabilir, bu sayede birbirinden bağımsız hesaplamalar yapılabilir. Bu sayede performans seri hesaplamayla kıyaslandığında yüzde kırk oranında 

    #pragma omp parallel for
    for (int i = 0; i < result_matrix->rows; i++) {
        for (int j = 0; j < result_matrix->cols; j++) {
            for (int k = 0; k < m_1->cols; k++) {
                result_matrix->mat_data[i][j] += m_1->mat_data[i][k] *
                m_2->mat_data[k][j];
            }
        }
    }

### 5.Çarpma işleminin sonucunu kolay test etmek için matrisleri “1.0” ile doldurabilirsiniz.
    Oneris A:
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0

    Oneris B:
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0
    1.0     1.0     1.0     1.0     1.0

    5.000000        5.000000        5.000000        5.000000        5.000000
    5.000000        5.000000        5.000000        5.000000        5.000000
    5.000000        5.000000        5.000000        5.000000        5.000000
    5.000000        5.000000        5.000000        5.000000        5.000000
    5.000000        5.000000        5.000000        5.000000        5.000000

....
..
.

## Kaynaklar
FLOP/s Wikipedia Kaynağı -> ![Buradan](https://en.wikipedia.org/wiki/FLOPS) \
Intel CPU Metrik Kaynağı -> ![Buradan](https://www.intel.com/content/dam/support/us/en/documents/processors/APP-for-Intel-Core-Processors.pdf) \
FP64 ve FP32     Kaynağı -> ![Burdan](https://medium.com/@moocaholic/fp64-fp32-fp16-bfloat16-tf32-and-other-members-of-the-zoo-a1ca7897d407) \
4-Way Buffer     Kaynağı -> ![Burdan](https://www.sciencedirect.com/topics/computer-science/set-associative-cache)


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
