// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// Contract can call other contracts in 2 ways.
// The easiest way to is to just call it, like A.foo(x, y, z).
// Another way to call other contracts is to use the low-level call.
// This method is not recommended.

contract callOtherContract {
    // function setX(address _test, uint _x) external {
    //     testContract(_test).setX(_x);
    // } // easy to read

    function setX(testContract _test, uint _x) external {
        _test.setX(_x);
    }

    function getX(address _test) external view returns (uint x) {
        x = testContract(_test).getX();
    }

    function setXandReceiveEther(address _test, uint _x) external payable {
        testContract(_test).setXandReceiveEther{value: msg.value}(_x);
    }    

    function getXandValue(address _test) external view returns (uint x, uint value) {
        (x, value) = testContract(_test).getXandValue();
    }
}


// if you don't want to paste the code below,
// try Interface function.
contract testContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }

}