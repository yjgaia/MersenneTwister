"use strict";

const W = 32;
const N = 624;
const M = 397;
const R = 31;

const A = 0x9908B0DF;

const U = 11;
const D = 0xFFFFFFFF;

const S = 7;
const B = 0x9D2C5680;

const T = 15;
const C = 0xEFC60000;

const L = 18;

const F = 1812433253;

const LOWER_MASK = 0x7FFFFFFF;
const UPPER_MASK = 0x80000000;

let mt = new Array(N);
let index = N + 1;

let seedMT = (seed) => {
	
	index = N;
	mt[0] = seed;
	
	for (let i = 1; i < N; i += 1) {
		mt[i] = F * (mt[i - 1] ^ (mt[i - 1] >> (W - 2))) + i;
	}
};

let extractNumber = () => {
	
	if (index >= N) {
		if (index > N) {
			throw new Error('seed가 생성되지 않았습니다.');
		}
		twist();
	}
	
	let y = mt[index];
	y = y ^ ((y >> U) & D);
	y = y ^ ((y << S) & B);
	y = y ^ ((y << T) & C);
	y = y ^ (y >> L);
	
	index += 1;
	
	return y;
};

let twist = () => {
	
	for (let i = 0; i < N; i += 1) {
		let x = (mt[i] & UPPER_MASK) + (mt[(i + 1) % N] & LOWER_MASK);
		let xA = x >> 1;
		
		if ((x % 2) !== 0) {
			xA = xA ^ A;
		}
		
		mt[i] = mt[(i + M) % N] ^ xA;
	}
	
	index = 0;
};

seedMT(0x12345678);

for (let i = 0; i < 1000; i += 1) {
	let extractedNumber = extractNumber();
	console.log(extractedNumber);
}