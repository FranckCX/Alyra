/****************** Bitcoin et fondamentaux ****************
       Exercice 2.1.1 : Convertir la cible en difficulté
 ***********************************************************/

const Bits2Target = function(bits) {
	// bits = nombre en Hex little Endian sur 32bits/4o
	// donc l'octet "exposant" sur 1o se retrouve a gauche d'une mantisse de 3octets en little indian
	// pour créer justement le principe de proportionalité inversée entre cible et diificulté
	var nb = bits.toString(16)
	let oct1 = nb.slice(0, 2) // octet le - significatif (le plus à gauche) qui sera en exposant
	let oct3 = nb.substr(2, nb.length - 2) // 3 autres octets les + significatifs (mantisse)
	//la target sera donc tronquéa a 64bits/8o (les 1ers "0" sur 5o + les "Bits" sur 3o)

	var result = (parseInt(oct3, 16) * 2 ** (8 * (parseInt(oct1, 16) - 3))).toString(16)
	while (result.length < 64) {
		result = "0" + result
	}
	return "0x" + result
}

const Target2Diff = function(target) {
	var bdiff1 = 0x1d00ffff
	// la plus basse unité de difficulté = difficulté du bloc genesis miné par satoshi
	// correspondant donc à la cible la plus grande en minage individuel (0x00000000ffff0000000000000000000000000000000000000000000000000000)
	// (en dessous de laquelle tous les hash de bloc seraient valides lors d'un minage, donc trop facile)
	var target1 = Bits2Target(bdiff1)
	var result = target1 / target
	return result
}

const Bits2Diff = function(bits) {
	return Target2Diff(Bits2Target(bits))
}

console.log(Bits2Target(0x1b0404cb))
console.log(Bits2Target(0x1bffffff))
console.log(Bits2Target(1147152896345386682952518188670047452875537662186691235300769792000))
console.log(Bits2Target(0x1d00ffff))

console.log(Target2Diff(0x1b0404cb))
console.log(Target2Diff(0x1bffffff))
console.log(Target2Diff(1147152896345386682952518188670047452875537662186691235300769792000))
console.log(Target2Diff(0x1d00ffff))

console.log(Bits2Diff(0x1b0404cb)) //difficulté à la cible 0x1b0404cb
console.log(Bits2Diff(0x1bffffff))
console.log(Bits2Diff(1147152896345386682952518188670047452875537662186691235300769792000))
console.log(Bits2Diff(0x1d00ffff))
