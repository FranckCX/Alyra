pragma solidity ^0.5.15;
contract Pulsation {

    uint public battement;
    string private message;

    constructor(string memory _message) public {
        battement = 1;
        message = _message;
    }

    function ajouterBattement() public {
        battement++;
        return message;
    }
}

contract Pendule  {

    Pulsation pulse;

    function provoquerUnePulsation()public{
    pulse.ajouterBattement();
    }
}