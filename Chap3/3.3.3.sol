pragma solidity ^0.5.15;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Pulsation {
    using SafeMath for uint256;

    uint public battement;
    string private message;

    constructor(string memory _message) public {
       message = _message;
    }

    function ajouterBattement() public view returns (string memory) {
        battement.add(1);
        return message;
    }
}

contract Pendule {

    Pulsation pulse;
    string[] public balancier;
    Pulsation tac;
    Pulsation tic;

    constructor(string memory _message) public {
        pulse = new Pulsation(_message);
    }

    function provoquerUnePulsation() public {
        pulse.ajouterBattement();
    }

    function ajouterTacTic(Pulsation _tic, Pulsation _tac) public {
        tic = _tic;
        tac = _tac;
    }

    function mouvementsBalancier() public {
        balancier.push(tic.ajouterBattement());
        balancier.push(tac.ajouterBattement());
    }
}