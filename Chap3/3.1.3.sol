pragma solidity ^0.5.10;
contract voteAssemblee {

address[] membres;
string[] propositions;
uint8[] pour;
uint8[] contre;

    function rejoindre() public {
        membres.push(msg.sender);
        }

    function estMembre(address _utilisateur) public view returns (bool) {
        for (uint i = 0; i < membres.length; i++) {
            if (membres[i] == _utilisateur){
                return true;
            } else {
                return false;
            }
        }
    }

    function proposition(string memory proposition) public {
        require(estMembre(msg.sender));
        propositions.push(proposition);
        pour.push(0);
        contre.push(0);
    }

    function voter(uint indice, bool value) public {
        require(estMembre(msg.sender));
        if (value == true) {
            pour[indice]++;
        } else {
            contre[indice]++;
        }
    }

    function comptabiliser(uint indice) public view returns (int){
        int resultat = int(pour[indice] - contre[indice]);
        return resultat;
    }

}