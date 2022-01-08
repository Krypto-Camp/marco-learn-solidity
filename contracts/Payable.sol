// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;

contract Payable {
    
    // **fail**
    // function sendEther(address payable recipient) external payable {
    //     recipient.transfer(1 ether);
    // }

    // Contract cannot take ethers from wallet address and transfer it, 
    // you need to pass the amount you wish to transfer as VALUE. Then your code should look like this:
    function sendEther(address payable recipient) external payable {
        recipient.transfer(msg.value);
    }

}
