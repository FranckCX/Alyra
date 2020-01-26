function estPalindrome(str) {
    str = str.split(" ").join("");
    return str === str.split("").reverse().join("");
}

console.log(estPalindrome("ESOPE RESTE ICI ET SE REPOSE"));
console.log(estPalindrome("ASSIETTE"));
