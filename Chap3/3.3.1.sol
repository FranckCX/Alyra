pragma solidity ^0.5.16;

contract Pulsation {
    uint public battement;

    constructor() public {
        battement = 0;
    }

    function ajouterBattement() public {
        battement++;
    }

}