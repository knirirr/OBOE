/*******************************************************************************
 *    Institute of Marine Biology and Genetics, 
 *    Hellenic Centre for Marine Research, 
 *    PO Box 2214, 
 *    Iraklion, 
 *    71003 Crete, 
 *    Greece
 *******************************************************************************
 *    Panagiotis Vavilis: pvavilis@her.hcmr.gr
 *    Nikolas Patttakos: pattakosn@her.hcmr.gr
 ******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "indices.h"
#include "io.h"

int main (int argc, char **argv)
{
    int i;
    int nstations, nspecies;
    const char bqiFamIn[] = "Input/bqi.family.csv";
    const char bqiFamOut[] = "Output/bqiFamNonMatched.txt";
    station_t *st = NULL;

    if (argc < 2) {
        printf ("usage: indices INPUT_CSV_FILE [ OUTPUT_CSV_FILENAME ] \n");
        return (EXIT_FAILURE);
    }

    st = ReadStation(argv[1], &nstations, &nspecies);
    if ( NULL == st ) {
        fprintf(stderr, "No stations were read\n");
        return EXIT_FAILURE;
    }

    if ( InitBqi(bqiFamIn, bqiFamOut, st, nspecies, nstations)) {
        fprintf(stderr, "\t Error reading BQI family input.\n");
        return EXIT_FAILURE;
    };

    Bqi(st, nspecies, nstations);

    for (i = 0; i < nstations; i++) {
        printf ("id: %d Station: %s\n", i, st[i].name);
        printf ("Benthic Quality Index (BQI): %lf, NonMatched: %i (%2.4f %%). \n", 
                st[i].bqi,
                st[i].bqiN,
                (double)(st[i].bqiN)/st[i].individuals * 100. );
        printf ("\n");
    }
    if (argc > 2) {
        Write2csv(argv[2], st, nstations);
        printf ("\nOutput file: %s\n", argv[2]);
    }

    return (EXIT_SUCCESS);
}

