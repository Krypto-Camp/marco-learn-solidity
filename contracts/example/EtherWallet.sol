// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract EtherWallet {
    constructor() payable {}

    receive() external payable {}

    function withdraw(uint _amount) external {
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}