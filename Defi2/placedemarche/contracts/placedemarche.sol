pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";

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
        bytes32 urlHash;
        address illustrateur;
    }

    enum Etat { OUVERTE, ENCOURS, FERMEE }
    Demande[] public demandes;
    mapping (address => bool) public estBanni;
    mapping (address => Utilisateur) public utilisateurs;
    mapping (address => bool) private debloquerFonds;

    modifier estAdmin {
        require(utilisateurs[msg.sender].estAdmin,
        "Vous devez être administrateur.");_;
    }

    modifier adresse0 {
        require(msg.sender != address(0),
        "Vérifier votre adresse.");_;
    }

    modifier nestPasBan {
        require(estBanni[msg.sender] == false,
        "Vous avez été banni.");_;
    }

    modifier estInscrit {
        require(utilisateurs[msg.sender].estInscrit == true,
        "Vous devez vous inscrire pour accèder à cette fonction.");_;
    }

    modifier minRep(uint _idDemande) {
        require(utilisateurs[msg.sender].reputation >= demandes[_idDemande].minReputation,
        "vous n'avez pas assez de réputation.");_;
    }

    constructor() public {
        utilisateurs[msg.sender].nom = "Admin";
        utilisateurs[msg.sender].estAdmin = true;
        utilisateurs[msg.sender].reputation = 100;
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

    function ajouterDemande(uint _rem, uint _secs, string memory _desc, uint _minReputation) public payable adresse0 estInscrit nestPasBan {
        require(msg.value == _rem.mul(102).div(100),
        "Déposer la rémunération en ajoutant 2% de frais pour la plateforme.");
        Demande memory nouvelleDemande;
        nouvelleDemande.remuneration = _rem.div(102).mul(100);
        nouvelleDemande.demandeur = msg.sender;
        nouvelleDemande.description = _desc;
        nouvelleDemande.minReputation = _minReputation;
        nouvelleDemande.delaiMax = _secs;
        nouvelleDemande.etat = Etat.OUVERTE;
        demandes.push(nouvelleDemande);
    }

    function listerDemandes() public estInscrit nestPasBan view returns (Demande[] memory) {
        return demandes;
    }

    function postuler(uint _idDemande) public adresse0 estInscrit nestPasBan minRep(_idDemande) {
        require(demandes[_idDemande].etat == Etat.OUVERTE,
        "Votre demande est en cours de traitement.");
        demandes[_idDemande].candidats.push(msg.sender);
    }

    function accepterOffre(uint _idDemande, uint _idCandidat) public adresse0 estInscrit nestPasBan {
        require(demandes[_idDemande].etat == Etat.OUVERTE,
        "Votre demande est déjà en cours de traitement.");
        demandes[_idDemande].etat == Etat.ENCOURS;
        demandes[_idDemande].delaiMax = block.timestamp + demandes[_idDemande].delaiMax;
        demandes[_idDemande].illustrateur = demandes[_idDemande].candidats[_idCandidat];
    }

    function livraison(uint _idDemande, bytes32 _urlHash) public adresse0 estInscrit nestPasBan minRep(_idDemande) {
        require(demandes[_idDemande].etat == Etat.ENCOURS,
        "Votre demande doit être acceptée.");
        demandes[_idDemande].urlHash = _urlHash;
        debloquerFonds[demandes[_idDemande].illustrateur] = true;
        utilisateurs[demandes[_idDemande].illustrateur].reputation++;
        demandes[_idDemande].etat = Etat.FERMEE;
    }
}