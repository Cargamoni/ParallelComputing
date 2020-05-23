#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include "matrix.h"
#include <omp.h>

/* 
    Sequential, Omp, f_Sequential ve f_Omp neredeyse aynı işlevleri gerçekleştirir.
    Burada önce aldığı dosyaların geçerliliği kontrol edilir. Farklı boyutlardaki veya
    matris boyutlarının çarpılamayacağı kuralı kontrol edilip bu duruma göre hata verilir
    veya devam edilir. Matris dosyaları structına gönderilerek verilerin m_1 ve m_2 matrisleri
    içerisinde aktarılır. Çarpımı sonucunda, sonucun aktarılacağı result_matrix için bellek
    alanlarının ayarlanmasının ardından seri/paralel işlemler gerçekleştirilerek matris
    çarpım işlemi gerçekleştirilir.
*/
int main(int argc, char **argv)
{
    // Yanlış parametre gönderilmesi sonucu program bu noktada sonlandırılır.
    if(argc != 3){
        printf("HATA: Sadece 2 adet dosya belirtin !\n");
        exit(EXIT_FAILURE);
    }
        
    // m_1 ve m_2 matrisleri dosyaların içerisinden okunmak için çağırılıyor.
    matrix_struct *m_1 = get_matrix_struct(argv[1]);
    matrix_struct *m_2 = get_matrix_struct(argv[2]);

    // Yanlış boyutlardaki matrislerin gönderilmesi sonucu program bu noktada sonlandırılır.
    if(m_1->cols != m_2->rows){
        printf("HATA: A matrisinin sütun sayısı B matrisinin satır sayısı ile aynı olmalıdır !\n");
        exit(EXIT_FAILURE);
    }

    
    // Sonuçların yazdırılacağı matris için bellek alanlarının ayarlanması için
    // öncelikle satır ve sütun sayıları ayarlanır, m_1 matrisinden satırlar
    // m_2 matrisinden de sütunlar alınarak matrisin boyutları belirlenir.
    // malloc() fonksiyonunda kullanılan parametre tahsis etmek istediğiniz 
    // belleğin byte olarak değerini gösterir. malloc() fonksiyonu tahsis edilmiş 
    // belleğin başlangıcını gösteren bir işaretçi geri verir. Tahsis edilmek istenen 
    // bellek ihtiyacını karşılayamadığında, NULL bir işaretçi geri verir.
    matrix_struct *result_matrix = malloc(sizeof(matrix_struct));
    result_matrix->rows = m_1->rows;
    result_matrix->cols = m_2->cols;

    // Bellek tahsislerinde calloc() fonksiyonu da kuallnılmasının sebebi, bu fonksiyonun 
    // malloc() fonksiyonundan farkı ayrılacak bellek miktarının eleman boyutu ve eleman 
    // sayısı olarak iki argüman halinde tanımlanmış olmasıdır.
    result_matrix->mat_data = calloc(result_matrix->rows, sizeof(double*)); 
    for(int i=0; i < result_matrix->rows; ++i)
        result_matrix->mat_data[i]=calloc(result_matrix->cols, sizeof(double));

    // Bu noktada seri/paralel matris çarpımı işlemi gerçekleştirilmektedir. Tüm sütun 
    // elemanları tüm satır elemanları birbirleriyle çarpılarak toplamları result_matrix
    // içerisindeki her bir hücreye yazılmaktadır.
    #pragma omp parallel for
    for (int i = 0; i < result_matrix->rows; i++) {
        for (int j = 0; j < result_matrix->cols; j++) {
            for (int k = 0; k < m_1->cols; k++) {
                result_matrix->mat_data[i][j] += m_1->mat_data[i][k] * m_2->mat_data[k][j];
            }
        }
    }
    
    // Projenin gerçeklemesinde, bash betikleri içerisinde çıktıların yönlendirmesi sebebi ile
    // bu matrislerin ekrana yazdırılmadığını görebilirsiniz, bu yüzden burada ekrana yazdırma
    // fonksiyonu header file header aracılığı ile tetiklendir.
    print_matrix(result_matrix);
    
    // Bu noktada tüm allocate edilen matris alanları boşaltılır ve program sonlandırılır.
    free_matrix(m_1);
    free_matrix(m_2);
    free_matrix(result_matrix);
    
    exit(EXIT_SUCCESS);
}
