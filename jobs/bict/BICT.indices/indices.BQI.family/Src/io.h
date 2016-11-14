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
#ifndef IO_H
#define IO_H
station_t* ReadStation(char *, int *, int *);
int InitBqi(const char *, const char*, station_t *,int, int);
int InitBentix(const char*, const char*, station_t *,int, int);
int InitAmbi(const char *, const char*, station_t *,int, int);
void Write2csv(char *, station_t *, int);
#endif

