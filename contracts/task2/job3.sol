// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract BeggingContract {
    event Donation(address indexed sender, uint amount);
    event Withdraw(uint amount);
    
    mapping (address => uint) donations;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function donate() external payable {
        require(msg.value >= 0, "not enough eth");
        donations[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }

    function getDonation(address user) public view returns(uint) {
        require(user != address(0), "address cannot be 0");
        return donations[user];
    }

    modifier onlyOwner {
        require(msg.sender == owner, "must be owner");
        _;
    }
    function withdraw() public onlyOwner {
        uint value = address(this).balance;
        payable(owner).transfer(value);
        emit Withdraw(value);
    }

    receive() external payable {
        require(msg.value >= 0, "Not enough eth");
        donations[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }

    fallback() external payable {
        require(msg.value >= 0, "Not enough eth");
        donations[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }

    struct Donor{
        address sender;
        uint value;
    }
    function rankings() public view returns(Donor memory) {
    }

}