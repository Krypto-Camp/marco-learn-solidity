// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
A calls B, send 100 wei
        B calls C, send 50 wei
A ---> B ---> C
                msg.sender = B
                msg.value = 50
                execute code on C's state variables
                use ETH in C

A calls B, send 100 wei
        B delegatecall C
A ---> B ---> C
                msg.sender = A
                msg.value = 100
                execute code on B's state variables
                use ETH in B
*/

contract TestDelegateCall {
    // 這裡的變數狀態不會改變
    // 更新此份合約，變數的順序不能更動，只能往下增加
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        // num = _num;
        num = 2 * _num; // upgrade
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    // 會按照記憶空間順序傳回來，不用相同名字，但順序一定要對
    uint public x; // x -> num
    address public y; // y -> msg.sender
    uint public z; // z -> msg.value

    function setVars(address _test, uint _num) external payable {
        // _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // );

        // better way
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        
        require(success, "delegatecall failed");
    }
}