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
    const char bqiIn[] = "Input/bqi.csv";
    const char bentixIn[] = "Input/bentix.csv";
    const char ambiIn[] = "Input/ambi.csv";
    const char bqiOut[] = "Output/bqiNonMatched.txt";
    const char bentixOut[] = "Output/bentixNonMatched.txt";
    const char ambiOut[] = "Output/ambiNonMatched.txt";
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

    if ( InitBqi(bqiIn, bqiOut, st, nspecies, nstations)) {
        fprintf(stderr, "\t Error reading bqi input.\n");
        return EXIT_FAILURE;
    };
    if ( InitBentix(bentixIn, bentixOut, st, nspecies, nstations) ) {
        fprintf(stderr, "\t Error reading bentix input.\n");
        return EXIT_FAILURE;
    };
    if ( InitAmbi(ambiIn, ambiOut, st, nspecies, nstations) ) {
        fprintf(stderr, "\t Error reading ambi input.\n");
        return EXIT_FAILURE;
    };

    Individuals(st, nspecies, nstations);
    Richness(st, nspecies, nstations);
    Shannon(st, nspecies, nstations);
    Pielou(st, nstations);
    Mergalef(st, nstations);
    Bqi(st, nspecies, nstations);
    Bentix(st, nspecies, nstations);
    Ambi(st, nspecies, nstations);

    for (i = 0; i < nstations; i++) {
        printf ("id: %d Station: %s\n", i, st[i].name);
        printf ("Number of Individuals (N): %d\n", st[i].individuals);
        printf ("Species Richness Index(S): %d\n", st[i].richness);
        printf ("Shannon Index(ln based) (H): %lf\n", st[i].shannonLn);
        printf ("Shannon Index(log10 based) (H): %lf\n", st[i].shannonLog);
        printf ("Shannon Index(log2 based) (H): %lf\n", st[i].shannonLog2);
        printf ("Pielou Species Evenness Index(J): %lf\n", st[i].pielou);
        printf ("Mergalef Diversity Index (d): %lf\n", st[i].mergalef);
        printf ("Benthic Quality Index (BQI): %lf, NonMatched: %i (%2.4f %%). \n", 
                st[i].bqi,
                st[i].bqiN,
                (double)(st[i].bqiN)/st[i].individuals * 100. );
        printf ("Bentix Index: %lf, NonMatched: %i (%2.4f %%). \n", 
                st[i].bentix,
                st[i].bentixN,
                (double)(st[i].bentixN)/st[i].individuals * 100. );
        printf ("AMBI Index: %lf, NonMatched: %i (%2.4f %%). \n", 
                st[i].ambi,
                st[i].ambiN,
                (double)(st[i].ambiN)/st[i].individuals * 100. );
        printf ("\n");
    }
    if (argc > 2) {
        Write2csv(argv[2], st, nstations);
        printf ("\nOutput file: %s\n", argv[2]);
    }

    return (EXIT_SUCCESS);
}

