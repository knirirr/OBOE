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
#include <math.h>
#include <gmp.h>
#include "data.h"
#include "indices.h"

#define TOLERANCE 1e-9

static void esNum(station_t*, const int, const int, int);

/** This function computes the total number of individuals
 *  per given station (Species Richness (S) function). 
 *  
 *  @param[inout]  st          struct with all stations' data
 *  @param[in]     nspecies    # of species
 *  @param[in]     nstations   # of stations        
 */
void Richness(station_t* st, 
              const int nspecies, 
              const int nstations)
{
    int i, j, cnt;

    for ( j = 0 ; j < nstations ; j++ ) {
        cnt = 0;
        for (i=0; i<nspecies; i++) {
            if ( st[j].spcs[i].size != 0 ) {
                cnt++;
            }
        }
       st[j].richness = cnt;
    }
}

/** This function computes the number of individual species (N) 
 *  per given station.
 *  
 *  @param[inout]  st          struct with all stations' data 
 *  @param[in]     nspecies    # of species
 *  @param[in]     nstations   # of stations        
 */
void Individuals(station_t* st, 
                 const int nspecies, 
                 const int nstations)
{
    int i, j, sum;

    for ( j = 0 ; j < nstations ; j++ ) {
        sum=0;
        for ( i = 0 ; i < nspecies ; i++ ) {
            if ( st[j].spcs[i].size != 0 ) {
                sum += st[j].spcs[i].size;
            }
        }
        st[j].individuals = sum;
    }
}

/** This function computes the Shannon's diversity index
 *  per given station using ln, log10 and log2
 *  
 *  @param[inout]  st          struct with all stations' data
 *  @param[in]     nspecies    # of species
 *  @param[in]     nstations   # of stations        
 */
void Shannon(station_t* st,
             const int nspecies,
             const int nstations)
{
    int i, j, N;
    double Hln, Hlog, Hlog2;

    for ( j = 0 ; j < nstations ; j++ ) {
        N = st[j].individuals;
        if ( 0 == N ) {
            continue;
        }
        Hln = 0.0;
        Hlog = 0.0;
        Hlog2 = 0.0;

        for ( i = 0 ; i < nspecies ; i++ ) {
            if ( st[j].spcs[i].size != 0 ) {
                double indRatio =  (double)st[j].spcs[i].size / N ;
                Hln = Hln + indRatio * log( indRatio );
                Hlog = Hlog + indRatio * log10( indRatio );
                Hlog2 = Hlog2 + indRatio * log2( indRatio );
            }
        }
        st[j].shannonLn = -Hln;
        st[j].shannonLog = -Hlog;
        st[j].shannonLog2 = -Hlog2;
    }
} 
    
/** This function computes the Pielou species evenness function
 *  per given station 
 *  
 *  @param[inout]  st          struct with all stations' data
 *  @param[in]     nstations   # of stations        
 */
void Pielou(station_t* st,
            const int nstations)
{
    int i;
    double H, Hmax;

    for ( i = 0 ; i < nstations ; i++ ) {
        H =  st[i].shannonLog2;
        Hmax = log(st[i].richness);
        if ( Hmax < TOLERANCE ) {
            st[i].pielou = 0.0;
        }   else {
            st[i].pielou = H/Hmax;
        }
    }
}

/** This function computes the Mergalef's diversity index (d)
 *  per given station 
 *  
 *  @param[inout]  st          struct with all stations' data
 *  @param[in]     nstations   # of stations
 */
void Mergalef(station_t* st,
              const int nstations)
{
    int i;

    for ( i = 0 ; i < nstations ; i++) {
        st[i].mergalef = (double)(st[i].richness-1) / log( (double)st[i].individuals );
    }
}

/** This one calculates the following fraction: 
 *     N-Ni choose constant / N choose constant
 *     
 *  It does a few less multiplications based on this:
 *      (N-Ni)! (N-50)!        / (N-Ni-50)! N!
 *    = (N-Ni-50+1) ... (N-Ni) / (N-50+1) ... N 
 *    
 *  and uses the GNU multiple precission arithmetic library
 */
static double fraction(int N, int Ni, int constant)
{
    int nom, denom;
    double result;
    mpz_t mul1, tmp1, mul2, tmp2, unity;
    mpf_t nomMPF, denomMPF;

    mpz_init(mul1);
    mpz_init(tmp1);
    mpz_init(mul2);
    mpz_init(tmp2);
    mpz_init(unity);

    mpf_init(nomMPF);
    mpf_init(denomMPF);
  
    mpz_set_si(unity, 1);
    
    mpz_set(mul1, unity);
    nom = N - Ni - constant + 1 ;
    mpz_set_si(tmp1, nom);
    while( nom <= (N-Ni) ) {
        mpz_mul(mul1, mul1, tmp1);
        mpz_add(tmp1, tmp1, unity);
        ++nom;
    }

    mpz_set(mul2, unity);
    denom = N - constant + 1;
    mpz_set_si(tmp2, denom);
    while( denom <= N ) {
        mpz_mul(mul2, mul2, tmp2);
        mpz_add(tmp2, tmp2, unity);
        ++denom;
    }

    mpf_set_z(nomMPF, mul1);
    mpf_set_z(denomMPF, mul2);
    mpf_div(nomMPF, nomMPF, denomMPF);
    result = mpf_get_d(nomMPF);

    mpf_init(denomMPF);
    mpf_init(nomMPF);

    mpz_init(unity);
    
    mpz_init(tmp2);
    mpz_init(mul2);
    mpz_init(tmp1);
    mpz_init(mul1);
    
    return result;
}

static void esNum(station_t* st,
				  const int nsp,
				  const int nst,
				  int num)
{
	int i, j, N, Ni;
    double sum;

	for ( i = 0 ; i < nst ; i++ ) {
		N = st[i].individuals;

        if ( num > N ) { // Can not compute ES50 for less than 50 individuals.
            st[i].rarefaction = 0;
            continue;
        }
        
        sum = 0.;
		for ( j = 0 ; j < nsp ; j++ ) {
			Ni = st[i].spcs[j].size ;
            sum = sum + (1. - fraction(N, Ni, 50) );
        }
		st[i].rarefaction = sum;
    }
}

/** This function computes the Rarefaction incex per given station 
 * 
 * @param[inout]  st          struct with all stations' data
 * @param[in]     nspecies    # of species
 * @param[in]     nstations   # of stations
*/
void Rarefaction(station_t* st,
				 const int nspecies,
				 const int nstations)
{
	esNum(st, nspecies, nstations, 50);
}

/** This function computes the Benthic Quality Index (BQI)
 * function, species level per given station 
 * 
 * @param[inout]  st          struct with all stations' data
 * @param[in]     nspecies    # of species
 * @param[in]     nstations   # of stations
 */
void Bqi(station_t* st, 
         const int nspecies,
         const int nstations)
{
    int i, j, alphaTot;
    double val;
    
    for ( i = 0 ; i < nstations ; i++ ) {
        val = 0.;
        alphaTot = 0;

        /* Start calculating the A_i * ES50_005i part of the summation
         * and the alpha total value */
        for ( j = 0 ; j < nspecies ; j++ ) {
            val += (st[i].spcs[j].bqi * st[i].spcs[j].size);
            alphaTot += ((st[i].spcs[j].bqi != 0.)? st[i].spcs[j].size : 0);
        }
        
        val = val
              * log10(st[i].richness + 1.) 
              * st[i].individuals
              / ((st[i].individuals+5.) * alphaTot);

        st[i].bqi = val;
    }
}

/** This function computes the Bentix Index per given station 
 * 
 * @param[inout]  st          struct with all stations' data
 * @param[in]     nspecies    # of species
 * @param[in]     nstations   # of stations
 */
void Bentix(station_t* st, 
            const int nspecies,
            const int nstations)
{
    int i, j, g1, g2, g3;
    
    for ( i = 0 ; i < nstations ; i++ ) {
        g1 = 0;
        g2 = 0;
        g3 = 0;

        for ( j = 0 ; j < nspecies ; j++ ) {
            switch (st[i].spcs[j].bentix) {
            case 1:
                g1 += st[i].spcs[j].size;
                break;
            case 2:
                g2 += st[i].spcs[j].size;
                break;
            case 3:
                g3 += st[i].spcs[j].size;
                break;
            }
        }

        st[i].bentix = (6 * g1 + 2 * (g2+g3) ) / (double)st[i].individuals;
    }
}

/** This function computes the AMBI Index per given station 
 * 
 * @param[inout]  st          struct with all stations' data
 * @param[in]     nspecies    # of species
 * @param[in]     nstations   # of stations
 */
void Ambi(station_t* st, 
          const int nspecies,
          const int nstations)
{
    int i, j, g2, g3, g4, g5;

    for ( i = 0 ; i < nstations ; i++ ) {
        g2 = 0;
        g3 = 0;
        g4 = 0;
        g5 = 0;

        for ( j = 0 ; j < nspecies ; j++ ) {
            switch (st[i].spcs[j].bentix) {
            case 2:
                g2 += st[i].spcs[j].size;
                break;
            case 3:
                g3 += st[i].spcs[j].size;
                break;
            case 4:
                g4 += st[i].spcs[j].size;
                break;
            case 5:
                g5 += st[i].spcs[j].size;
                break;
            }
        }

        st[i].ambi = (1.5 * g2 + 3. * g3 + 4.5 * g4 + 6. *g5 ) / (double)st[i].individuals;
    }
}
