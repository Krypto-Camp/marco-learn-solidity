// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Account {
    address public bank;
    address public owner;
    
    constructor(address _owner) payable {
        bank = msg.sender; // AccountFactory address(同一間銀行的意思)
        owner = _owner; // 0x1234...asdf,
    }
}

contract AccountFactory {
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        Account account = new Account{value: 111}(_owner); // new Account: 產生一個新合約 0x1234...asdf
        accounts.push(account); // accounts = [0x1234...asdf, ]
    }
}