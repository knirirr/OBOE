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
#ifndef DATA_H
#define DATA_H
/** species data type */
typedef struct species {
    char *name;
    int size, bentix, ambi;
    double bqi;
} species_t;

/** station data type */
typedef struct station {
    int richness, individuals;
    int bqiN, bentixN, ambiN;
    double shannonLn, shannonLog, shannonLog2;
    double pielou, mergalef, rarefaction;
    double bqi, bentix, ambi;
    char *name;
    species_t *spcs;
} station_t;

/** sensitivity value data type */
typedef struct sv {
    char *name;
    double value;
} sv_t;

/** bentix value data type */
typedef struct bentix {
    char *name;
    int group;
} bentix_t;

/** ambi value data type */
typedef struct ambi {
    char *name;
    int group;
} ambi_t;

typedef struct config{
    int bqi;
    int bqiFam;
    int bentix;
    int ambi;
    int out;
} config;
#endif
