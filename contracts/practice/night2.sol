// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract homework {

    // mapping address
    mapping (address => uint) public balancesReceived;

    // put money into contract
    function receiveMoney() external payable {
        balancesReceived[msg.sender] += msg.value;
    }

    // get money from contract
    function withdrawMoney(address payable _receiver, uint _amount) external {
        _receiver.transfer(_amount);
        balancesReceived[_receiver] += _amount;
    }

    // get total money from contract
    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }

}


