binary_gap = N => Math.max(...(N.toString(2).match(/0+1/g) || [' ']).map(x => x.length - 1));

console.log(binary_gap(0));
console.log(binary_gap(1041));
console.log(binary_gap(32));

rotate_right = A => (A.unshift(A.pop()), A);
cyclic_rotation = (A, K) => [...new Array(K % A.length)].reduce((p,v) => rotate_right(p), A);

console.log(cyclic_rotation([3,8,9,7,6], 3));
console.log(cyclic_rotation([3,8,9,7,6], 8));
console.log(cyclic_rotation([0,0,0], 1));

odd_occurrences_in_array = A => A.reduce((p,v) => p ^ v, 0);

console.log(odd_occurrences_in_array([9,3,9,3,9,7,9]));
console.log(odd_occurrences_in_array([9,7,9,3,9,7,9]));

frog_jmp = (x, y, d) => Math.ceil((y - x) / d);

console.log(frog_jmp(10, 85, 30));
console.log(frog_jmp(10, 95, 30));
console.log(frog_jmp(10, 105, 30));

perm_missing_elem = A => A.reduce((p,v) => p - v, 1/2 * (A.length + 2) * (A.length+1) );

console.log(perm_missing_elem([1,2,3,5]))
console.log(perm_missing_elem([2,3,4,5]))
console.log(perm_missing_elem([1,2,3,4,5]))
console.log(perm_missing_elem([5,4,3,2,1]))

tape_equilibrium = A => Math.min(...A.slice(0, -1).reduce((p,v) => (p[0].push(Math.abs(p[1]-p[2]+2*v)), [ p[0], p[1] + v, p[2] - v ]) , [ [], 0, A.reduce((p,v) => p+v, 0) ] )[0]);

console.log(tape_equilibrium([3,1,2,4,3]));

perm_check = A => A.reduce((p,v) => p - v, 1/2 * (1 + A.length) * A.length ) == 0 ? 1 : 0;

console.log(perm_check([4,1,3,2]));
console.log(perm_check([4,1,3]));
