/******************************* CONVERSIONS DEC / BIN / HEX *******************************/

// Pour ce projet nous allos ecrire les  fonctions de conversion en relevant le defi de ne pas réutiliser
// une fonction pour servir l'autre. Cela sera à la fois FUN et un bon entrainemenent sur les op binaires
// nous réutiliserons ensuite une fonction GLOBALE qui réutilisera ces fonctions pour tous les types de conversion

// FONCTION ******(DEC -> BIN)******
var ConvertDecToBin = function(nb) {
	var result = ""

	while (nb > 0) {
		result = (nb % 2) + result
		nb = parseInt(nb / 2, 10)
	}
	return result
}

// FONCTION ******(DEC -> HEX)******
var ConvertDecToHex = function(nb) {
	var result = ""
	var tabRef = "0123456789ABCDEF"
	while (nb > 0) {
		result = tabRef[nb % 16] + result
		nb = parseInt(nb / 16, 10)
	}
	return result
}

// FONCTION ******(BIN -> DEC)******
var ConvertBinToDec = function(nb) {
	var result = 0
	var nbBin = nb.toString(2)
	for (let i = nbBin.length - 1; i >= 0; i--) {
		let bit = parseInt(nbBin[i], 2)
		result += bit * Math.pow(2, nbBin.length - 1 - i)
	}
	return result
	//OU simplement return result = parseInt("nbBin",2) et on oublie carrement la boucle "for"!
	//Uniquement pour decrire la methode mathematique
}

// FONCTION ******(BIN -> HEX)******
var ConvertBinToHex = function(nb) {
	var result = ""
	var nbBin = nb.toString(2)
	var tabRef = "0123456789ABCDEF"
	while (nbBin.length >= 4) {
		var row = nbBin.slice(nbBin.length - 4)
		var sum1 = 0

		for (let i = row.length - 1; i >= 0; i--) {
			let bit = parseInt(row[i], 2)
			sum1 += bit * Math.pow(2, row.length - 1 - i)
		}
		result = tabRef[sum1] + result
		nbBin = nbBin.slice(0, nbBin.length - 4)
	}
	//sortie du While
	if (nbBin.length < 4 && nbBin.length > 0) {
		for (let i = nbBin.length - 1; i >= 0; i--) {
			var sum2 = 0
			sum2 += parseInt(nbBin[i], 2) * Math.pow(2, nbBin.length - 1 - i)
		}
		result = tabRef[sum2] + result
	}
	return result
}

// FONCTION ******(HEX -> DEC)******
var ConvertHexToDec = function(nb) {
	var nbHex = nb.toString(16)
	var result = parseInt(nbHex, 16)
	return result
}

// FONCTION ******(HEX -> BIN)******
var ConvertHexToBin = function(nb) {
	var result = ""
	var nbHex = nb.toString(16)
	let dec = parseInt(nbHex, 16)

	while (dec > 0) {
		result = (dec % 2) + result
		dec = parseInt(dec / 2, 10)
	}
	return result
}

var ConvertAll = function(nb, base0, base1) {
	nbString = nb.toString()

	switch (base0) {
		case 2:
			var outPutBDec = ConvertBinToDec(nbString)
			var outPutBHex = ConvertBinToHex(nbString)
			if (base1 === 10) {
				document.getElementById("outBDec").innerHTML = ConvertBinToDec(nbString)
				return outPutBDec
			} else {
				document.getElementById("outBHex").innerHTML = ConvertBinToHex(nbString)
				return outPutBHex
			}
		case 10:
			var outPutDBin = ConvertDecToBin(nbString)
			var outPutDHex = ConvertDecToHex(nbString)
			if (base1 === 2) {
				document.getElementById("outDBin").innerHTML = ConvertDecToBin(nbString)
				return outPutDBin
			} else {
				document.getElementById("outDHex").innerHTML = ConvertDecToHex(nbString)
				return outPutDHex
			}
		case 16:
			var outPutHDec = ConvertHexToDec(nbString)
			var outPutHBin = ConvertHexToBin(nbString)
			if (base1 === 10) {
				outPutHDec = document.getElementById("outHDec").innerHTML = ConvertHexToDec(nbString)
				return outPutHDec
			} else {
				document.getElementById("outHBin").innerHTML = ConvertHexToBin(nbString)
				return outPutHBin
			}

		/*default:
         var outPut = (document.getElementById("out1").innerHTML = "Saisie invalide")
         return outPut*/
	}
}

//API Anecdote
console.log(ConvertDecToHex(255))
