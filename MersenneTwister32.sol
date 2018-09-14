pragma solidity ^0.4.24;

// Mersenne Twister 알고리즘 구현 (32Bit Integer용)
// https://github.com/Hanul/MersenneTwister
contract MersenneTwister32 {
	
	uint32 constant private W = 32;
	uint32 constant private N = 624;
	uint32 constant private M = 397;
	uint32 constant private R = 31;
	
	uint32 constant private A = 0x9908B0DF;
	
	uint32 constant private U = 11;
	uint32 constant private D = 0xFFFFFFFF;
	
	uint32 constant private S = 7;
	uint32 constant private B = 0x9D2C5680;
	
	uint32 constant private T = 15;
	uint32 constant private C = 0xEFC60000;
	
	uint32 constant private L = 18;
	
	uint32 constant private F = 1812433253;
	
	uint32 constant private LOWER_MASK = 0x7FFFFFFF;
	uint32 constant private UPPER_MASK = 0x80000000;
	
	uint32[] private mt = new uint32[](N);
	uint32 private index = N + 1;
	
	uint32 public extractedNumber;
	
	function seedMT(uint32 seed) payable public {
		
		// seed는 한번만 설정 가능
		require(index == N + 1);
		
		index = N;
		mt[0] = seed;
		
		for (uint32 i = 1; i < N; i += 1) {
			mt[i] = F * (mt[i - 1] ^ (mt[i - 1] >> (W - 2))) + i;
		}
	}
	
	function extractNumber() payable public {
		
		if (index >= N) {
			require(index == N);
			
			// twist
			for (uint32 i = 0; i < N; i += 1) {
				uint32 x = (mt[i] & UPPER_MASK) + (mt[(i + 1) % N] & LOWER_MASK);
				uint32 xA = x >> 1;
				
				if ((x % 2) != 0) {
					xA = xA ^ A;
				}
				
				mt[i] = mt[(i + M) % N] ^ xA;
			}
			
			index = 0;
		}
		
		uint32 y = mt[index];
		y = y ^ ((y >> U) & D);
		y = y ^ ((y << S) & B);
		y = y ^ ((y << T) & C);
		y = y ^ (y >> L);
		
		index += 1;
		
		extractedNumber = y;
	}
}