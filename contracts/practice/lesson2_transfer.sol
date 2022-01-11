// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract practice2 {
    // mapping address(key: value)
    // Balances[address] = balance 
    mapping (address => uint) public Balances;

    // put money into contract
    function receiveMoney() external payable {
        Balances[msg.sender] += msg.value; // sender => money
    }

    // get money from contract
    function withdrawMoney(address payable _receiver, uint _amount) external {
        _receiver.transfer(_amount);
        Balances[_receiver] += _amount;
    }

    // get total money from contract
    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }
}