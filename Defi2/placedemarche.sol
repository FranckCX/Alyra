pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract PlaceDeMarche {

    using SafeMath for uint256;

    struct Utilisateur {
        string nom;
        bool estInscrit;
        bool estAdmin;
        uint reputation;
    }

    struct Demande {
        uint remuneration;
        address demandeur;
        uint delaiMax;
        string description;
        Etat etat;
        uint minReputation;
        address[] candidats;
    }

    enum Etat { OUVERTE, ENCOURS, FERMEE }
    Demande[] public demandes;
    mapping (address => bool) estBanni;
    mapping (address => Utilisateur) public utilisateurs;

    constructor() public {
        utilisateurs[msg.sender].nom = "Admin";
        utilisateurs[msg.sender].estAdmin = true;
        utilisateurs[msg.sender].reputation = 1;
    }

    modifier estAdmin {
        require(utilisateurs[msg.sender].estAdmin == true,
        "Vous devez être administrateur.");
        _;
    }

    modifier adresse0 {
        require(msg.sender != address(0),
        "Vérifier votre adresse.");
        _;
    }

    modifier estBan {
        require(estBanni[msg.sender] == false,
        "Vous avez été banni.");
        _;
    }

    function inscription(string memory nom) public adresse0 estBan {
        require(utilisateurs[msg.sender].estInscrit == false, "Vous êtes déjà inscrit.");
        utilisateurs[msg.sender].nom = nom;
        utilisateurs[msg.sender].reputation = 1;
        utilisateurs[msg.sender].estInscrit = true;
    }

    function bannirUtilisateur(address adresseBan) public estAdmin {
        estBanni[adresseBan] = true;
    }

    function donnerDroitAdmin(address adresseNouvelAdmin) public adresse0 estAdmin estBan {
        utilisateurs[adresseNouvelAdmin].estAdmin = true;
    }

    function ajouterDemande(uint remuneration, uint secs, string memory description, uint minReputation) public payable adresse0 estBan {
        require(msg.value == remuneration * 102 / 100,
        "Déposer la rémunération en ajoutant 2% de frais pour la plateforme.");
        Demande memory nouvelleDemande;
        nouvelleDemande.remuneration = remuneration / 102 * 100;
        nouvelleDemande.demandeur = msg.sender;
        nouvelleDemande.description = description;
        nouvelleDemande.minReputation = minReputation;
        nouvelleDemande.delaiMax = secs;
        nouvelleDemande.etat = Etat.OUVERTE;
        demandes.push(nouvelleDemande);
    }

    function listerDemandes() public view returns (Demande[] memory) {
        return demandes;
    }

}