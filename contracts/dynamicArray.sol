// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract dynamicArray {

    function array() external pure returns (string[] memory) {
        string[] memory a = new string[](5); // create array in memory, only fixed size can be created

        a[0] = "marco";
        a[1] = "11";
        a[2] = "22";
        a[3] = "33";
        a[4] = "44";
        // a[5] = "55"; // <- error

        return a;
    }
}