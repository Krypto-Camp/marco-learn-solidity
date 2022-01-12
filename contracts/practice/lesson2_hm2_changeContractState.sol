// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Homework2 {
    bool _isStop;
    bool _isFreeze;

    address public owner;

    // init
    constructor() {
        owner = msg.sender;
        isStop = false;
        isFreeze = false;
    }

    // chaget state
    function setStop() external { _isStop = true; }
    function offStop() external { _isStop = false; }
    function setFreeze() external { _isFreeze = true; }
    function offFreeze() external { _isFreeze = false; }

    function mint() external payable {
        require(isStop, "contract is stopped");
        require(isPause(), "contract is paused");
    
        // code here
    }

}

