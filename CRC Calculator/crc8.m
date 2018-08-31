//
//  crc8.m
//  CRC Calculator
//
//  Created by Romuald Dufaux on 31/08/18.
//  Copyright © 2018 dPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRC Calculator-Bridging-Header.h"

int mif_calc_crc(unsigned char mode, int len, unsigned char *in, unsigned char *out)
{
	int i, j, stat;
	unsigned int crc;
	
	stat = MI_CRC_ZERO;
	
	if (mode == CRC8)
	{
		*out = 0xC7; // bit-swapped 0xE3
		
		for (j = 0; j < len; j++)
		{
			*out = *out ^ in[j];
			
			for (i = 0; i < 8; i++)
			{
				if (*out & 0x80)
				{
					*out = (*out << 1) ^ 0x1D;
				}
				else
				{
					*out = *out << 1;
				}
			}
		}
		if (*out)
		{
			stat = MI_CRC_NOTZERO;
		}
	}
	else // CRC16
	{
		crc = 0xC78C; // bit-swapped 0x31E3
		
		for (j = 0; j < len; j++)
		{
			crc = crc ^ ((unsigned int)in[j] << 8);
			
			for (i = 0; i < 8; i++)
			{
				if (crc & 0x8000)
				{
					crc = (crc << 1) ^ 0x1021;
				}
				else
				{
					crc = crc << 1;
				}
			}
		}
		out[0] = (unsigned char)(crc >> 8);
		out[1] = (unsigned char)crc;
		
		if (crc)
		{
			stat = MI_CRC_NOTZERO;
		}
	}
	return (stat);
}
