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

    //整数转罗马数字
    function intToRoman(uint num) public pure returns(string memory) {
        uint[13] memory values = [uint256(1000), 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        string[13] memory letters = ["M", "CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"];
        
        string memory str;

        uint i = 0;
        while(num != 0) {
            uint v = values[i];
            if(num >= v) {
                num -= v;
                str = string(abi.encodePacked(str, letters[i]));
            } else {
                i++;
            }
        }
        return str;
    }


    function romanToInt(string memory str) public pure returns (uint) {
        bytes memory b = bytes(str);
        uint sum = 0;
        uint len = b.length;
        
        for(uint i = 0; i<len; i++) {
            uint n1 = valueOf(b[i]);
            if(i == len - 1) {
                sum += n1;
                break;
            }

            uint next = valueOf(b[i + 1]);
            
            if(n1 < next) {
                if(sum < n1) {
                    sum += next - n1;
                    i++;
                } else {
                    sum -= n1;
                }
            } else {
                sum += n1;
            }
        }
        
        return sum;
    }


    function valueOf(bytes1 c) internal pure returns (uint) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        return 0;
    }



    //将两个有序数组合并为一个有序数组。

    function mergeArrays(uint[] calldata arr1, uint[] calldata arr2) public pure returns(uint[] memory) {
        uint len1 = arr1.length;
        uint len2 = arr2.length;
        uint[] memory full = new uint[](len1 + len2);
        
        uint i = 0;
        uint j = 0;
        uint f_index = 0;
        while (i < len1 && j < len2) {
            if(arr1[i] < arr2[j]) {
                full[f_index++] = arr1[i++];
            } else {
                full[f_index++] = arr2[j++];
            }
        }

        while(i < len1) {
            full[f_index++] = arr1[i++];
        }
        while(j < len2) {
            full[f_index++] = arr2[j++];
        }

        return full;
    }
}