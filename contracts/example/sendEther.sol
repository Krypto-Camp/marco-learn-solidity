// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
3 way to send ETH
transfer - 2300 gas, revert
send - 2300 gas, return bool
call - all gas, returns bool and data
*/

contract sendEther {
    constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to, uint _amount) external payable {
        _to.transfer(_amount); // 32826 gas
    }

    function sendViaSend(address payable _to, uint _amount) external payable {
        bool sent = _to.send(_amount); // 32850 gas
        require(sent, "send fail");
    }

    function sendViaCall(address payable _to, uint _amount) external payable {
        // (bool success, bytes memory data) = _to.call{value: 123}(""); // bytes memory data can be omit
        (bool success, ) = _to.call{value: _amount}(""); //33078 gas
        require(success, "call fail");        
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}