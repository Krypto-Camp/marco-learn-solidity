// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Homework2 {
    bool isStop;
    bool isFreeze;

    address public owner;

    modifier isStop() {
        require(!isPause, "paused");

    // init
    constructor() {
        owner = msg.sender;
        isStop = false;
        isFreeze = false;
    }

    
}