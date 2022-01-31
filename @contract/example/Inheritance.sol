// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    function boo() public pure virtual returns (string memory) {
        return "boo_A";
    }
    function foo() public pure virtual returns (string memory) {
        return "foo_A";
    }

    function woo() public pure virtual returns (string memory) {
        return "woo_A";
    }
}

contract B is A {
    function boo() public pure override virtual returns (string memory) {
        return "boo_B";
    }
    function foo() public pure override returns (string memory) {
        return "foo_B";
    }
}

contract C is B {
    function boo() public pure override returns (string memory) {
        return "boo_C";
    }
}