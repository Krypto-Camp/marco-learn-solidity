// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Homework2 {
    bool _isFreeze;
    address public owner;

    // 初始化
    constructor() {
        // init owner
        owner = msg.sender;
    }

    modifier onlyOwner() {
        // check owner or not
        require(msg.sender == owner, "you are not owner");
        _;
    }

    // 設定凍結
    function setFreeze(bool _x) external onlyOwner { _isFreeze = _x; }

    // 轉帳
    function sendEther(address payable _to) external payable onlyOwner {
        require(_isFreeze == false, "contract is freeze");
        _to.transfer(100);
    }

    // 終止合約
    function destroySmartContract(address payable _to) external onlyOwner {
        // 一旦呼叫了selfdestruct，合約地址將不再包含代碼
        selfdestruct(_to);
    }
}

