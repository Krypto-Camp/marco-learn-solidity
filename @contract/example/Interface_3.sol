// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Counter.sol";

interface ICounter {
     function count() external view returns (uint);
     function inc() external;
}

contract callInterface {
    uint public count;

    Counter public c;

    function call() public {
        c = new Counter;
    }

    function example(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}