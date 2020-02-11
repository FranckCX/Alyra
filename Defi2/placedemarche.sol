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

    modifier estAdmin {
        require(utilisateurs[msg.sender].estAdmin,
        "Vous devez être administrateur.");
        _;
    }

    modifier adresse0 {
        require(msg.sender != address(0),
        "Vérifier votre adresse.");
        _;
    }

    modifier nestPasBan {
        require(estBanni[msg.sender] == false,
        "Vous avez été banni.");
        _;
    }

    constructor() public {
        utilisateurs[msg.sender].nom = "Admin";
        utilisateurs[msg.sender].estAdmin = true;
        utilisateurs[msg.sender].reputation = 1;
    }

    function inscription(string memory _nom) public adresse0 nestPasBan {
        require(utilisateurs[msg.sender].estInscrit == false, "Vous êtes déjà inscrit.");
        utilisateurs[msg.sender].nom = _nom;
        utilisateurs[msg.sender].reputation = 1;
        utilisateurs[msg.sender].estInscrit = true;
    }

    function bannirUtilisateur(address _adresseBan) public estAdmin {
        estBanni[_adresseBan] = true;
    }

    function donnerDroitAdmin(address _adresseNouvelAdmin) public adresse0 estAdmin {
        require(estBanni[_adresseNouvelAdmin] = false,
        "Petit contrôle de papier pour le nouvel Admin.");
        utilisateurs[_adresseNouvelAdmin].estAdmin = true;
    }

    function ajouterDemande(uint _remuneration, uint _secs, string memory _description, uint _minReputation) public payable adresse0 nestPasBan {
        require(msg.value == _remuneration.mul(102).div(100),
        "Déposer la rémunération en ajoutant 2% de frais pour la plateforme.");
        Demande memory nouvelleDemande;
        nouvelleDemande.remuneration = _remuneration.div(102).mul(100);
        nouvelleDemande.demandeur = msg.sender;
        nouvelleDemande.description = _description;
        nouvelleDemande.minReputation = _minReputation;
        nouvelleDemande.delaiMax = _secs;
        nouvelleDemande.etat = Etat.OUVERTE;
        demandes.push(nouvelleDemande);
    }

    function listerDemandes() public view returns (Demande[] memory) {
        return demandes;
    }

}