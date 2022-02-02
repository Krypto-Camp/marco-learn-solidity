// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/*
The main idea is padding. 
abi.encode uses padding while abi.encodePacked does not. 
Therefore, 
this could be seen from above as the first function "ExampleFunction" was unable to stringify an abi encoded string. 
As you may see here.
*/

contract concatenation {
    string public a;
    string public b;
    function Function () external {
        a = string(abi.encode("hello", " world"));
        b = string(abi.encodePacked("hello", " world"));
    }

    // a "Failed to decode output"
    // b string: hello world

   function Function2 () external {
        bool y = true;
        a = string(abi.encode(y, " world"));
        b = string(abi.encodePacked(y, " world"));
    }

    // a string: []@[] word
    // b string: [] world

    function Function3 () external {
        bool y = true;
        uint256 nonce = 123;
        a = string(abi.encode(y, nonce));
        b = string(abi.encodePacked(y, nonce));
    }

    // a string: []{
    // b string: []{
}