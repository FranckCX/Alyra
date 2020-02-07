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

    function voter(uint _indice, bool _value) public {
        require(estMembre(msg.sender),
        "Il faut être membre.");
        require(!decisions[_indice].aDejaVote[msg.sender],
        "Vous avez déjà voté !");
        if (_value == true) {
            decisions[_indice].pour++;
        } else {
            decisions[_indice].contre++;
        }
        decisions[indice].aDejaVote[msg.sender] = true;
    }

    function comptabiliser(uint _indice) public view returns (int){
        return int(decisions[_indice].pour - decisions[_indice].contre);
    }

}