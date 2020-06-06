# Parallel OpenMP Kullanarak Matris Çarpımı
# Ahmetcan İRDEM - 357405 - II. Öğretim

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

### 6. Matris boyutlarını sırasıyla n=1K, 2K, ... 5K (K:bin) boyutlarında olacak şekilde çalıştırınız (yani 5 seri çarpım, 5 paralel çarpma işlemi yapacaksınız). Çarpma işleminde veri tanımı REEL olmalı ve işlemler REEL yapılmalıdır. Ve Hem FLOAT, hem de DOUBLE matrisler için çarpımlar yapmalısınız.
    1000x1000 Double Matris çarpımı
    Seri çarpım ile geçem süre   :    0m4.401s REAL
    OpenMP ile geçen toplam süre :    0m3.034s REAL

    1000x1000 Float  Matris çarpımı
    Seri çarpım ile geçem süre   :    0m3.201s REAL
    OpenMP ile geçen toplam süre :    0m2.842s REAL

    2000x2000 Double Matris çarpımı
    Seri çarpım ile geçem süre   :     0m49.659s REAL
    OpenMP ile geçen toplam süre :     0m18.058s REAL

    2000x2000 Float  Matris çarpımı
    Seri çarpım ile geçem süre   :    0m44.849s REAL
    OpenMP ile geçen toplam süre :    0m16.579s REAL

    3000x3000 Double Matris çarpımı 
    Seri çarpım ile geçem süre   :     3m11.264s REAL
    OpenMP ile geçen toplam süre :     0m56.934s REAL

    3000x3000 Float  Matris çarpımı
    Seri çarpım ile geçem süre   :    2m42.554s REAL
    OpenMP ile geçen toplam süre :    0m50.853s REAL

    4000x4000 Double Matris çarpımı 
    Seri çarpım ile geçem süre   :     8m27.023s REAL
    OpenMP ile geçen toplam süre :     2m13.903s REAL

    4000x4000 Float  Matris çarpımı 
    Seri çarpım ile geçem süre   :    6m39.968s REAL
    OpenMP ile geçen toplam süre :    1m57.217s REAL

    5000x5000 Double Matris çarpımı
    Seri çarpım ile geçem süre   :     18m3.273s REAL
    OpenMP ile geçen toplam süre :     4m45.241s REAL

    5000x5000 Float  Matris çarpımı
    Seri çarpım ile geçem süre   :    13m38.047s REAL
    OpenMP ile geçen toplam süre :    3m52.087s REAL

### 7. Hazırladığınız FLOAT ve DOUBLE sürümlerde farklılık var mıdır?
Evet yukarıda da görüldüğü üzere Float ve Double tipli sürümlerde farklılık mevcuttur. Bunun sebebi Double tipli değişkenlerin 64bit Float'ın ise 32bit alanda saklanmalarıdır. Hatta eğer Demo.sh çıktısını incelediğiniz zaman, devirli olan kısımlarda Float tipli verilerin devirden sonraki kısmının tutulamadığını görebilirsiniz. Hesaplamayı doğru yapmaktadır ancak devirli kısmı yukarıya yuvarlar.

### 8. Sisteminizde belirtilen FLOP/s performans limitinin yüzde kaçına ulaşabildiniz, açıklayınız.
Seri hesaplama yapılırken bilgisayarımın üzerindeki 8 core dan sadec biri çalışmaktadır, toplam cpu performansının yaklaşık olarak 12.3 % kullanılmaktadır. Paralel hesaplama yapılırken ise tüm cpular eş zamanlı çalışmaya geçerek videoda da görebileceğiniz gibi yaklaşık olarak 99.8 % i kullanılmaktadır. 

### 9. Veri paylaşım türlerine göre uygulamanızı geliştiriniz ve performans değişimlerinin var olup olmadığını açıklayınız.
Veri paylaşımı OpenMP üzerinde Shared Memory sistemine göre çalışır, Süreçler belirli bir bellek bölgesine yazma ve okuma yaparak haberleşmeyi gerçekleştirir. Süreçler arası haberleşmedeki en basit teknik paylaşımlı bellek kullanımıdır. Bu yöntem aynı anda birden çok sürecinpaylaşımlı bir bellek ortamına erişimini sağlar. Süreçlerin hepsi aynı bellek bölgesini paylaştığı için, paylaşımlı bellek kavramı en hızlı IPC tekniğidir. Paylaşımlı bellek bölgesine erişim, sürecin kendine ait bellek bölgesineerişimi kadar hızlı gerçekleşir. Herhangi bir sistem çağrısını kullanmaya gerek yoktur. Aynı zamanda veriyi gereksizce kopyalamanın da önüne bu yöntemin kullanımıyla geçilir. Performans değişimleri de bu şekilde yaşanmıştır.

### 10. Bu çarpma işlemlerinde elde ettiğiniz performans artışını yorumlayınız.
Toplamda 110M (M:Milyon) çarpma işlemi yapılmıştır, tüm işlemler yaklaşık 1 saat 10 dk sürmüştür. Seri hesaplamalar toplamda süresi 54d24s, Paralel hesaplamalar da toplamda 15d16s sürmüştür. Seri işlemlere göre paralel işlemler zaman açısından 28% daha kısa sürmüştür. Tek CPU ile 8 CPU arasındaki fark daha fazla olmalıydı diye düşünüyorum, ancak bu da yeterli bir seviyedir. 18m3.273s süren Double 5000x5000 matris çarpımı 8 CPU ile 3m52.087s sürmektedir. Bu da zaman açısından fazlasıyla yeterli bir artıştır. Aşağıda da speedup değerlerini görebilirsiniz;

    1000x1000 Çarpımda Double Speedup =      4.401 / 3.034 = 1.45056
    1000x1000 Çarpımda Float  Speedup =      3.201 / 2.842 = 1.12632

    2000x2000 Çarpımda Double Speedup =    49.659 / 18.058 = 2.74997
    2000x2000 Çarpımda Float  Speedup =    44.849 / 16.579 = 2.70517

    3000x3000 Çarpımda Double Speedup =   191.264 / 56.934 = 3.3594
    3000x3000 Çarpımda Float  Speedup =   162.554 / 50.853 = 3.19655

    4000x4000 Çarpımda Double Speedup =  507.023 / 133.903 = 3.78649
    4000x4000 Çarpımda Float  Speedup =  399.968 / 117.217 = 3.4122

    5000x5000 Çarpımda Double Speedup = 1083.273 / 285.241 = 3.79775
    5000x5000 Çarpımda Float  Speedup =  818.047 / 232.087 = 3.52474

## Kaynaklar
FLOP/s Wikipedia Kaynağı -> ![Buradan](https://en.wikipedia.org/wiki/FLOPS) \
Intel CPU Metrik Kaynağı -> ![Buradan](https://www.intel.com/content/dam/support/us/en/documents/processors/APP-for-Intel-Core-Processors.pdf) \
FP64 ve FP32     Kaynağı -> ![Burdan](https://medium.com/@moocaholic/fp64-fp32-fp16-bfloat16-tf32-and-other-members-of-the-zoo-a1ca7897d407) \
4-Way Buffer     Kaynağı -> ![Burdan](https://www.sciencedirect.com/topics/computer-science/set-associative-cache)

