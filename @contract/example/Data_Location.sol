// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract dataLocation {
    struct MyStruct {
        uint num;
        string text;
    }

    mapping (address => MyStruct) public mystructs;

    function example() external {
        mystructs[msg.sender] = MyStruct( {num: 123, text: "bar"} );

        // MyStruct memory readOnly = mystructs[msg.sender]; // deep copy, won't change original
        MyStruct storage readOnly = mystructs[msg.sender]; // shadow copy, change original

        readOnly.num = 456;
    }
}
