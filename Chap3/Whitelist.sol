pragma solidity ^0.5.16;

contract WhiteList {

    struct Person {
        string nom;
        string prenom;
    }

    //Person[] public persons;
    mapping(address => Person) public persons;
    address administrateur;
    uint expiration;

    modifier onlyAdmin {
        require(msg.sender == administrateur);
        _;
    }

    modifier isNotExpired {
        require(now <= expiration);
        _;
    }

    constructor() public {
        administrateur = msg.sender;
        expiration = now + 10 days;
    }

    function ajouterPerson(string memory _nom, string memory _prenom, address _address) public onlyAdmin isNotExpired {
        Person memory p = Person(_nom, _prenom);
        persons[_address] = p;//.push(p);
    }

}