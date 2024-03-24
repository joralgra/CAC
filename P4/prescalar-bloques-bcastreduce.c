#include "mpi.h"
#include <stdio.h>

#define MAXV 10000

int main(int argc, char *argv[]) {
  int idproc, numprocs;
  double a[MAXV], b[MAXV],      /* vectores operando */
      prod_local,               /* producto escalar local */
      prod_total;               /* producto escalar total */
  int vsize,                    /* tam vectores */
      cadaproc,                 /* lo que le toca a cada proc */
      i, j;
  MPI_Status status;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &idproc);
  MPI_Comm_size(MPI_COMM_WORLD, &numprocs);

  if (idproc == 0) {
    printf("Tam. vectores (menor que %d): ", MAXV);
    scanf("%d", &vsize);
    printf("\nGenerando datos...\n");
    for (i = 0; i < vsize; i++) {
      a[i] = (double)i;
      b[i] = (double)i;
    }
  }

  // Difusión del tamaño del vector a todos los procesos
  MPI_Bcast(&vsize, 1, MPI_INT, 0, MPI_COMM_WORLD);

  // Asegúrate de que todos los procesos tengan el tamaño antes de continuar
  MPI_Barrier(MPI_COMM_WORLD);

  if (vsize > MAXV) vsize = MAXV; // Asegurar que no exceda el máximo

  cadaproc = vsize / numprocs; // Dividir el trabajo equitativamente
  int inicio = idproc * cadaproc;
  int fin = (idproc + 1) * cadaproc;
  if (idproc == numprocs - 1) fin = vsize; // El último toma el resto

  // El proceso raíz ya tiene los vectores, los distribuye si es necesario
  if (idproc == 0) {
    for (i = 1; i < numprocs; i++) {
      inicio = i * cadaproc;
      fin = (i + 1) * cadaproc;
      if (i == numprocs - 1) fin = vsize;
      MPI_Send(&a[inicio], fin-inicio, MPI_DOUBLE, i, 0, MPI_COMM_WORLD);
      MPI_Send(&b[inicio], fin-inicio, MPI_DOUBLE, i, 1, MPI_COMM_WORLD);
    }
  } else {
    MPI_Recv(a, fin-inicio, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    MPI_Recv(b, fin-inicio, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
  }

  // Calcula el producto escalar local
  prod_local = 0;
  for (i = 0; i < fin-inicio; i++) {
    prod_local += a[i] * b[i];
  }

  // Reduce todos los productos escalares locales al total en el proceso raíz
  MPI_Reduce(&prod_local, &prod_total, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

  // Imprimir el resultado en el proceso raíz
  if (idproc == 0) {
    printf("El producto escalar es %f\n", prod_total);
  }

  MPI_Finalize();
  return 0;
}
