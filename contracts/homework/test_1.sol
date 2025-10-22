// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

 contract Voting {
//     创建一个名为Voting的合约，包含以下功能：
//     一个mapping来存储候选人的得票数
//     一个vote函数，允许用户投票给某个候选人
//     一个getVotes函数，返回某个候选人的得票数
//     一个resetVotes函数，重置所有候选人的得票数

    struct Candidate {
        uint id;
        string name;
        uint count;
    }

    mapping(address => Candidate) internal candidateVotes;

    address[] candidates;

    constructor () {
        candidateVotes[0x742d35Cc6634C0532925a3b844Bc454e4438f44e] = Candidate({
            id: 123,
            name: "Bob",
            count: 0
        });
        candidateVotes[0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] = Candidate({
            id: 456,
            name: "Alice",
            count: 0
        });

        candidates = [0x742d35Cc6634C0532925a3b844Bc454e4438f44e, 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC];

    }

    function vote(address candidate) public returns(uint, string memory, uint) {
        candidateVotes[candidate].count += 1;
        
        Candidate memory c = candidateVotes[candidate];
        return (c.id, c.name, c.count);
    }

    function getVotes(address candidate) public view returns(uint){
        return candidateVotes[candidate].count;
    }

    function resetAllVotes() public {
        uint len = candidates.length;
        for (uint i = 0; i < len; i++) {
            Candidate storage can = candidateVotes[candidates[i]];
            can.count = 0;
        }
        
    }

}