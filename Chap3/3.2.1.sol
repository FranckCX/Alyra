pragma solidity ^0.5.10;
contract CagnotteFestival {

    mapping (address => uint) organisateurs;

    constructor() public {
        organisateurs[msg.sender] = 100;
    }

    function transfererOrga(address orga, uint parts) internal {
        require(estOrga(msg.sender), "Il faut être organisateur.");
        organisateurs[orga] += parts;
        organisateurs[msg.sender] -= parts;
    }

    function estOrga(address orga) public view returns (bool) {
        if (organisateurs[orga] != 0){
            return true;
        } else {
            return false;
        }
    }

}