// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
Solidity 0.8 new feature
* safe math
*/
contract safeMath {
    function testUnderFlow() external pure returns (uint) {
        uint8 x = 0;
        x--; // revert
        return x; 
    }

    function testUncheckedFlow() external pure returns (uint) {
        uint8 x = 0;
        unchecked { x--; } 
        return x; // x = 255
    }
}