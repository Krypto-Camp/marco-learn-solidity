// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract A {
    string public name = "Contract A";

    function getName() public view returns (string memory) {
        return name;
    }
}

// Shadowing is disallowed in Solidity 0.6
// This will not compile
// contract B is A {
//     string public name = "Contract B";
// }

contract C is A {
    // error
    // string public name = "C";
    // name = "C"; 

    // This is the correct way to override inherited state variables.
    constructor() {
        name = "Contract C"; 
    }

    function setName() external {
        name = "C";
    }

    // C.getName returns "Contract C"
    // returns "Contract A", if del name = "Contract C"; 
}
