// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract dataStorage {

    uint[] public array;

    function test() external {
        // storage 的意思是 _array 指向 array，
        // 所以 _array 如果有更改，
        // array 也會更改。
        // shadow copy
        uint[] storage _array = array; 

        _array.push(1);
        _array.push(2);
        _array.push(3);
        _array.push(4);
    }
}
