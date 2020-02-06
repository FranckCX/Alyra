pragma solidity ^0.5.10;
contract artistesSurScene {

string[12] passagesArtistes;
uint creneauxLibres = 12;
uint tour;

  function sinscrire(string memory nomDArtiste) public {
      if(creneauxLibres>0) {
        passagesArtistes[12-creneauxLibres] = nomDArtiste;
        creneauxLibres -= 1;
      }
  }

  function passeralArtisteSuivant() public {
    if(tour < creneauxLibres) {
      tour += 1;
    }
  }

  function artisteEnCours() public view returns (string memory) {
    if (tour < creneauxLibres) {
      return passagesArtistes[tour];
    } else {
      return "FIN";
    }
  }
}