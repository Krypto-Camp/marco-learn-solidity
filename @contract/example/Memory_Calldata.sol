// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract memoryVScalldata {
    string public text;

    // set this string: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

    // 89626 gas
    // calldata比較便宜，因為沒有複製到記憶體，只有呼叫
    function set(string calldata _text) external {
        text = _text;
    }

    // 90150 gas
    // memory比較貴，因為有複製到記憶體
    // function set(string memory _text) external {
    //     text = _text;
    // }


    // 28790 gas
    function get() external view returns (string memory) {
        return text;
    }

}