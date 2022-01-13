// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// NOTE: Do not use this code snippet, 
// it's incomplete and has a critical vulnerability!
// contract MyContract {
//     uint256 public x;

//     function initialize(uint256 _x) public {
//         x = _x;
//     }
// }


// good
// contract MyContract {
//     uint256 public x;
//     bool private initialized;

//     function initialize(uint256 _x) public {
//         require(!initialized, "Contract instance has already been initialized");
//         initialized = true;
//         x = _x;
//     }
// }


// Since this pattern is very common when writing upgradeable contracts, 
// OpenZeppelin Contracts provides an Initializable
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyContract is Initializable {
    uint256 public x;

    function initialize(uint256 _x) public initializer {
        x = _x;
    }
}
