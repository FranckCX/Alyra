const getRandomValues = require("./node_modules/get-random-values");
const sha256 = require("./node_modules/crypto-js/sha256");
const ripemd160 = require("./node_modules/crypto-js/ripemd160");
const bs58 = require("./node_modules/bs58");

//1- Choisir la clé publique aléatoirement
//2- Calculer le hash SHA 256 puis RIPEMD160, on appelle ce résultat hash160 
//3- Ajouter l’identifiant (0x00) au début, et le contrôle à la fin (4 premiers octets du sha256(sha256(0x00 + hash160)) )
//4- Convertir en base58
//5- Générer la clé privée aléatoirement
//6- Calculer la clé publique EDSA Secp256k1 
//7- Représenter la clé publique sour la forme 0x04 X(sur 32bits) Y(sur 32 bits)
//8- à partir de là appliquer les étapes précédentes (hash160, ajouter entête et clé, conversion en base58)

function genererAdresseBitcoin() {
    console.log("Générer une adresse Bitcoin :")

    //1- Choisir la clé publique aléatoirement
    let array = new Uint8Array(32);
    getRandomValues(array);
    let clePublique = array.join('');
    console.log(`Clé publique: ${clePublique}`);

    //2- Obtention du hash ripemd160 en faisant auparavant un SHA-256 de la clé publique   
    let hash160 = ripemd160(sha256(clePublique));
    console.log(`Clé publique en ripemd160: ${hash160}`);

    //3- Contrôle de fin : Calcul des 4 premiers octets du sha256(sha256(0x00 + hash160))
    let premiersOctets = sha256(sha256(0x00 + hash160));
    //3- On ajoute en préfixe 0x00 et en suffixe les 4 premiersOctets pour obtenir l'adresseBtc
    let adresseBtc = "0x00" + hash160 + premiersOctets;
    
    //4- Conversion de adresseBtc en bs58
    const bytes = Buffer.from(adresseBtc.substr(2, adresseBtc.length -1), 'hex');
    const adresse58 = bs58.encode(bytes);
    console.log(`Adresse en bs58: ${adresse58}`);
    
    console.log("Nouvelle adresse générée");
}

genererAdresseBitcoin();
