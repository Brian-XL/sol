// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract LoopTest {
    // 编写一个合约，实现以下功能：
    // 批量添加白名单地址
    // 检查数组中是否存在重复元素
    // 计算数组中所有偶数的和

    address[] private whiteList;

    function AddBatch(address[] calldata list) public {
        for (uint i = 0; i < list.length; i++) {
            whiteList.push(list[i]);
        }
    }

    function Print() public view returns(address[] memory) {
        address[] memory list = whiteList;
        return list;
    }

    function CheckRepeat(address[] calldata list) public pure returns(bool exist) {
        uint len = list.length;
        for(uint i = 0; i < len; i++){
            for(uint j = i + 1; j < len; j++) {
                if(list[i] == list[j]) {
                    return true;
                }
            }
        }
        return false;
    }
}