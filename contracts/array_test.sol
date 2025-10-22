// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract ArrayTest{
    //编写合约，允许用户动态管理一个地址类型数组（address[]）

    address[] private userAddresses;

    function addUserAddress(address user) external {
        userAddresses.push(user);
    }

    function getAddressesLength() public view returns (uint) {
        return userAddresses.length;
    }

    function getLastUserAddress() public view returns (address user){
        user = userAddresses[userAddresses.length - 1];
    }

    function getUserAddress(uint index) public view returns (address) {
        address user = userAddresses[index];
        return user;
    }

    function deleteAddress(uint index) public {
        uint len = userAddresses.length;
        require(index >= 0 && index < len, "Index out of bounds");
        delete userAddresses[index];
    }

    function clearAdresses() public {
        delete userAddresses;
    }

    //实现一个函数，接收数组作为参数并返回其元素之和。

    function total(uint[] calldata arr) public pure returns (uint) {
        uint len = arr.length;
        uint sum = 0;
        for (uint i = 0; i < len; i++) {
            sum += arr[i];
        }
        return sum;
    }

    uint[] public ages = [12,22,33,99];

    //创建一个函数，删除数组中的特定元素并调整数组长度。

    function removeElement(uint age) public {
        uint len = ages.length;
        for(uint i = 0; i < len; i++) {
            if(ages[i] == age) {
                uint j = i+1;
                while (j < len) {
                    ages[j - 1] = ages[j];
                    j++;
                }
                ages.pop();
                break;
            }
        }
    }

    function getAges() public view returns (uint[] memory arr) {
        return ages;
    }

    //实现一个函数，计算斐波那契数列的第 n 项（注意 gas 限制）。

    function fibonacci(uint n) external pure returns (uint x) {
        uint previous = 1;
        x = 1;
        for(uint i = 4; i <= n; i++) {
            uint temp = x;
            x += previous;
            previous = temp;
        }
    }



}