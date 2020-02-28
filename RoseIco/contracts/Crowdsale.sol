pragma solidity >=0.5.0 <= 0.6.0;

import "./SafeMath.sol";
import "./RoseToken.sol";

contract Crowdsale {
    using SafeMath for uint256;

    address payable private _admin;
    address payable private _wallet;
    RoseToken private _token;
    uint256 private _tokenSold;

    event Vendu(address vendeur, address acheteur, uint256 montant);

    constructor(address payable wallet) public {
        _admin = msg.sender;
        _wallet = wallet;
        _token = new RoseToken();
    }

    modifier estAdmin {
        require(msg.sender == _admin,
        "Vous n'êtes pas admin.");_;
    }

    modifier nestPasAdresse0 {
        require(msg.sender != address(0),
        "Vous avez un problème d'adresse.");_;
    }

    function getAdmin() public view returns (address payable) {
        return _admin;
    } //ici on utilise un getter pour récup _admin qui a été set en private

    function getWallet() public view returns (address payable) {
        return _wallet;
    }

    function getToken() public view returns (RoseToken) {
        return _token;
    }

    function getSoldToken() public view returns (uint256) {
        return _tokenSold;
    }

    function venteToken(uint256 montant) public payable nestPasAdresse0 {
        require(montant > 0,
        "Vous ne pouvez pas acheter 0 token, banane");
        // _controleVente(msg.value);
        _wallet.transfer(msg.value);
        _tokenSold = _tokenSold.add(msg.value);
        _token.setBalances(msg.sender, msg.value);
        _token.transferFrom(address(this), msg.sender, montant);
        emit Vendu(address(this), msg.sender, montant);
        // emit Vendu(msg.sender, _wallet, montant);
    }

    function _controleVente(uint256 montant) public view {
        require(montant > _token.totalSupply(),
        "Mauvais montant.");
        require(_token.totalSupply() - _tokenSold > montant,
        "Mauvais montant.");
        this;
    }
    
    function fermtureVente() private estAdmin {
        require(_token.transfer(admin, _token.balanceOf(this)));
        _admin.transfer(address(this).balance);
    }

    function fallback() external payable {}

}