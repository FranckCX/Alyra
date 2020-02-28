pragma solidity >=0.5.0 <= 0.6.0;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";

contract RoseToken {
    using SafeMath for uint256;

    string public name = "RoseToken";
    string public symbol = "ROZ";
    uint public decimals = 18;
    uint private _totalSupply = 10000000000*10**18;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() public {
        _balances[msg.sender] = _totalSupply;
    }

    function setBalances(address acheteur, uint256 token) public {
        //require msg.sender == adresse de mon contrat crowdsale
        _balances[acheteur] = token;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256){
        return _balances[account];
    }
    function transfer(address recipient, uint256 amount) external returns (bool){
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _balances[msg.sender] = _balances[msg.sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool){
        require(msg.sender != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function allowance(address owner, address spender) external view returns (uint256){
        return _allowances[owner][spender];
    }
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _allowances[sender][msg.sender] = _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance");
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
        return true;
    }
} 