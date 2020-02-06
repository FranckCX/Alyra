pragma solidity ^0.5.10;
contract Assemblee {

    struct Decision {
        string proposition;
        uint pour;
        uint contre;
        mapping (address => bool) aDejaVote;
    }

    address[] membres;
    string[] propositions;
    Decision[] public decisions;

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

    function proposition(string memory _proposition) public {
        require(estMembre(msg.sender),
        "Il faut être membre.");
        Decision memory nouvelleProposition = Decision(_proposition,0,0);
        decisions.push(nouvelleProposition);
    }

    function voter(uint indice, bool value) public {
        require(estMembre(msg.sender),
        "Il faut être membre.");
        require(!decisions[indice].aDejaVote[msg.sender],
        "Vous avez déjà voté !");
        if (value == true) {
            decisions[indice].pour++;
        } else {
            decisions[indice].contre++;
        }
        decisions[indice].aDejaVote[msg.sender] = true;
    }

    function comptabiliser(uint indice) public view returns (int){
        return int(decisions[indice].pour - decisions[indice].contre);
    }

}