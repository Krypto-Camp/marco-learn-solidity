// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
Solidity 0.8 new feature
* custom error
*/

// custom error
error Unauthorized(address caller);

contract CustomError {
    address payable owner = payable(msg.sender);

    function withdraw() external {
        if (msg.sender != owner)
            // more error mesage more gas you spent
            // 23642 gas
            revert("error");
            // 23678 gas
            // revert("error error error error error error error error error error error");
            // 23692 gas
            // revert Unauthorized(msg.sender);

        owner.transfer(address(this).balance);
    }
}