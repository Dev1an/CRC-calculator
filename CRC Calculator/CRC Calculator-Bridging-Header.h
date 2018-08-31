//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#define CRC8 1
#define MI_CRC_ZERO		2
#define MI_CRC_NOTZERO	3

int mif_calc_crc(unsigned char mode, int len, unsigned char *in, unsigned char *out);
