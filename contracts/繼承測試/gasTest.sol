// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract gasTest {
    // spend 662 gas
    function test1(uint[20] memory a) public pure returns (uint) {
        return a[10] * 2;
    }

    // spend 317 gas
    function test2(uint[20] memory a) external pure returns (uint) {
        return a[10] * 2;
    }

    function test3(uint[20] memory a) internal pure returns (uint) {
        return a[10] * 2;
    }
    
    function test4(uint[20] memory a) private pure returns (uint) {
        return a[10] * 2;
    }
}