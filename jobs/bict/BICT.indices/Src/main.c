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
#include <getopt.h>
#include "data.h"
#include "indices.h"
#include "io.h"

void usage(void);

char infileDefault[] = "Input/raw.data.csv";
char outfileDefault[] = "Output/output.csv";
char bqiInDefault[] = "Input/bqi.csv";
char bqiFamInDefault[] = "Input/bqi.family.csv";
char bentixInDefault[] = "Input/bentix.csv";
char ambiInDefault[] = "Input/ambi.csv";

void usage(void)
{
    fprintf(stdout, "usage: ./input -i or --input [INPUT_FILE_NAME.csv] [other options].");
    fprintf(stdout, " Available options are:\n");
    fprintf(stdout, "\t\t-o,--output[=OUTPUT_CSV_FILENAME.csv]\n");
    fprintf(stdout, "\t\t-b,--bqi[=BQI_INPUT_FILE_NAME.csv]\n");
    fprintf(stdout, "\t\t-f,--bqifam[=BQI_FAMILY_INPUT_NAME.csv]\n");
    fprintf(stdout, "\t\t-x,--bentix[=BENTIX_INPUT_NAME.csv]\n");
    fprintf(stdout, "\t\t-a,--ambi[=AMBI_FAMILY_NAME.csv]\n");
    fprintf(stdout, "\t\t-h,--help: print this info");
    fprintf(stdout, "\nBy default this code will compute the richness, individuals, shannon,");
    fprintf(stdout, "\npielou, and margalef indices using a sample input file");
    fprintf(stdout, "\nBQI or BQI family, AMBI and BENTIX indices may also be computed if enabled");
    fprintf(stdout, "\nand will use the configuration files provided. The user may provide");
    fprintf(stdout, "\nalternative files as desired, eg custom BQI/bentix/ambi configuration files.");
    fprintf(stdout, "\nPlease take care to request something reasonable, specifically do not");
    fprintf(stdout, "\nrequest both BQI and BQI family\n");
}

int main (int argc, char **argv)
{
    int nstations, nspecies, i, opt=0, optIndex=0;
    char *infile, *outfile;
    char *bqiIn, *bentixIn, *ambiIn;
    const char bqiOut[] = "Output/bqi.NonMatched.txt";
    const char bentixOut[] = "Output/bentix.NonMatched.txt";
    const char ambiOut[] = "Output/ambi.NonMatched.txt";
    station_t *st = NULL;
    config conf={0, 0, 0, 0, 0};
    
    static struct option optOptions[] = {
        {"input",  required_argument, 0, 'i' },
        {"output", optional_argument, 0, 'o' },
        {"bqi",    optional_argument, 0, 'b' },
        {"bqifam", optional_argument, 0, 'f' },
        {"bentix", optional_argument, 0, 'x' },
        {"ambi",   optional_argument, 0, 'a' },
        {"help",   no_argument,       0, 'h' },
        {0,        0, 0, 0 }
    };


    infile = infileDefault;
    outfile = outfileDefault;
    bqiIn = bqiInDefault;
    bentixIn = bentixInDefault;
    ambiIn = ambiInDefault;
    while (  -1 
           != (opt = getopt_long(argc, 
                                 argv, 
                                 "i::o::b::f::x::a::h",
                                 optOptions, 
                                 &optIndex) )           ) {
        switch (opt) {
            case 'i':
                infile = optarg;
            break;
            case 'o':
                if ( optarg )
                    outfile = optarg;
                else
                    outfile = outfileDefault;
                conf.out = 1;
            break;
            case 'b':
                if ( conf.bqiFam ) {
                    usage();
                    return EXIT_SUCCESS;
                }
                if ( optarg )
                    bqiIn = optarg;
                else
                    bqiIn = bqiInDefault;
                conf.bqi = 1;
            break;
            case 'f':
                if ( conf.bqi ) {
                    usage();
                    return EXIT_SUCCESS;
                }
                if ( optarg )
                    bqiIn = optarg;
                else
                    bqiIn = bqiFamInDefault;
                conf.bqiFam = 1;
            break;
            case 'x':
                if ( optarg )
                    bentixIn = optarg;
                else
                    bentixIn = bentixInDefault;
                conf.bentix = 1;
            break;
            case 'a':
                if ( optarg )
                    ambiIn = optarg;
                else
                    ambiIn = ambiInDefault;
                conf.ambi = 1;
            break;
            case 'h':
                usage();
                return EXIT_SUCCESS;
            default :
                fprintf(stderr, "Unknown argument passed. Exiting.\n");
            break;
        }
    }

    st = ReadStation(infile, &nstations, &nspecies);
    if ( NULL == st ) {
        fprintf(stderr, "No stations were read\n");
        return EXIT_FAILURE;
    }
    
    Individuals(st, nspecies, nstations);
    Richness(st, nspecies, nstations);
    Shannon(st, nspecies, nstations);
    Pielou(st, nstations);
    Mergalef(st, nstations);
    Rarefaction(st, nspecies, nstations);

    if ( conf.bqi || conf.bqiFam ) {
        if ( InitBqi(bqiIn, bqiOut, st, nspecies, nstations) ) {
            fprintf(stderr, "\t Error reading bqi input.\n");
            return EXIT_FAILURE;
        };
        Bqi(st, nspecies, nstations);
    }
    if ( conf.bentix ) {
        if ( InitBentix(bentixIn, bentixOut, st, nspecies, nstations) ) {
            fprintf(stderr, "\t Error reading bentix input.\n");
            return EXIT_FAILURE;
        };
        Bentix(st, nspecies, nstations);
    }
    if ( conf.ambi ) {
        if ( InitAmbi(ambiIn, ambiOut, st, nspecies, nstations) ) {
            fprintf(stderr, "\t Error reading ambi input.\n");
            return EXIT_FAILURE;
        };
        Ambi(st, nspecies, nstations);
    }

    for (i = 0; i < nstations; i++) {
        fprintf(stdout, "id: %d Station: %s\n", i, st[i].name);
        fprintf(stdout, "Number of Individuals (N): %d\n", st[i].individuals);
        fprintf(stdout, "Species Richness Index(S): %d\n", st[i].richness);
        fprintf(stdout, "Shannon Index(ln based) (H): %lf\n", st[i].shannonLn);
        fprintf(stdout, "Shannon Index(log10 based) (H): %lf\n", st[i].shannonLog);
        fprintf(stdout, "Shannon Index(log2 based) (H): %lf\n", st[i].shannonLog2);
        fprintf(stdout, "Pielou Species Evenness Index(J): %lf\n", st[i].pielou);
        fprintf(stdout, "Mergalef Diversity Index (d): %lf\n", st[i].mergalef);
        fprintf(stdout, "Rarefaction Index: %lf\n", st[i].rarefaction);
        if ( conf.bqi ) {
            fprintf(stdout, "Benthic Quality Index (BQI): %lf, NonMatched: %i (%2.4f %%). \n", 
                    st[i].bqi,
                    st[i].bqiN,
                    (double)(st[i].bqiN)/st[i].individuals * 100. );
        } else if ( conf.bqiFam ) {
            fprintf(stdout, "Benthic Family Quality Index (BQI): %lf, NonMatched: %i (%2.4f %%). \n", 
                    st[i].bqi,
                    st[i].bqiN,
                    (double)(st[i].bqiN)/st[i].individuals * 100. );
        }
        if ( conf.bentix ) {
            fprintf(stdout, "Bentix Index: %lf, NonMatched: %i (%2.4f %%). \n", 
                    st[i].bentix,
                    st[i].bentixN,
                    (double)(st[i].bentixN)/st[i].individuals * 100. );
        }
        if ( conf.ambi ) {
            fprintf(stdout, "AMBI Index: %lf, NonMatched: %i (%2.4f %%). \n", 
                    st[i].ambi,
                    st[i].ambiN,
                    (double)(st[i].ambiN)/st[i].individuals * 100. );
        }
        fprintf(stdout, "\n");
    }

    if ( conf.out ) {
        fprintf(stdout, "\nOutput file: %s\n", outfile);
        Write2csv(outfile, st, nstations, conf);
    }
    
    return (EXIT_SUCCESS);
}

