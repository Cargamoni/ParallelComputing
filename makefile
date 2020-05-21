# Make yardımcı programının amacı, büyük bir programın hangi parçalarının yeniden derlenmesi gerektiğini 
# otomatik olarak belirlemek ve bunları yeniden derlemek için komutlar vermektir. En yaygın C programları 
# ile kullanılır, ancak derleyici bir shell komutuyla çalıştırılabilen herhangi bir programlama diliyle 
# make kullanılabilir. Aslında, make sadece programlarla sınırlı değildir. Diğer dosyaların her değiştiğinde 
# bazı dosyaların diğerlerinden otomatik olarak güncelleştirilmesi gereken herhangi bir processi tanımlamak 
# için kullanılabilir.
# 
# # CC hangi programlama dilinin derleyicisi kullanılacaksa o seçilir. CC farklı bir isim de olabilir.
# Derleme yapılırkan hangi bayraklar kullanılacak onlar belirlenir std ile hangi standardın kullanılacağını 
# (ISO C99), Wall bayrağı sayesinde derleme esnasınad ekstra derleme hataları açılır, örnek olarak bir
# değişken tanımlanmıp ama kullanılmamışsa normalde hata vermeyen derleyici hatayı ekrana basar. -g 
# varsayılan debug bilgilendirmesini açar. GCC ile beraber openmp derlemesi yapılabilmesi için de -fopenmp
# bayrağı kullanılır. Son olarak da Tune dediğimiz kısma değinecek olursak -O2 bayrağı ile beraber 
# olabilecek en düşük boyutta derleme işleminin yapılması ve buna göre binary dosyalarının oluşturulması
# sağlanmıştır.
CC=gcc									
CFLAGS= -Wall -std=gnu99 -g -fopenmp	
LIBS=src/matrix.c
LIBS_F=src/f_matrix.c
TUNE= -O2

# Bu bölümde hangi isimler altında hangi komut nasıl derleneceği belirtilir. Aşağıdada değişken gibi
# kullanılarak derleme işleminde kullanılacak bayraklar ve dosyalar belirtilir.
all: sequential omp f_sequential f_omp

sequential:
		$(CC) $(TUNE) $(CFLAGS) -o bin/seq $(LIBS) src/sequential.c

omp:
		$(CC) $(TUNE) $(CFLAGS) -o bin/omp $(LIBS) src/omp.c

f_sequential:
		$(CC) $(TUNE) $(CFLAGS) -o bin/f_seq $(LIBS_F) src/f_sequential.c

f_omp:
		$(CC) $(TUNE) $(CFLAGS) -o bin/f_omp $(LIBS_F) src/f_omp.c
