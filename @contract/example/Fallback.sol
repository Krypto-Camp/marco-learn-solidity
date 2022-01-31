// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Fallback executed when
- function doesn't exist
- directly send THE
*/

/*
Which function is called, fallback() or receive()?

           send Ether
               |
        is msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
*/

contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    fallback() external payable { 
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
}