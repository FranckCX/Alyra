/****************** Bitcoin et fondamentaux ****************
 Exercice 1.4.1 : Convertir un nombre décimal en hexadécimal
 ***********************************************************/

// FONCTION ******(DEC -> HEX BIG ENDIAN)******
var ConvertDecToHexB = function(nb) {
	return "0x" + nb.toString(16)
}

// FONCTION BASCULE BIG ENDIAN <-> LITTLE ENDIAN
var Switch = function(valeurHex) {
	var result = ""
	valeurHex = valeurHex.slice(2, valeurHex.length) // pour supprimer le 0x sur la valeur d'entrée
	while (valeurHex.length > 0) {
		let decoupe = valeurHex.length - 2
		result += valeurHex.substr(decoupe, 2)
		valeurHex = valeurHex.slice(0, decoupe)
	}
	return "0x" + result
}

// FONCTION ******(DEC -> HEX LITTLE ENDIAN)******
var ConvertDecToHexL = function(nb) {
	var nbc = ConvertDecToHexB(nb)
	return Switch(nbc)
}

console.log((114715289634538668295251818867004745287553766218669123).toString(16))

//EXPORTS DES FONCTIONS
module.exports.CDHB = ConvertDecToHexB
module.exports.CDHL = ConvertDecToHexL
module.exports.SW = Switch
