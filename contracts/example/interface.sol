// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract Counter {
//     uint public count;

//     function inc() external {
//         count += 1;
//     }

//     function dec() external {
//         count -= 1;
//     }
// }


interface ICounter {
     function count() external view returns (uint);
     function inc() external;
}


// deploy contract Counter
// deploy callInterface
// and paste the address of "contract Counter" into example
contract callInterface {
    uint public count;

    function example(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}