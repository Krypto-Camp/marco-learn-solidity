// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract transferMoney {

    // contract -> receiver
    function sendMoney(address payable _receiver, uint _amount) external {
        _receiver.transfer(_amount);
    }

    // msg.sender -> contract -> receiver
    function sendEther(address payable _receiver) external payable {
        _receiver.transfer(msg.value);
    }


}
