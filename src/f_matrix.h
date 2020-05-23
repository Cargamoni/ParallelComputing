/* 	
	Dosyadan okunan matrislerin tutulacağı bir struck yapısı oluşturulmuştur.
	Bu header file içerisinde üç adet fonksiyon tanımlaması yapılmıştır ve
	kullanıma hazırlanadak bu header matrix.c içerisinden çağırılır. Her bir 
	matris dosytası belleğin farklı bölümleri üzerinden erişim yapılacağından 
	struct kullanılmıştır.

	Rows yüklenen matris verisinin satır sayısını, Cols sütun sayısını ve 
	double/float olarak tanımlanan pointer ise okunan datanın başlangıç adresini
	ifade eder.	
*/
typedef struct {
        unsigned int rows;
        unsigned int cols;
        float **mat_data;
} matrix_struct;

matrix_struct *get_matrix_struct(char matrix[]);
void print_matrix(matrix_struct *matrix_to_print);
void free_matrix(matrix_struct *matrix_to_free);

