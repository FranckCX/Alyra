pragma solidity ^0.5.10;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Cogere {

    using SafeMath for uint256;

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

contract CagnotteFestival is Cogere {

    mapping (address => bool) festivaliers;
    uint public placesRestantes;
    uint private depensesTotales;
    string[] public sponsors;
    uint constant LIMITE = 100;

    function acheterTicket() public payable {
        require(msg.value >= 500 finney,
        "Place à 0.5 Ethers");
        require(placesRestantes > 0,
        "Plus de places !");
        festivaliers[msg.sender] = true;
    }

    function payer(address payable destinataire, uint montant) public {
        require(estOrga(msg.sender));
        require(destinataire != address(0));
        require(montant > 0);
        destinataire.transfer(montant);
    }

    function comptabiliserDepense(uint montant) private {
        depensesTotales += montant;
    }

    function sponsoriser(string memory nom) public payable {
        require(msg.sender != address(0));
        require(msg.value >= 30 ether && sponsors.length <= LIMITE, "Don de 30 ethers minimum");
        sponsors.push(nom);
    }

}