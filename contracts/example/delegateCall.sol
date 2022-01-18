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

// 部屬這 3 份合約
// V1 address: 0xaaaa...
// V2 address: 0xbbbb...
// DelegateCall.setVars(0xaaaa, 2) -> 2
// DelegateCall.setVars(0xbbbb, 2) -> 4
// 綁定合約地址做功能的更新

contract V1 {
    // 這裡的變數狀態不會改變
    // 更新此份合約，變數的順序不能更動，只能往下增加
    // 不然呼叫的合約會對不上
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract V2 {
    // 這裡的變數狀態不會改變
    // 更新此份合約，變數的順序不能更動，只能往下增加
    // 不然呼叫的合約會對不上
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num * 10; // upgrade
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    // 會按照記憶空間順序傳回來，不用相同名字，但順序一定要對
    uint public x; // x -> num
    address public y; // y -> msg.sender
    uint public z; // z -> msg.value

    function setVars(address _test, uint _num) external payable returns (bytes memory) {
        // (bool success, bytes memory data) = _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // ); 

        // better way
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(V1.setVars.selector, _num)
        );
        
        require(success, "delegatecall failed");
        
        return data;
    }
}