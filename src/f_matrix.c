#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include "f_matrix.h"

/* 
    Burada matrix.h header dosyasında tanımlanmış üç fonksyonun prototip tanımlamaları
    yapılmıştı. burada da bu fonksiyonların ve structın içinin doldurulmasını gerçekliyoruz.
    İlk fonksiyonumuz struct içerisini matris verileriyle doldurmamızı sağlamaktadır. İkincisi
    fonsiyona gönderilen matris verisinin ekrana bastırılmasını sağlamaktadır. Programın
    uygulama bölümünde bu gösterilmemektedir ancak Demo.sh ile bunun ekrana bastırdığı da 
    gerçeklenmiştir. Üçüncü olarak da bellek üzerinde allocate edilen yani tahsis edilen 
    bölgenin serbest bırakılmasıdır.
*/

matrix_struct *get_matrix_struct(char matrix[]) {
    // Matris verisinin doldurulacağı struct bellek alanı tahsis edilmektedir.
    // malloc() fonksiyonunda kullanılan parametre tahsis etmek istediğiniz 
    // belleğin byte olarak değerini gösterir. malloc() fonksiyonu tahsis edilmiş 
    // belleğin başlangıcını gösteren bir işaretçi geri verir. Tahsis edilmek istenen 
    // bellek ihtiyacını karşılayamadığında, NULL bir işaretçi geri verir.
    matrix_struct *m = malloc(sizeof(matrix_struct));
    m->rows = 0;
    m->cols = 0;

    //Dosya alınan parametre ile okunur ve salt okunur olarak açılır.
    FILE* myfile = fopen(matrix, "r");
    
    // Eğer dosya bulunamazsa bu noktada hata ekrana yazılır ve program sonlanır.
    if(myfile == NULL) {
        printf("HATA: Girdiginiz dosya bulunamadi !\n");
        exit(EXIT_FAILURE);
    }

    // Satır ve sütunların sayısı struct içerisindeki cols ve rows değişkenlerine aktarılır.
    // Matris içerisinde sütunlar birbirinden \t ile satırlar ise \n ile ayrılmaktadır. Eğer
    // \t görüldüyse ilk satırda bu bir sütun olarak eklenir, \n görüldüyse satır olarak
    // tanımlanmaktadır. Bu yüzden do-while döngüsü kullanılmıştır. Dosya sonunda olup olmadığı
    // da en sonda kontrol edilerek döngünün devam etmesi sağlanmıştır.
    int ch = 0;
    do {
        ch = fgetc(myfile);
        
        // Açıklamadaki sütun kontrolü
        if(m->rows == 0 && ch == '\t')
            m->cols++;
        
        // Açıklamadaki satır kontrolü
        if(ch == '\n')
            m->rows++;
            
    } while (ch != EOF);
    
    // Satırın sonunda \t olmadığından dolayı son sütun eklemesi döngü dışında yapılır.
    m->cols++;
    
    // mat_data matris verilerimizin tutulduğu struct içerisindeki double/float tipli
    // pointerımızdır. Satır sayımız nihai bir şekilde belli olduğu için direk olarak
    // mat_data içerisinde allocate edilir, matris diyebilmemiz için de döngü ile beraber
    // satır sayısı kadar da sütun boyutu allocate edilir. Bellek tahsislerinde calloc() 
    // fonksiyonu da kuallnılmasının sebebi, bu fonksiyonun malloc() fonksiyonundan farkı 
    // ayrılacak bellek miktarının eleman boyutu ve eleman sayısı olarak iki argüman halinde 
    // tanımlanmış olmasıdır.
    m->mat_data = calloc(m->rows, sizeof(float*)); 
    int i;
    for(i=0; i < m->rows; ++i)
        m->mat_data[i]=calloc(m->cols, sizeof(float));
        
    // getch ile beraber dosyanın sonuna kadar okuma yapmıştık, satır ve sütunların sayısını
    // bu şekilde belirleyerek struct içerisindeki sayılarını tanımlamış, daha sonrada 
    // matrisimizin içini doldurabilmemiz için bellek alanımızı tahsis temiştik. Veriyi
    // okuyum matrise yazabilmemiz için dosya okuyucusunu aşağıdaki rewind fonkyionu ile 
    // dosyanın en başına götürüyoruz.
    rewind(myfile);
    int x,y;
    
     // fscanf ile beraber de tüm veriyi matris içerisine aktarıyoruz.
    for(x = 0; x < m->rows; x++) {
        for(y = 0; y < m->cols; y++) {
            if (!fscanf(myfile, "%f", &m->mat_data[x][y]))
            break;
        }
    }
    
    // Tüm okuma işlemimizi tamamladıktan sonra da okuduğumuz dosyayı kapatıp
    // m olarak tanımladığımız matris, satır ve sütunlarımızın bulunduğu
    // struct pointerını return ediyoruz. Bu sayede nerede çağırılırsa çağırılsın
    // çarpılacak A ve B matrisleri birbirlerine karıştırılmamaktadır. Sonuç olarak
    // ortaya çıkan Result matrisi de belleğin farklı bir bölgesinde tutulmaktadır.
    // Dinamik bellek kullanımı bu işlemi mümkün kılmaktadır.
    fclose(myfile);

    return m;
}

// Alınan struct pointerı ile pointerın işaret ettiği bellek bölgesi içerisindeki
// matris verisi aşağıda satır ve sütun olarak ekrana bastırılmaktadır. Burada her 
// bir satır yazımından sonra \n bir alt satıra geçmek için, her bir sütun arasında
// boşluk bırakmak için de \t kullanılmıştır.
void print_matrix(matrix_struct *matrix_to_print){
    int i,j;
    for(i = 0; i < matrix_to_print->rows; i++) {
        for(j = 0; j < matrix_to_print->cols; j++) {
            printf("%f\t",matrix_to_print->mat_data[i][j]); //Use lf format specifier, \n is for new line
        }
        printf("\n");
    }
}

// Program sonlandırılmadan öcne dinamik olarak tahsis edilen bellek bölgelerinin 
// boşaltılması gerekmektedir. Bu da free fonksiyonu ile beraber yapılır. Bellek
// boşaltım işlemi satır satır yapılabilir, alınan struct pointerı ile beraber
// veriler satır satır boşaltılır, daha sonra struct içerisindeki mat_data serbest
// bırakılır, en son olarak da struct serbest bırakılarak tahsis edilen tüm alanlar
// boşaltılmış olur.
void free_matrix(matrix_struct *matrix_to_free) {
    for(int i = 0; i < matrix_to_free->rows; i++) {
        free(matrix_to_free->mat_data[i]);
    }
    free(matrix_to_free->mat_data);
    free(matrix_to_free);
}

