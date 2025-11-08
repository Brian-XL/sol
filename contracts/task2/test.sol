// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract A {
    function foo() public virtual pure returns(string memory) {
        return "A";
    }
}

contract B is A {
    function foo() public virtual override pure returns(string memory) {
        return "B";
    }
}

contract C is A {
    function foo() public virtual override pure returns(string memory) {
        return "C";
    }
}

contract D is B, C {
    function foo() public override(B, C) pure returns(string memory) {
        return super.foo();
    }
}