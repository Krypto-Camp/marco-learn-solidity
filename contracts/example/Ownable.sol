// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ownable {
    address public owner;

    constructor() {
        // init owner
        owner = msg.sender;
    }

    modifier onlyOwner() {
        // check owner or not
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        // only owner can set new owner
        // address not 0
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external onlyOwner {
        // only owner can call
    }

    function andOneCanCall() external {
        //  anyone can call
    }
}