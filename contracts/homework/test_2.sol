// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract Test_2 {
    //题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"

    function stringReverse(string calldata line) public pure returns (string memory) {
        bytes memory lineBytes = bytes(line);
        uint len = lineBytes.length;

        if (len == 0)   return "";

        bytes memory reverse = new bytes(len);

        for(uint i = 0; i < len; i++) {
            reverse[i] = lineBytes[len -1 - i];
        }

        return string(reverse);
    }
}