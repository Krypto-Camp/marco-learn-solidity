// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract findMaxMin {
    /*
    Because the compiler cannot deduce the correct types of the array elements to match the array type
    */

    // int[] public errorIntArr = [1, 3, -10]; //fail compile
    int[] public intArr = [int(1), int(3), int(-10)];

    // uint[] public errorUintArry = [1, 5564, 546, 22222, uint(-21)];
    uint[] public UintArry = [1, 5564, 546, 22222, uint(21)];
}