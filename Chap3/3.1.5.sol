pragma solidity ^0.5.10;
contract Assemblee {

    struct Decision {
        string proposition;
        uint pour;
        uint contre;
        mapping (address => bool) aDejaVote;
    }

    address[] private membres;
    address[] private admins;
    string[] public propositions;
    Decision[] public decisions;

    constructor() public {
        membres.push(msg.sender);
        admins.push(msg.sender);
    }

    modifier verifMembre() {
        require(estMembre(msg.sender),
        "Il faut être membre.");
        _;
    }

    modifier verifAdmin() {
        require(estAdmin(msg.sender),
        "Il faut être administrateur.");
        _;
    }

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

    function estAdmin(address _utilisateur) public view returns (bool) {
        for (uint i = 0; i < admins.length; i++) {
            if (admins[i] == _utilisateur){
                return true;
            } else {
                return false;
            }
        }
    }

    function proposition(string memory _proposition) public verifMembre {
        Decision memory nouvelleProposition = Decision(_proposition,0,0);
        decisions.push(nouvelleProposition);
    }

    function voter(uint _indice, bool _value) public verifMembre {
        require(!decisions[_indice].aDejaVote[msg.sender],
        "Vous avez déjà voté !");
        if (_value == true) {
            decisions[_indice].pour++;
        } else {
            decisions[_indice].contre++;
        }
        decisions[_indice].aDejaVote[msg.sender] = true;
    }

    function comptabiliser(uint _indice) public view returns (int){
        return int(decisions[_indice].pour - decisions[_indice].contre);
    }

    function _nommerAdmin(address _nouveauAdmin) private verifMembre verifAdmin {
        admins.push(_nouveauAdmin);
    }

    function _demissionner() private verifAdmin {
        for (uint i = 0; i < admins.length; i++) {
            if (msg.sender == admins[i]) {
                delete admins[i];
            }
        }
    }

    function cloturerDecision(uint _numeroDecision) public verifAdmin {
        delete decisions[_numeroDecision];
    }

}