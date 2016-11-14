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
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "data.h"
#include "io.h"

#define HUGE_LINE 10240

static int CountLines(FILE *);
static double MatchBqi(const sv_t*, const char*, const int);

/* Return the number of lines in the text stream given */
static int CountLines(FILE *fp)
{
    int lines = 0, ch;

    if (NULL == fp) {
        printf("Erroneous (NULL) fp passed. Returning...");
        return 0;
    }

    rewind(fp);
    while(0 == feof(fp)) {
        ch = fgetc(fp);
        if(ch == '\n') {
            lines++;
        }
    }
    rewind(fp);

    return (lines);
}

station_t *ReadStation(char *infile, int *pcls, int *prws)
{
    int i=0, j=0, k=0;
    int cls=0, rws=0;
    char line[HUGE_LINE];
    char *tokenPtr;
    FILE *fp;   
    station_t *stns;

    if ( (fp=fopen(infile,"r")) == NULL ) {
        printf("I/O Error:Cannot open file %s\n",infile);
        exit(-1);
    }

    rws = CountLines(fp)-1; /*total number of lines minus header */

    if ( NULL == fgets(line, sizeof(line), fp) ) {
        return NULL;
    };
    tokenPtr = strtok(line,",");

    cls=-1;
    while ( tokenPtr != NULL ) { 
        tokenPtr = strtok( NULL, "," );
        cls++;
    }

    stns = malloc(cls*sizeof(station_t));
    for (i=0; i<cls; i++) {
        stns[i].spcs = malloc(rws*sizeof(species_t));
    }

    rewind(fp);
    if ( NULL == fgets(line, sizeof(line), fp) ){
        return NULL;
    }
    tokenPtr = strtok(line,",");
    i=0;
    while ( tokenPtr != NULL ) { 
        tokenPtr = strtok( NULL, "," );
        if ( tokenPtr != NULL ) {
            stns[i].name = malloc(sizeof(char)*strlen(tokenPtr)+1);
            strncpy(stns[i].name, tokenPtr, sizeof(char)*strlen(tokenPtr) );
            i++;
        }
    }


    i=0;
    while(fgets(line, sizeof(line), fp)) {  
        tokenPtr = strtok(line,",");
        for (j=0; j<cls; j++) {
            stns[j].spcs[i].name = malloc(sizeof(char)*strlen(tokenPtr)+1);
            strncpy(stns[j].spcs[i].name, tokenPtr, sizeof(char)*strlen(tokenPtr) );
            stns[j].spcs[i].name[sizeof(char)*strlen(tokenPtr)] = '\0';
        }
        j=0;
        while ( tokenPtr != NULL ) {
            tokenPtr = strtok( NULL, "," );
            if ( tokenPtr != NULL ) {
                if ( *tokenPtr == ' ' ) {
                    stns[j].spcs[i].size=0;
                } else {
                    stns[j].spcs[i].size=atoi(tokenPtr);
                }
            }
            j++;
        }
        i++;
    }
    /* convert to lower case all the species names */
    for ( j=0 ; j < cls ; j++ ) {
            stns[j].bqiN = 0;
            stns[j].bentixN = 0;
            stns[j].ambiN = 0;
        for ( i=0 ; i < rws ; i++ ) {
            stns[j].spcs[i].bqi = 0.;
            stns[j].spcs[i].bentix = 0;
            stns[j].spcs[i].ambi = 0;
            for ( k=0 ; stns[j].spcs[i].name[k] ; k++ ) 
                stns[j].spcs[i].name[k] = tolower(stns[j].spcs[i].name[k]);
        }
    }

    *pcls = cls;
    *prws = rws;
    fclose(fp);
    return (stns);
}

static double MatchBqi(const sv_t* bqiDat, const char *name, const int bqiSize)
{
    int i = 0;
    size_t size;

    size = strlen(name);
    for ( i = 0 ; i < bqiSize ; i++ ) {
        if ( 0 == strncmp(bqiDat[i].name, name, size) ) {
            return bqiDat[i].value;
        }
    }
    return -1.;
}

int InitBqi(const char *bqiIn, const char* bqiOut, station_t *st, int nspecies, int nstations)
{
    int i = 0, j = 0, bqiSize = 0;
    char line[HUGE_LINE];
    double val;
    char *tokenPtr;
    FILE *fp;   
    sv_t *bqiDat;

    if ( NULL == (fp=fopen(bqiIn, "r")) ) {
        fprintf(stderr, "I/O Error:Cannot open file %s\n", bqiIn);
        return 1;
    }

    bqiSize = CountLines(fp)-1; /* total number of lines minus header */

    if( NULL == fgets(line, sizeof(line), fp) ) {
        fprintf(stderr, "I/O Error:Failed to allocate memory\n");
        return 1;
    }
    tokenPtr = strtok(line,",");

    bqiDat = malloc(bqiSize * sizeof(sv_t));
    if ( NULL == bqiDat ) {
        fprintf(stderr, "I/O Error:Failed to allocate memory\n");
        return 1;
    }

    rewind(fp);
    if ( NULL == fgets(line, sizeof(line), fp) ) {
        fprintf(stderr, "Error reading lines\n");
        return 1;
    }
    tokenPtr = strtok(line,",");

    i=0;
    while(fgets(line, sizeof(line), fp)) {  
        tokenPtr = strtok(line,",");
        bqiDat[i].name = malloc(sizeof(char)*strlen(tokenPtr)+1);
        strncpy(bqiDat[i].name, tokenPtr, sizeof(char)*strlen(tokenPtr) );
        bqiDat[i].name[sizeof(char)*strlen(tokenPtr)] = '\0';

        tokenPtr = strtok( NULL, "," );
        if ( NULL != tokenPtr ) {
            bqiDat[i].value = atof(tokenPtr);
        }
        i++;
    }

    for ( i = 0 ; i < bqiSize ; i++ )
        for ( j = 0 ; bqiDat[i].name[j] ; j++)
            bqiDat[i].name[j] = tolower(bqiDat[i].name[j]);

    fclose(fp); // Finished reading bqi data.

    /* Finished reading input BQI data, asign them to species */
    if ( NULL == (fp = fopen(bqiOut,"w") ) ) {
        fprintf(stderr, 
                " Error opening bqi output file ( %s ). Writing to stderr.\n", 
                bqiOut);
        fp = stderr;
    };

    for ( i = 0 ; i < nstations ; i++ ) {
        for ( j = 0 ; j < nspecies ; j++ ) {
            val = MatchBqi(bqiDat, st[i].spcs[j].name, bqiSize);
            if ( -1 == val ) {
                fprintf(fp, "%s\n", st[i].spcs[j].name);
                st[i].spcs[j].bqi = 0.;
                st[i].bqiN += st[i].spcs[j].size;
            } else {
                st[i].spcs[j].bqi = val;
            }
        }
        fprintf(fp, "\n");
    }
    fclose(fp); // close list of non matched bqi species

    /* Clean up */
    for ( i = 0 ; i < bqiSize ; i++ ) {
        free(bqiDat[i].name);
    }
    free(bqiDat);
    return 0;
}

void Write2csv(char *outfile, station_t *st, int cols)
{
    int i;
    FILE *fp;

    if ( (fp=fopen(outfile,"w")) == NULL ) {
        printf("I/O Error:Cannot open file %s\n", outfile);
      exit(EXIT_FAILURE);
   }
    
// XMacro trick used to avoid similar code repeated multiple times.
//   a is a string (field name)
//   b is the index being printed
//   c is the format specifier (eg %d)
#define OUTPUT(a,b,c) \
    do { \
        fprintf(fp, a); \
        for ( i = 0 ; i < cols-1 ; i++ ) \
            fprintf(fp,c",", st[i].b); \
       fprintf(fp,c"\n", st[cols-1].b); \
    } while(0);
    OUTPUT("\"Indices/Stations\",", name, "%s")
    OUTPUT("\"Benthic Quality Index (BQI)\",", bqi, "%.13f")
    OUTPUT("\"Benthic Quality Index (BQI) NonMatched percentage\",", bqiN/(double)(st[i].individuals) * 100., "%.13f")
#undef OUTPUT
}
