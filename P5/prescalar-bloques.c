#include "mpi.h"
#include <stdio.h>
#include "omp.h"

#define MAXV 10000

int main(int argc, char *argv[]) {

  int idproc, numprocs;
  double a[MAXV], b[MAXV],      /* vectores operando */
      prod,                     /* producto escalar */
      datoa[MAXV], datob[MAXV], /* datos recibidos en cada proc */
      dato;                     /* producto enviado al 0 */
  int vsize,                    /* tam vectores */
      cadaproc,                 /* lo que le toca a cada proc */
      resto,                    /* el resto lo hará el cero */
      i, j, k;
  MPI_Status status;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &idproc);
  MPI_Comm_size(MPI_COMM_WORLD, &numprocs);

  if (idproc == 0) {
    printf("Tam. vectores (menor que %d):", MAXV);
    scanf("%d", &vsize);
    printf("\nGenerando datos...\n");
    for (i = 0; i < vsize; i++) {
      a[i] = (double)i;
      b[i] = (double)i;
    }
    cadaproc = vsize / (numprocs - 1);
    resto = vsize % (numprocs - 1);

    k = 0;
    for (i = 1; i < numprocs; i++) {
      /* Enviamos a cada procesador cuantos datos le tocan */
      MPI_Send(&cadaproc, 1, MPI_INT, i, 0, MPI_COMM_WORLD);
      printf("Send: src %d dst %d dato %d\n", idproc, i, cadaproc);
      /* Enviamos a cada procesador los datos que le tocan */
      MPI_Send(&a[k], cadaproc, MPI_DOUBLE, i, 1, MPI_COMM_WORLD);
      MPI_Send(&b[k], cadaproc, MPI_DOUBLE, i, 2, MPI_COMM_WORLD);
      printf("Send: src %d dst %d dato %f\n", idproc, i, a[k]);
      printf("Send: src %d dst %d dato %f\n", idproc, i, b[k]);
      k = k + cadaproc;
    }

    /* el resto lo hace el cero */
    prod = 0;
    // #pragma omp parallel for reduction(+:prod) private(k)
    // for (j = 0; j < resto; j++) {
    //   prod = prod + (a[k] * b[k]);
    //   k++;
    // } // k += 1

    #pragma omp parallel for reduction(+:prod)
    for (j = k; j < resto; j++) {
      prod = prod + (a[j] * b[j]);
    } // k += 1
    k = j;
    
    for (i = 1; i < numprocs; i++) {
      /* Recibimos de cada procesador su resultado */
      MPI_Recv(&dato, 1, MPI_DOUBLE, i, 3, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      printf("Recv: dst %d src %d numfila %f\n", idproc, status.MPI_SOURCE,
             dato);
      prod = prod + dato;
    }
    printf("El producto escalar es %f\n", prod);
  } else {
    /* Recibimos cuantos datos nos tocan                           */
    MPI_Recv(&cadaproc, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, &status);
    printf("Recv: dst %d src %d numfila %d\n", idproc, status.MPI_SOURCE,
           cadaproc);
    prod = 0;
    /* Recibimos cada elemento del vector que nos toca, multiplicamos y
     * acumulamos */
    MPI_Recv(datoa, cadaproc, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD,
             MPI_STATUS_IGNORE);
    MPI_Recv(datob, cadaproc, MPI_DOUBLE, 0, 2, MPI_COMM_WORLD,
             MPI_STATUS_IGNORE);

    printf("Recv: dst %d src %d numfila\n", idproc, status.MPI_SOURCE);
    #pragma omp parallel for reduction(+:prod)
    for (j = 0; j < cadaproc; j++) {
      prod = prod + (datoa[j] * datob[j]);
    }

    MPI_Send(&prod, 1, MPI_DOUBLE, 0, 3, MPI_COMM_WORLD);
    printf("Send: src %d dst %d dato %f\n", idproc, 0, prod);
  }

  MPI_Finalize();
  return 0;
}
