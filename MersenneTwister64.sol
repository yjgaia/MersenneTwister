pragma solidity ^0.4.24;

// Mersenne Twister 알고리즘 구현 (64Bit Integer용)
// https://github.com/Hanul/MersenneTwister
contract MersenneTwister64 {
	
	uint64 constant private W = 64;
	uint64 constant private N = 312;
	uint64 constant private M = 156;
	uint64 constant private R = 31;
	
	uint64 constant private A = 0xB5026F5AA96619E9;
	
	uint64 constant private U = 29;
	uint64 constant private D = 0x5555555555555555;
	
	uint64 constant private S = 17;
	uint64 constant private B = 0x71D67FFFEDA60000;
	
	uint64 constant private T = 37;
	uint64 constant private C = 0xFFF7EEE000000000;
	
	uint64 constant private L = 43;
	
	uint64 constant private F = 6364136223846793005;
	
	uint64 constant private LOWER_MASK = 0x7FFFFFFF;
	uint64 constant private UPPER_MASK = 0xFFFFFFFF80000000;
	
	uint64[] private mt = new uint64[](N);
	uint64 private index = N + 1;
	
	uint64 public extractedNumber;
	
	function seedMT(uint64 seed) payable public {
		
		// seed는 한번만 설정 가능
		require(index == N + 1);
		
		index = N;
		mt[0] = seed;
		
		for (uint64 i = 1; i < N; i += 1) {
			mt[i] = F * (mt[i - 1] ^ (mt[i - 1] >> (W - 2))) + i;
		}
	}
	
	function extractNumber() payable public {
		
		if (index >= N) {
			require(index == N);
			
			// twist
			for (uint64 i = 0; i < N; i += 1) {
				uint64 x = (mt[i] & UPPER_MASK) + (mt[(i + 1) % N] & LOWER_MASK);
				uint64 xA = x >> 1;
				
				if ((x % 2) != 0) {
					xA = xA ^ A;
				}
				
				mt[i] = mt[(i + M) % N] ^ xA;
			}
			
			index = 0;
		}
		
		uint64 y = mt[index];
		y = y ^ ((y >> U) & D);
		y = y ^ ((y << S) & B);
		y = y ^ ((y << T) & C);
		y = y ^ (y >> L);
		
		index += 1;
		
		extractedNumber = y;
	}
}