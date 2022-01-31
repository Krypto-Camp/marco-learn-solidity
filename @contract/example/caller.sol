// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// caller 使用 call 呼叫 callee 的合約地址，
// 所有的改變都是在 callee 裡面。

contract callee {
    uint public x;
    address public owner;
    address public sender;

    constructor() { owner = msg.sender; } // owner: 部屬的人

    function inc() external returns (uint) {
        x++;
        sender = msg.sender; // sender is caller(0x1234...)

        return x;
    }
}

// caller address: 0x1234
contract caller {
    uint public x;

    function testCall(address _test) external returns (bool, bytes memory) {
        (bool _isOK, bytes memory _data) = _test.call(
            abi.encodeWithSignature("inc()")
        );
        return (_isOK, _data);
    }
}