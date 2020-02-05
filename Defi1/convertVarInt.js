/****************** Bitcoin et fondamentaux ****************
    Exercice 1.4.2 : Convertir un nombre en little endian
 ***********************************************************/

//IMPORTS DES FONCTIONS DE CONVERSION
const Conv = require("./convertHexLB")

//
var ConvertDecToHexVarInt = function(nb) {
	if (nb < Math.pow(2, 8) - 1 - 2) {
		// 253 = (255-2) = ((2^8 - 1)-2)
		// < 253 pour eviter les confusions avec les valeurs
		// 253, 254, 255 qui eux donneront sur 1 octet 0xfd, 0xfe et 0xff
		// (qui sont resrvés au codage de la taille)
		return Conv.CDHL(nb)
	} else if (nb >= Math.pow(2, 8) - 1 - 2 && nb < Math.pow(2, 16)) {
		return "0xfd" + Conv.CDHL(nb).slice(2, Conv.CDHL(nb).length)
	} else if (nb >= Math.pow(2, 16) && nb < Math.pow(2, 32)) {
		return "0xfe" + Conv.CDHL(nb).slice(2, Conv.CDHL(nb).length)
	} else if (nb >= Math.pow(2, 32) && nb < Math.pow(2, 64)) {
		// ou 58???...
		return "Oxff" + Conv.CDHL(nb).slice(2, Conv.CDHL(nb).length)
	} else {
		return "INVALID INTEGER VALUE"
	}
}

module.exports.CDHVI = ConvertDecToHexVarInt
