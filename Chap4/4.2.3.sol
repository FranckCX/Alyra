pragma solidity ^0.6.0;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Credibilite {

   using SafeMath for uint256;

   mapping (address => uint256) public cred;
   bytes32[] private devoirs;

   event Remise(bytes32 hashDevoir, address adresseEleve);


   function produireHash(string memory _url) public pure returns (bytes32 Hash) {
      bytes32 urlHash = keccak256(bytes(_url));
      return urlHash;
   }

   function transfer(address _destinataire, uint256 _valeur) public {
   require(cred[msg.sender] > _valeur,
   "Vous devez garder au moins 1 point de crédibilité");
   cred[msg.sender] -= _valeur;
   cred[_destinataire] += _valeur;
   }

   function remettre(bytes32 _devoir) public returns (uint) {
      devoirs.push(_devoir);
      emit Remise(_devoir, msg.sender);
      uint ordre = devoirs.length;
      return ordre;
   }

}
