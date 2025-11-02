// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract CatCoin{
    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint)) public allowances;

    event Transfer(address from, address to, uint256 amount);
    event Approval(address owner, address spender, uint amount);

    string public name = "CatCoin";
    string public symbol = "CTN";
    uint public totalSupply;
    uint public decimals = 18;
    address private owner;

    constructor() {
        owner = msg.sender;
        totalSupply = 100 *  10 ** decimals;
        balances[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    modifier OnlyOwner {
        require(msg.sender == owner, "Authentication failed");
        _;
    }
    
    function mint(address to, uint amount) public OnlyOwner {
        uint mintAmount = amount * 10 ** decimals;
        totalSupply += mintAmount;
        balances[to] += mintAmount;
        emit Transfer(address(0), to, mintAmount);
    }

    function balanceOf(address account) public view returns(uint) {
        return balances[account];
    }

    function transfer(address to, uint value) public {
        require(to != address(0), "Address can not be 0");
        uint balance = balances[msg.sender];
        require(balance >= value, "Insufficient CatCoin");
        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    function allowance(address _owner, address _spender) public view returns(uint) {
        return allowances[_owner][_spender];
    }

    function approve(address spender, uint value) public {
        require(spender != address(0),"");
        allowances[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
    }

    function transferFrom(address from, address to, uint value) public {
        uint allowed = allowances[from][msg.sender];
        require(allowed >= value, "Insufficient allowance");
        require(from != address(0), "");
        require(to != address(0), "");
        balances[from] -= value;
        balances[to] += value;
        allowances[from][msg.sender] = allowed - value;

        emit Transfer(from, to, value);
    }

}