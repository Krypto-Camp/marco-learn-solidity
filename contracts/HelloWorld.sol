// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.10 and less than 0.9.0
pragma solidity ^0.8.0;

contract HelloWorld {
    string public greet = "Hello World!";

    mapping (address => uint) public balances;

    uint public amount;
    address public address_;

    function foo() external payable {
        balances[msg.sender] += msg.value;
    }
}

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

0x17F6AD8Ef982297579C203069C1DbfFE4348c372