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
        uint balance = donations[msg.sender] + msg.value;
        donations[msg.sender] = balance;
        emit Donation(msg.sender, msg.value);
        updateRanks(msg.sender, balance);
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
        uint balance = donations[msg.sender] + msg.value;
        donations[msg.sender] = balance;
        emit Donation(msg.sender, msg.value);
        updateRanks(msg.sender, balance);
    }
    fallback() external payable {
        require(msg.value >= 0, "Not enough eth");
        uint balance = donations[msg.sender] + msg.value;
        donations[msg.sender] = balance;
        emit Donation(msg.sender, msg.value);
        updateRanks(msg.sender, balance);
    }

    struct Donor{
        address sender;
        uint value;
    }

    Donor[3] public donors;

    function updateRanks(address sender, uint value) internal {
        bool update = false;
        Donor[3] memory d = donors;
        for (uint i = 0; i < 3; i++) {
            if(sender == d[i].sender) {
                d[i].value = value;
                update = true;
                break;
            }
        }

        if(!update && value > d[2].value) {
            d[2] = Donor({sender: sender, value: value});
        }

        for (uint i = 0; i < 3; i++) {
            for (uint j = i+1; j < 3; j++) {
                if(d[i].value < d[j].value) {
                    Donor memory temp = d[i];
                    d[i] = d[j];
                    d[j] = temp;
                    break;
                }
            }
        }
        
        for(uint i = 0; i < 3; i++) {
            if(donors[i].sender != d[i].sender || donors[i].value != d[i].value){
                donors[i] = d[i];
            }
        }
    }
    
    function rankings() public view returns(Donor[3] memory) {
        return donors;
    }

}