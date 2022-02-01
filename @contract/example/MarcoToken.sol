// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
- 1. transfer
    Alice give 20 to Bob
    Alice -> contract : transfer(Bob, 20)

- 2. approve -> allownce -> transferFrom
    Bob withdraw 20 from Alice
    1. Alice -> contract : approve(Bob, 20)
    2. Bob   -> contract   : transferFrom(Alice, Bob, 20)
*/

contract MarcoToken is ERC20, ERC20Burnable, Ownable {
    constructor(string memory tokenName, 
                string memory symbolName,
                uint amount) 
                ERC20(tokenName, symbolName) {
        _mint(msg.sender, amount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}