CC=gcc
CFLAGS= -Wall -std=gnu99 -g -fopenmp
LIBS=src/matrix.c
LIBS_F=src/f_matrix.c
TUNE= -O2

all: sequential omp f_sequential f_omp

sequential:
		$(CC) $(TUNE) $(CFLAGS) -o bin/seq $(LIBS) src/sequential.c

omp:
		$(CC) $(TUNE) $(CFLAGS) -o bin/omp $(LIBS) src/omp.c

f_sequential:
		$(CC) $(TUNE) $(CFLAGS) -o bin/f_seq $(LIBS_F) src/f_sequential.c

f_omp:
		$(CC) $(TUNE) $(CFLAGS) -o bin/f_omp $(LIBS_F) src/f_omp.c
