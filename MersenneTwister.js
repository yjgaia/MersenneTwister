"use strict";

const W = 64;
const N = 312;
const M = 156;
const R = 31;

const A = 0xB5026F5AA96619E9;

const U = 29;
const D = 0x5555555555555555;

const S = 17;
const B = 0x71D67FFFEDA60000;

const T = 37;
const C = 0xFFF7EEE000000000;

const L = 43;

const F = 0x5851f42d4c957f2d;

const LOWER_MASK = (1 << R) - 1;
const UPPER_MASK = ~LOWER_MASK;

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

seedMT(0x0000000012345678);

console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());
console.log(extractNumber());