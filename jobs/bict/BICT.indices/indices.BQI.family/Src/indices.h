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
#ifndef INDICES_H
#define INDICES_H
void Individuals(station_t*, const int, const int);
void Richness(station_t*, const int, const int);
void Shannon(station_t*, const int, const int);
void Pielou(station_t*, const int);
void Mergalef(station_t*, const int);
void Rarefaction(station_t*, const int, const int);
void Bqi(station_t*, const int, const int);
void Bentix(station_t*, const int, const int);
void Ambi(station_t*, const int, const int);
#endif

