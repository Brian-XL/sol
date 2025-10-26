// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelectorVisualizer {
    event Info(bytes data, bytes4 selector, bytes4 sig);

    function foo(uint x, string memory name) public {
        emit Info(msg.data, this.foo.selector, msg.sig);
    }

    function getSelector() public pure returns (bytes4) {
        return bytes4(keccak256("foo(uint256,string)"));
    }

    function getAllData() public pure returns(bytes memory) {
        return abi.encodeWithSelector(bytes4(keccak256("foo(uint256,string)")), 123, "hello");
    }


}