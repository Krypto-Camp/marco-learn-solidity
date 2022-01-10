// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Modifier {
    bool public isPause;
    uint public count;

    // 1. modifier just like python decorator
    modifier checkPause() {
        require(!isPause, "paused"); // revert when isPause is True
        _; // _ is a wrapped function, and run it
    }

    function setPause(bool _paused) external { isPause = _paused; }

    function inc() external checkPause { count ++; }

    function dec() external checkPause { count --; }


    // 2. put var into modifier
    modifier cap(uint _x) { 
        require(_x < 100, "x >= 100");
        _;
    }

    function incBy(uint _x) external checkPause cap(_x) { 
        count += _x;
    }


    // 3. sandwich
    modifier sandwich() {
        rslt += 1;
        _;
        rslt = rslt * 2;
    }

    uint public rslt;

    function foo() external sandwich { 
        rslt += 10;
    }
}