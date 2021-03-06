pragma solidity ^0.5.16;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Cogere {

    using SafeMath for uint256;

    mapping (address => uint) organisateurs;

    constructor() public {
        organisateurs[msg.sender] = 100;
    }

    modifier adresse0 {
        require(msg.sender != address(0));
        _;
    }

    function transfererOrga(address orga, uint parts) internal adresse0 {
        require(estOrga(msg.sender), "Il faut être organisateur.");
        organisateurs[orga] += parts;
        organisateurs[msg.sender] -= parts;
    }

    function estOrga(address orga) public view returns (bool) {
        return (organisateurs[orga] > 0);
    }

}

contract CagnotteFestival is Cogere {

    constructor() public {
        dateFestival = block.timestamp;
        dateLiquidation = dateFestival + 2 weeks;
        jour = dateFestival;
    }

    mapping (address => bool) festivaliers;
    uint public placesRestantes = 10000;
    uint private depensesTotales;
    string[] public sponsors;
    uint constant LIMITE = 100;
    uint public dateFestival;
    uint public dateLiquidation;
    uint public jour;
    uint private cagnotte;
    uint private depensesParJour;
    uint private depensesMaxParJour = cagnotte / 14 ;

    function acheterTicket() public payable {
        require(msg.value >= 500 finney,
        "Place à 0.5 Ethers");
        require(placesRestantes > 0,
        "Plus de places !");
        require(block.timestamp >= dateLiquidation,
        "Après l'heure, c'est plus l'heure ! A l'année prochaine !");
        festivaliers[msg.sender] = true;
        placesRestantes --;
        _ajoutCagnotte(msg.value);
    }

    function payer(address payable destinataire, uint montant) public adresse0 {
        require(estOrga(msg.sender));
        require(montant > 0);
        destinataire.transfer(montant);
        _comptabiliserDepense(montant);
    }

    function _comptabiliserDepense(uint montant) internal {
        depensesParJour += montant;
        depensesTotales += montant;
    }

    function sponsoriser(string memory nom) external payable adresse0 {
        require(msg.value >= 30 ether && sponsors.length <= LIMITE, "Don de 30 ethers minimum dans la limite des places disponibles.");
        sponsors.push(nom);
    }

    function nombrePlacesRestantes() public view returns (uint) {
        return placesRestantes;
    }

    function _totalesDepenses() private view returns (uint) {
        return depensesTotales;
    }

    function listeSponsor(uint i) public view returns (string memory) {
        return sponsors[i];
    }

    function _ajoutCagnotte(uint montant) internal {
        cagnotte += montant;
    }

    function totalCagnotte() public view returns (uint) {
        return cagnotte;
    }

    function controleDepenses() internal returns (bool) {
        if (block.timestamp - jour > 1 days) {
            jour += days;
            depensesParJour = 0;
            controleDepenses();
        } else {
            return depensesParJour < depensesMaxParJour ? true : false;
        }
    }

}